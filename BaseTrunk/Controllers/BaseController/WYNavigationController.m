//
//  WYNavigationController.m
//  BaseTrunk
//
//  Created by wangyong on 15/8/8.
//  Copyright (c) 2015年 wang yong. All rights reserved.
//

#import "WYNavigationController.h"

@implementation WYNavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    
    if(self)
    {
        self.interactivePopGestureRecognizer.delegate = (id)self;
        self.delegate = (id)self;
        [self.navigationBar setTranslucent:NO];
    }
    return [WYNavigationController customNavigationController:self];
}
    
+ (id)customNavigationController:(UINavigationController *)navigationController
{
    navigationController.navigationBar.tintColor = [UIColor whiteColor];
    navigationController.navigationBar.barTintColor = [UIColor colorFromHexString:@"#212121" withAlpha:1.];

    [navigationController.navigationBar setTranslucent:NO];
    [navigationController.navigationBar setShadowImage:[UIImage new]];

    if (navigationController.tabBarItem.title) {
        NSDictionary *navibarTextDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],  NSForegroundColorAttributeName, [UIFont systemFontOfSize:16.], NSFontAttributeName,nil];
        navigationController.navigationBar.titleTextAttributes = navibarTextDic;
        
        [navigationController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.85 alpha:1.], NSFontAttributeName:[UIFont systemFontOfSize:16.]} forState:UIControlStateNormal];
        [navigationController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:16.]} forState:UIControlStateSelected];
        [navigationController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -14.)];
    }
    return navigationController;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.viewControllers.count <= 1) {
        return false;
    }
    return true;
}

- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return self.topViewController.preferredInterfaceOrientationForPresentation;
    return UIInterfaceOrientationPortrait;
}

@end
