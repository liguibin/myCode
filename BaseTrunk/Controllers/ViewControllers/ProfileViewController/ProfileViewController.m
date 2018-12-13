//
//  ProfileViewController.m
//  BaseTrunk
//
//  Created by king on 2018/12/12.
//  Copyright © 2018 wang yong. All rights reserved.
//

#import "ProfileViewController.h"
#import "WYSettingViewController.h"
#import "ProfileHeaderView.h"

@interface ProfileViewController ()

@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, assign) CGRect originalFrame;
@property (nonatomic, strong) ProfileHeaderView *tableHeaderView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_set"] style:UIBarButtonItemStylePlain target:self action:@selector(clickRightBarButtonItem)];
    [self addTableViewHeader];
}

- (void)addTableViewHeader
{
    [self.tableView setTableHeaderView:self.tableHeaderView];
}

- (ProfileHeaderView *)tableHeaderView
{
    if (_tableHeaderView) {
        _tableHeaderView = [[ProfileHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, [ProfileHeaderView getHeaderHeight])];
    }
    
    return _tableHeaderView;
}

- (void)clickRightBarButtonItem
{
    WYSettingViewController *settingViewController = [WYSettingViewController new];
    [self.navigationController pushViewController:settingViewController animated:YES];
}

//- (UIImage *)imageWithColor:(UIColor *)color
//{
//    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [color CGColor]);
//    CGContextFillRect(context, rect);
//    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    return theImage;
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat yOffset = scrollView.contentOffset.y;
//    CGFloat offsetToShow = ScreenWidth * 280. / 375. - YCNavbar_Height;
//    NSLog(@"%f", scrollView.contentOffset.y);
//    if (scrollView.contentOffset.y > offsetToShow) {
//        CGFloat alpha = (scrollView.contentOffset.y - offsetToShow) / (2*YCNavbar_Height);
//        if (alpha >= 0 && alpha <= 1)
//        {
//            self.title = @"我";
//            [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor colorFromHexString:@"#212121" withAlpha:alpha]] forBarMetrics:UIBarMetricsDefault];
//            self.navigationController.navigationBar.tintColor = [UIColor colorWithWhite:0 alpha:alpha];
//            [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0 alpha:alpha]}];
//        }
//    } else {
//        self.title = @"";
//        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//        [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor colorFromHexString:@"#212121" withAlpha:0.]] forBarMetrics:UIBarMetricsDefault];
//    }
//
//    // 往上滑动效果、处理放大效果
//    if (yOffset > 0) {
//        self.bgView.frame = ({
//            CGRect frame = self.bgView.frame;
////            frame.origin.y = self.originalFrame.origin.y - yOffset;
//            frame.origin.y = 0;
//            frame;
//        });
//    } else { // 往下移动，放大效果
//        self.bgView.frame = ({
//            CGRect frame = self.originalFrame;
//            frame.size.height = self.originalFrame.size.height - yOffset;
//            frame.size.width = frame.size.height/(ScreenWidth / 160.);
//            frame.origin.x = self.originalFrame.origin.x - (frame.size.width - self.originalFrame.size.width)/2;
//            frame;
//        });
//    }
//}
- (id)paramsObject:(BOOL)more
{
    return nil;
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
