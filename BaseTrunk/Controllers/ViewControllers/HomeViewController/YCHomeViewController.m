//
//  HomeViewController.m
//  BaseTrunk
//
//  Created by king on 2018/12/10.
//  Copyright © 2018 wang yong. All rights reserved.
//

#import "YCHomeViewController.h"
#import "HMSegmentedControl.h"
#import "RecommendViewController.h"
#import "NearbyViewController.h"

@interface YCHomeViewController ()

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (nonatomic, strong) RecommendViewController *recommendViewController;
@property (nonatomic, strong) NearbyViewController *nearbyViewController;
@property (nonatomic, strong) UIViewController *tempViewController;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation YCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = self.segmentedControl;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"8"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"8"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self addChildViewController];
}

- (void)navigationBarTranslucent:(BOOL)translucent
{
    if (translucent) {
        [self.navigationController.navigationBar setTranslucent:YES];
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"translate"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    } else {
        [self.navigationController.navigationBar setTranslucent:NO];
    }
}

- (void)leftBarButtonItemClick
{
    
}

- (void)rightBarButtonItemClick
{
    [self.recommendViewController changeShowType:self.navigationController.navigationBar.translucent ? ShowTypeGrid : ShowTypeList];
    [self navigationBarTranslucent:!self.navigationController.navigationBar.translucent];
}

- (void)addChildViewController
{
    self.recommendViewController = [RecommendViewController new];
    self.nearbyViewController = [NearbyViewController new];
    
    [self addChildViewController:_recommendViewController];
    [self addChildViewController:_nearbyViewController];
    
    [_recommendViewController didMoveToParentViewController:self];
    [_nearbyViewController didMoveToParentViewController:self];
    
    _tempViewController = _recommendViewController;
    self.selectedIndex = 0;
    [self transitionFromViewController:_tempViewController toViewController:_tempViewController duration:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
    } completion:^(BOOL finished) {
        [self.view addSubview:_tempViewController.view];
    }];
}

- (HMSegmentedControl*)segmentedControl
{
    if (!_segmentedControl) {
        NSArray *segmentedArray = [[NSArray alloc] initWithObjects:(@"推荐"), (@"附近"), nil];
        self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:segmentedArray];
        _segmentedControl.frame = CGRectMake((ScreenWidth - 100.)/2, 20. + YCNavbar_DiffH, 100., 30.);
        _segmentedControl.backgroundColor = [UIColor clearColor];
        _segmentedControl.verticalDividerEnabled = YES;
        _segmentedControl.verticalDividerColor = [UIColor whiteColor];
        _segmentedControl.verticalDividerWidth = 0.5f;
        [_segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
        
        _segmentedControl.selectedSegmentIndex = 0;
        _segmentedControl.titleTextAttributes = @{ NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:14.] };
        _segmentedControl.selectedTitleTextAttributes = @{ NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:16.] };
        _segmentedControl.selectionIndicatorColor = [UIColor whiteColor];
        _segmentedControl.selectionIndicatorHeight = 1.0f;
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        _segmentedControl.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 8);
    }
    
    return _segmentedControl;
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmented
{
    WYTableApiViewController *newViewController = [self.childViewControllers objectAtIndex:self.segmentedControl.selectedSegmentIndex];
    [self transitionFromViewController:_tempViewController toViewController:newViewController duration:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
    } completion:^(BOOL finished) {
        [self.view addSubview:newViewController.view];
        self.tempViewController = newViewController;
    }];
    
    if (segmented.selectedSegmentIndex == 1) {
        self.navigationItem.rightBarButtonItem = nil;
        [self navigationBarTranslucent:NO];
    } else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"8"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
        if (self.recommendViewController.showType == ShowTypeList) {
            [self navigationBarTranslucent:YES];
        }
    }
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
