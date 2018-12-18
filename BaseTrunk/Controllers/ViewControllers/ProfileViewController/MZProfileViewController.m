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
#import "MZVideoListObject.h"

@interface MZProfileViewController ()

@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, assign) CGRect originalFrame;
@property (nonatomic, strong) MZProfileHeaderView *tableHeaderView;

@end

@implementation MZProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
        id headerDic = [[self arrangedObjects] firstObject];
        if (headerDic && [headerDic isKindOfClass:[NSDictionary class]]) {
            [self.tableHeaderView setObjectWithObejct:headerDic];
        }
    }
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
