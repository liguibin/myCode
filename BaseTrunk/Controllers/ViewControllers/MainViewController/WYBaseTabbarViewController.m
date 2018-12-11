//
//  WPBaseTabbarViewController
//  BaseTrunk
//
//  Created by wangyong on 15/8/8.
//  Copyright (c) 2015年 wang yong. All rights reserved.
//

#import "WYBaseTabbarViewController.h"
#import "WYNavigationController.h"

@implementation WYBaseTabbarViewController

- (id)viewControllerWithTabTitle:(NSString *)title image:(UIImage *)image finishedSelectedImage:(UIImage *)finishedSelectedImage viewClass:(NSString *)viewClass
{
    Class viewControllerClass = NSClassFromString(viewClass);
    UIViewController *viewController = [[viewControllerClass alloc] init];
    viewController.title = title;
    
//    if(image){
//        [viewController.tabBarItem setImageInsets:UIEdgeInsetsMake(6, 0, -6, 0)];
//        [viewController.tabBarItem setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    }
//    
//    if(finishedSelectedImage){
//        [viewController.tabBarItem setSelectedImage:[finishedSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    }
    
    WYNavigationController *navigationController = [[WYNavigationController alloc] initWithRootViewController:viewController];
    navigationController.navigationBar.barTintColor = [UIColor blackColor];
    NSDictionary *navibarTextDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:17.], NSFontAttributeName,nil];
    navigationController.navigationBar.titleTextAttributes = navibarTextDic;
    
    navigationController.tabBarItem.title = title;
    if (navigationController.tabBarItem.title)
    {
        [navigationController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.85 alpha:1.], NSFontAttributeName:[UIFont systemFontOfSize:16.]} forState:UIControlStateNormal];
        [navigationController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:16.]} forState:UIControlStateSelected];
        [navigationController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -14.)];
    }
    
    return navigationController;
}

- (UIViewController*)viewControllerWithSubClass:(NSString*)viewClass
{   
    Class viewControllerClass = NSClassFromString(viewClass);
    UIViewController* viewController = [[viewControllerClass alloc] init];
    return viewController;
}

- (void)addCenterButtonWithImage:(UIImage *)buttonImage highlightImage:(UIImage *)highlightImage action:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    button.frame = CGRectMake(ScreenWidth/[self.viewControllers count], 0, ScreenWidth/[self.viewControllers count], self.tabBar.height);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setImage:highlightImage forState:UIControlStateHighlighted];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchDown];
    [self.tabBar addSubview:button];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate
{
    return YES;
}

@end
