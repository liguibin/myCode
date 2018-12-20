//
//  MZProfileViewController.m
//  BaseTrunk
//
//  Created by king on 2018/12/12.
//  Copyright © 2018 wang yong. All rights reserved.
//

#import "MZProfileViewController.h"
#import "MZSettingViewController.h"
#import "MZProfileHeaderView.h"
#import "MZUserProfileController.h"

@interface MZProfileViewController ()

@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, assign) CGRect originalFrame;
@property (nonatomic, strong) MZProfileHeaderView *tableHeaderView;
@property (nonatomic, retain) MZVideoListInfoObject *videoListInfoObject;

@end

@implementation MZProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_set"] style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBarButtonItem)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_set"] style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBarButtonItem)];
    [self addTableViewHeader];
}

- (void)addTableViewHeader
{
    [self.tableView setTableHeaderView:self.tableHeaderView];
}

- (MZProfileHeaderView *)tableHeaderView
{
    if (!_tableHeaderView) {
        _tableHeaderView = [[MZProfileHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, [MZProfileHeaderView getHeaderHeight])];
    }
    
    return _tableHeaderView;
}

- (void)requestDidFinishLoad:(id)data
{
    [super requestDidFinishLoad:data];
    if ([self arrangedObjects] && [self countOfArrangedObjects]) {
        id object = [[self arrangedObjects] firstObject];
        if (object && [object isKindOfClass:[NSDictionary class]]) {
            if (!self.videoListInfoObject) {
                self.videoListInfoObject = [MZVideoListInfoObject new];
            }
            if (object && [self.videoListInfoObject parseData:object]) {
                [self.tableHeaderView setObjectWithObejct:object];
            }
        }
    }
}

- (void)clickLeftBarButtonItem
{
    MZUserProfileController *userProfileController = [MZUserProfileController new];
    [self.navigationController pushViewController:userProfileController animated:YES];
}

- (void)clickRightBarButtonItem
{
    MZSettingViewController *settingViewController = [MZSettingViewController new];
    [self.navigationController pushViewController:settingViewController animated:YES];
}

- (id)paramsObject:(BOOL)more
{
    MZVideoListObject *videoListObejct = [MZVideoListObject new];
    videoListObejct.pageSize = 20;
    videoListObejct.page = 0;
    return videoListObejct;
}

#pragma mark - scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [super scrollViewDidScroll:scrollView];
    CGFloat offsetY = scrollView.contentOffset.y;
//    if (offsetY < 0) {
//        CGRect rect = self.tableHeaderView.frame;
//        rect.origin.y = offsetY;
//        rect.size.height = self.tableHeaderView.height - offsetY;
//        self.tableHeaderView.backgroundView.frame = rect;
//    }
    if (offsetY < 0)
    {
        CGRect rect = self.tableHeaderView.frame;
        //下拉的偏移量;
        CGFloat offsetY = (scrollView.contentOffset.y + scrollView.contentInset.top) * -1;
        rect.origin.y = -offsetY * 1;
        rect.origin.x = -offsetY / 2;
        rect.size.width = self.tableHeaderView.width + offsetY;
        rect.size.height = 200 + offsetY;
        self.tableHeaderView.backgroundView.frame = rect;
    }
}

- (Class)cellClass
{
    return [UITableViewCell class];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
