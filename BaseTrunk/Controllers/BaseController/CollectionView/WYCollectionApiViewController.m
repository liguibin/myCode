//
//  WYCollectionApiViewController.m
//  BaseTrunk
//
//  Created by wangyong on 15/8/6.
//  Copyright (c) 2015年 wang yong. All rights reserved.
//

#import "WYCollectionApiViewController.h"
#import "WYCollectionViewGridLayout.h"
#import "WYCollectViewCellDelegate.h"
#import "WYFileClient.h"

@interface WYCollectionApiViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation WYCollectionApiViewController

#pragma mark - must override

- (UICollectionViewLayout *)layout
{
    NSAssert(NO, @"the method \"layout\" Must be rewritten");
    return NULL;
}

- (Class)cellClass
{
    NSAssert(NO, @"the method \"cellClass\" Must be rewritten");
    return NULL;
}

#pragma mark - error
- (NSString *)errorDescription
{
    return @"";
}

- (NSString *)errorDetailString
{
    return @"";
}

- (NSString *)errorImageName
{
    return @"";
}

#pragma mark - subview
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupCollectView];
    [self setupData];
}

- (void)setupCollectView
{
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
    [_collectionView registerClass:[self cellClass] forCellWithReuseIdentifier:NSStringFromClass([self cellClass])];
    [_collectionView setDelegate:self];
    [_collectionView setDataSource:self];
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_collectionView];
    
    if (@available(iOS 11.0, *)) {
        [self.collectionView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    } else {
        // Fallback on earlier versions
                self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self activityIndicatorAnimal:YES];
    [self setEnableHeader:YES];
    // setup infinite scrolling
    __block typeof(self) block_self = self;
    [self.collectionView addInfiniteScrollingWithActionHandler:^{
        [block_self reloadFooterTableViewDataSource];
    }];
}

- (WYErrorView *)errorView
{
    if(!_errorView)
    {
        _errorView = [[WYErrorView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.width)];
        [self.collectionView addSubview:_errorView];
        [_errorView setCenterX:self.view.centerX];
        [_errorView setCenterY:(self.view.height - 20.) / 2. - 20.];
        [_errorView setBackgroundColor:_collectionView.backgroundColor];
    }
    
    return _errorView;
}

- (void)updateErrorDescription
{
    NSString *description = [self errorDescription];
    NSString *detailString = [self errorDetailString];
    
    if(description && description.length > 0)
    {
        [self.errorView setText:description detailText:detailString imageName:[self errorImageName]];
    }
    else
    {
        [self.errorView setText:NSLocalizedString(@"no data",nil) detailText:detailString imageName:[self errorImageName]];
    }
}

- (UIActivityIndicatorView *)activityIndicator
{
    if(!_activityIndicator)
    {
        // Do any additional setup after loading the view.
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        [_activityIndicator setHidesWhenStopped:YES];
        [_activityIndicator setCenterX:self.view.centerX];
        [_activityIndicator setCenterY:(self.view.height - 20)/2-20];
        [_collectionView addSubview:_activityIndicator];
        [self activityIndicatorAnimal:YES];
    }
    
    return _activityIndicator;
}

- (void)activityIndicatorAnimal:(BOOL)animal
{
    if(animal)
    {
        [self.activityIndicator startAnimating];
    }
    else
    {
        [self.activityIndicator stopAnimating];
    }
}

#pragma mark - subview method

- (CGFloat)headerHeight
{
    return 0;
}

- (void)setEnableHeader:(BOOL)tf
{
    _enableHeader = tf;
    if (tf) {
        if (!self.refresh || !self.refresh.superview) {
            self.refresh = [UIRefreshControl new];
            [_refresh addTarget:self action:@selector(refreshTableView:) forControlEvents:UIControlEventValueChanged];
            _refresh.tintColor = [UIColor black75PercentColor];
            [_collectionView addSubview:_refresh];
        }
    } else {
        if (self.refresh && self.refresh.superview) {
            [self.refresh removeFromSuperview];
        }
    }
}

- (void)setEnableFooter:(BOOL)tf
{
    _enableFooter = tf;
    [_collectionView.infiniteScrollingView setEnabled:tf];
}

#pragma mark - request response

- (void)activeRefresh
{
    [_collectionView setContentOffset:CGPointMake(0, -([_collectionView contentInset].top +60)) animated:NO];
    [self.refresh beginRefreshing];
    [self refreshTableView:self.refresh];
    _headerLoading = YES;
}

- (void)setupData
{
    //取缓存
    id cache = [self searchCache];
    if (cache && [cache isKindOfClass:[NSArray class]]) {
        //有缓存
        [self reloadWithCache:[[NSMutableArray alloc] initWithArray:cache]];
    } else {
        //无缓存
        [self reloadData];
    }
}

- (void)reloadData
{
    self.loadmore = [NSNumber numberWithBool:NO];
    [super reloadData];
}

- (void)startLoadData:(NSNumber *)loadHeader
{
    [super startLoadData:loadHeader];
}

- (void)reloadWithCache:(id)cache
{
    [self didFinishLoad:cache];
    [self refreshTableView:nil];
}

- (void)didFinishLoad:(id)array
{
    [self dealFinishLoad:array];
    [super didFinishLoad:array];
    [_collectionView reloadData];
}

