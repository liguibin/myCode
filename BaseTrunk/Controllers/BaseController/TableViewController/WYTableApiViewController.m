//
//  WYTableApiViewController.m
//  BaseTrunk
//
//  Created by wangyong on 15/8/8.
//  Copyright (c) 2015年 wang yong. All rights reserved.
//

#import "WYTableApiViewController.h"
#import "WYTableCellDelegate.h"
#import "WYFileClient.h"


@interface WYTableApiViewController()

@property (nonatomic, strong) PWLoadMoreTableFooterView *tableFooterView;
@property (nonatomic, assign) BOOL enableHeader;
@property (nonatomic, assign) BOOL enableFooter;
@property (nonatomic, assign) BOOL hasMore;
@property (nonatomic, strong) NSNumber *loadmore;
@property (nonatomic, strong) UIRefreshControl *refresh;

- (void)setupSubviews;
- (void)setupTableView;
- (void)reloadHeaderTableViewDataSource;
- (void)reloadFooterTableViewDataSource;
- (void)finishLoadHeaderTableViewDataSource;
- (void)finishLoadFooterTableViewDataSource;
- (void)refreshTableView;

@end

@implementation WYTableApiViewController

- (Class)cellClass {
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([self needTableReload])
    {
        [_tableView reloadData];
    }
}

- (BOOL)needTableReload
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupSubviews];
    [self setupData];
}

- (void)setupSubviews
{
    [self setupTableView];
}

- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:[self getTableViewStyle]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin;
    _tableView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_tableView];
    
    if (@available(iOS 11.0, *)) {
        [self.tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    } else {
        // Fallback on earlier versions
        //        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    _headerLoading = NO;
    _footerLoading = NO;
    _hasMore = NO;
    
    // Do any additional setup after loading the view.
    [self activityIndicatorAnimal:YES];
    [self setEnableHeader:YES];
    [self setEnableFooter:NO];
}

- (PWLoadMoreTableFooterView *)tableFooterView
{
    if(!_tableFooterView)
    {
        _tableFooterView = [PWLoadMoreTableFooterView new];
        _tableFooterView.delegate = self;
        [_tableFooterView setPWState:PWLoadMoreNormal];
    }
    
    return _tableFooterView;
}

- (WYErrorView *)errorView
{
    if(!_errorView)
    {
        _errorView = [[WYErrorView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.width)];
        [self.tableView addSubview:_errorView];
        [_errorView setCenterX:self.tableView.centerX];
        [_errorView setCenterY:(_tableView.height - [self headerHeight] - 20.) / 2. - 20.];
        [_errorView setBackgroundColor:_tableView.backgroundColor];
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
        [_activityIndicator setCenterX: _tableView.width/2];
        [_activityIndicator setCenterY: _tableView.tableHeaderView.height + (_tableView.height - _tableView.tableHeaderView.height)/2 + [self headerHeight]];
        [self.tableView addSubview:_activityIndicator];
        [self activityIndicatorAnimal:YES];
    }
    
    return _activityIndicator;
}

#pragma mark - subview method

- (UITableViewStyle)getTableViewStyle
{
    return UITableViewStylePlain;
}

- (void)setSeparatorClear
{
    [_tableView setSeparatorColor:[UIColor clearColor]];
}

- (CGFloat)headerHeight
{
    return 0;
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

- (void)setEnableHeader:(BOOL)tf
{
    _enableHeader = tf;
    if (tf) {
        if (!self.refresh || !self.refresh.superview) {
            self.refresh = [UIRefreshControl new];
            [_refresh addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
            _refresh.tintColor = [UIColor black75PercentColor];
            if (@available(iOS 10.0, *)) {
                [_tableView setRefreshControl:_refresh];
            } else {
                [_tableView addSubview:_refresh];
            }
            [_refresh setAutoresizingMask:(UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin)];
            [[_refresh.subviews objectAtIndex:0] setTop:iphoneX? 5:0];
        }
    } else {
        if (@available(iOS 10.0, *)) {
            [_tableView setRefreshControl:nil];
        } else {
            if (self.refresh && self.refresh.superview) {
                [self.refresh removeFromSuperview];
            }
        }
    }
}

- (void)setEnableFooter:(BOOL)tf
{
    _enableFooter = tf;
    if (tf) {
        [self.tableFooterView setPWState:PWLoadMoreNormal];
        self.tableView.tableFooterView = self.tableFooterView;
    } else {
        self.tableView.tableFooterView = nil;
    }
}

- (void)setFooterViewWithCustom:(BOOL)need
{
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 66)];
}

#pragma mark - request response

- (void)activeRefresh
{
    [_tableView setContentOffset:CGPointMake(0, -([_tableView contentInset].top +60)) animated:NO];
    [self.refresh beginRefreshing];
    [self refreshTableView];
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
    [self refreshTableView];
}

- (void)didFinishLoad:(id)array
{
    [self dealFinishLoad:array];
    [super didFinishLoad:array];
    [_tableView reloadData];
}

- (void)refreshTableView
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
    
    if(![self.errorView isHidden])
    {
        [self.errorView setHidden:YES];
    }
    
    [self setEnableFooter:YES];
    
    if([(NSArray*)array count] == 0)
    {
        if([self arrangedObjects] == nil)
        {
            //list 为空
            [self updateErrorDescription];
            [_tableView reloadData];
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
        [self.tableFooterView setPWState:PWLoadMoreNormal];
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
    
    NSString *strFailText = NSLocalizedString(@"networking_disconnect", nil);
    if ([error.domain isEqualToString:ERROR_DOMAIN]) {
        strFailText = [[error.userInfo objectForKey:@"reason"] objectForKey:@"data"];
    } else {
        if([[WYFileClient sharedInstance] getNetworkingType] == 0) {
            strFailText = NSLocalizedString(@"networking_timeout", nil);
        } else if(error.code == -1001) {
            strFailText = NSLocalizedString(@"networking_timeout", nil);
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

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self countOfArrangedObjects];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([self countOfArrangedObjects] > indexPath.row)
    {
        id item = [self objectInArrangedObjectAtIndexPath:indexPath];
        
        Class cls = [self cellClass];
        if ([cls respondsToSelector:@selector(rowHeightForObject:)]) {
            return [cls rowHeightForObject:item];
        }
    }
    return tableView.rowHeight; // failover
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Class cls = [self cellClass];
    NSString *identifier = (indexPath.row/2==0)?@"Cell":@"CELL";
    id cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[cls alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([[WYFileClient sharedInstance] getNetworkingType] > 0)
    {
        CGPoint offset = scrollView.contentOffset;
        CGRect bounds = scrollView.bounds;
        CGSize size = scrollView.contentSize;
        UIEdgeInsets inset = scrollView.contentInset;
        float y = offset.y + bounds.size.height - inset.bottom;
        float h = size.height;
        
        float reload_distance = 10;
        if(y > h + reload_distance) {
            if (self.enableFooter && !_footerLoading && self.hasMore) {
                [NSThread detachNewThreadSelector:@selector(startLoadMore) toTarget:self.tableFooterView withObject:nil];
            } else {

            }
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //勿删
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //勿删
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //勿删
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    //勿删
    return YES;
}

#pragma mark - fresh delegate

- (void)pwLoadMore
{
    [self reloadFooterTableViewDataSource];
}

- (BOOL)pwLoadMoreTableDataSourceAllLoaded
{
    return !self.hasMore;
}

- (BOOL)pwLoadMoreTableDataSourceIsLoading
{
    return _footerLoading;
}

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
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];

    }];
}

- (void)finishLoadFooterTableViewDataSource
{
    _footerLoading = NO;
    if([self.tableFooterView respondsToSelector:@selector(pwLoadMoreTableDataSourceDidFinishedLoading)]){
    [self.tableFooterView performSelectorOnMainThread:@selector(pwLoadMoreTableDataSourceDidFinishedLoading) withObject:nil waitUntilDone:NO];
    }
}

- (void)dealloc
{
    self.tableFooterView.delegate = nil;
    self.tableFooterView = nil;
    self.errorView = nil;
    self.activityIndicator = nil;
    self.loadmore = nil;
    self.refresh = nil;

    [_tableView setDataSource:nil];
    [_tableView setDelegate:nil];
    _tableView = nil;
}

@end
