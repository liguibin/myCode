//
//  WYMainAppViewController.m
//  BaseTrunk
//
//  Created by wangyong on 15/8/8.
//  Copyright (c) 2015年 wang yong. All rights reserved.
//

#import "WYMainAppViewController.h"
#import "WYUserInfoObject.h"
#import "WYItemParseBase.h"
#import "WYSocketObject.h"

@interface WYMainAppViewController()<WYSocketObjectDelegate>
@end

@implementation WYMainAppViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setDelegate:self];
    self.viewControllers = [NSArray arrayWithObjects:
                            [self viewControllerWithTabTitle:(@"首页") image:nil finishedSelectedImage:nil viewClass:@"YCHomeViewController"],
                            [self viewControllerWithTabTitle:@"消息" image:nil finishedSelectedImage:nil viewClass:@"ChatListViewController"],
                            [self viewControllerWithTabTitle:(@"我的") image:nil finishedSelectedImage:nil viewClass:@"ProfileViewController"],
                            nil];
    
    //    [self addCenterButtonWithImage:[[UIImage imageNamed:@"tabbar_whisper"] imageWithColor:[UIColor appleRedColor]] highlightImage:nil callback:@selector(addCenterButtonTouchDown:)];
    
//    self.tabBar.tintColor = [UIColor redColor];
    self.tabBar.translucent = NO;
    self.tabBar.shadowImage = [UIImage new];
    self.tabBar.backgroundImage = [UIImage new];
    self.tabBar.barTintColor = [UIColor appBgColor];

    [self setSelectedViewController:self.viewControllers[0]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applocatopnDidBecomeActiveNotification:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applocatopnWillResignActiveNotification:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applocatopnWillTerminateNotification:) name:UIApplicationWillTerminateNotification object:nil];
}

- (void)addCenterButtonTouchDown:(id)sender
{
    NSLog(@"center button touch down");
}

- (void)applocatopnWillTerminateNotification:(NSNotification*)notification
{
    [WYUserInfoObject saveUserInfo:[WYUserInfoObject sharedInstance]];
}

- (void)applocatopnWillResignActiveNotification:(NSNotification*)notification
{
    //断开socket连接
    [self disSocketConnect];
    
    //存储用户信息
    [WYUserInfoObject saveUserInfo:[WYUserInfoObject sharedInstance]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    [[NSUserDefaults standardUserDefaults] setObject:strDate forKey:@"applicationDidEnterBackground_time"];
}

- (void)applocatopnDidBecomeActiveNotification:(NSNotification*)notification
{
    //1.判断是否登录
    if([[WYUserInfoObject sharedInstance] getToken] && ![[[WYUserInfoObject sharedInstance] getToken] isEqualToString:@""])
    {
        [self resumeSocketConnect];
    }
}

//检测更新
- (void)appUpdate:(NSDictionary *)appUpdateInfo
{
    if (appUpdateInfo && [appUpdateInfo isKindOfClass:[NSDictionary class]]) {
        BOOL update = [WYItemParseBase getBoolValue:[appUpdateInfo objectForKey:@"update"]];
        if (update) {
            //need update
            NSString *update_version = [WYItemParseBase getStrValue:[appUpdateInfo objectForKey:@"version"]];
            BOOL reminded = [[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"Reminded_version_%@",update_version]] boolValue];
            if (reminded == NO) {
                NSLog(@"发现新版本");
            }
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:[NSString stringWithFormat:@"Reminded_version_%@",update_version]];
        }
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)navigationController
{
    
}

- (void)startLocation
{
    
}

#pragma mark -
#pragma mark socketReceiveDataDelegate

- (void)socketReceiveData:(NSDictionary *)data
{
    if (data && [data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *payload = [data objectForKey:@"payload"];
        
        if (payload && [payload isKindOfClass:[NSDictionary class]]) {
            
            NSString *type = [WYItemParseBase getStrValue:[payload objectForKey:@"type"]];
            if (type && ![type isEqualToString:@""]) {
                
            }
                //--user message end
        }
    }
}

- (void)markItemBadge:(NSInteger)index
{
    if (self.viewControllers && self.viewControllers.count > index) {
        UIViewController * tempController = self.viewControllers[index];
        tempController.tabBarItem.badgeValue = @"N";
    }
}

- (void)clearItemBadge:(NSInteger)index{
    
    if (self.viewControllers && self.viewControllers.count > index) {
        UIViewController * tempController = self.viewControllers[index];
        tempController.tabBarItem.badgeValue = nil;
    }
}

- (void)resumeSocketConnect
{
    [[WYSocketObject sharedInstance] setDelegate:self];
    [[WYSocketObject sharedInstance] resume];
}

- (void)disSocketConnect
{
    [[WYSocketObject sharedInstance] disconnect];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