- (void)refreshTableView:(UIRefreshControl *)refresh
{
    [self performSelector:@selector(reloadHeaderTableViewDataSource) withObject:nil afterDelay:0.0];
}

- (void)dealFinishLoad:(id)array
{
    //存储缓存
    if (self.loadmore == [NSNumber numberWithBool:NO]) {
        if (array) {
            [self setCache:array];
        }
    }
    
    if(self.activityIndicator)
    {
        [self activityIndicatorAnimal:NO];
    }
    
    [self.errorView setHidden:YES];
    [self setEnableFooter:YES];
    
    if([(NSArray*)array count] == 0)
    {
        if([self arrangedObjects] == nil)
        {
            //list 为空
            
            [self updateErrorDescription];
            [_collectionView reloadData];
            [self setEnableFooter:NO];
            
            if(_headerLoading)
            {
                [self clearArrangedObjects];
                [self performSelector:@selector(finishLoadHeaderTableViewDataSource) withObject:nil afterDelay:0.01];
            }
            return;
        }
    }
    
    if ([(NSArray*)array count] < [self getPageSize])
    {
        self.hasMore = NO;
//        [self.loadMoreFooterView setPWState:PWLoadMoreDone];
        [self setEnableFooter:NO];
    } else {
        self.hasMore = YES;
        [self setEnableFooter:YES];
    }
    
    if(_footerLoading)
    {
        [self performSelector:@selector(finishLoadFooterTableViewDataSource) withObject:nil afterDelay:0.01];
    }
    
    if(_headerLoading)
    {
        [self clearArrangedObjects];
        [self performSelector:@selector(finishLoadHeaderTableViewDataSource) withObject:nil afterDelay:0.01];
    }
}

- (void)didFailWithError:(NSError *)error
{
    if(self.activityIndicator)
    {
        [self activityIndicatorAnimal:NO];
    }
    
    if(_footerLoading)
    {
        [self performSelector:@selector(finishLoadFooterTableViewDataSource) withObject:nil afterDelay:0.01];
    }
    
    if(_headerLoading)
    {
        [self performSelector:@selector(finishLoadHeaderTableViewDataSource) withObject:nil afterDelay:0.01];
    }
    
    [self setEnableFooter:NO];
    [self.errorView setHidden:YES];
    
    NSString *strFailText = NSLocalizedString(@"networking_disconnect",nil);
    if ([error.domain isEqualToString:ERROR_DOMAIN]) {
        strFailText = [[error.userInfo objectForKey:@"reason"] objectForKey:@"data"];
    } else {
        if([[WYFileClient sharedInstance] getNetworkingType] == 0) {
            strFailText = NSLocalizedString(@"networking_disconnect",nil);
        } else if(error.code == -1001) {
            strFailText = NSLocalizedString(@"networking_timeout",nil);
        } else if(error.code == -1202) {
            //过滤https证书得错误
            strFailText = nil;
        } else if(error.localizedDescription) {
            strFailText = error.localizedDescription;
        }
    }
    
    if([self countOfArrangedObjects] > 0)
    {
        if(strFailText)
        {
            [SVProgressHUD showErrorWithStatus:strFailText];
        }
    }
    else
    {
        [self.errorView setText:strFailText detailText:@"" imageName:[self errorImageName]];
    }
}

#pragma mark - UICollectionView delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self countOfArrangedObjects];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor greenColor]];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self cellClass]) forIndexPath:indexPath];
    
    [self setDisplayCell:cell cellForRowAtIndexPath:indexPath];
    return cell;
}

- (void)setDisplayCell:(id)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setObject:)]) {
        if([self countOfArrangedObjects] > indexPath.row)
        {
            id item = [self objectInArrangedObjectAtIndexPath:indexPath];
            [cell setObject:item];
        }
    }
}

#pragma mark - fresh delegate

- (void)reloadHeaderTableViewDataSource
{
    if([self.activityIndicator isAnimating])
    {
        return;
    }
    _headerLoading = YES;
    self.loadmore = [NSNumber numberWithBool:NO];
    if ([self respondsToSelector:@selector(startLoadData:)] == YES) {
        [NSThread detachNewThreadSelector:@selector(startLoadData:)
                                 toTarget:self
                               withObject:self.loadmore];
    }
}

- (void)reloadFooterTableViewDataSource
{
    _footerLoading = YES;
    self.loadmore = [NSNumber numberWithBool:YES];
    if ([self respondsToSelector:@selector(startLoadData:)] == YES) {
        [NSThread detachNewThreadSelector:@selector(startLoadData:)
                                 toTarget:self
                               withObject:self.loadmore];
    }
}

- (void)finishLoadHeaderTableViewDataSource
{
    _headerLoading = NO;
    if([self.refresh respondsToSelector:@selector(endRefreshing)])
        [self.refresh performSelectorOnMainThread:@selector(endRefreshing) withObject:nil waitUntilDone:NO];
    [UIView animateWithDuration:0.25 animations:^{
        [_collectionView setContentOffset:CGPointMake(0, 0) animated:NO];
    }];
}

- (void)finishLoadFooterTableViewDataSource
{
    _footerLoading = NO;
    __weak typeof(self) weakSelf = self;
    int64_t delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf.collectionView.infiniteScrollingView stopAnimating];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
