//
//  Global.m
//  Whisper
//
//  Created by wangyong on 14-2-27.
//  Copyright (c) 2014年 Whisper. All rights reserved.
//

#import "GlobalHelp.h"
#import "SecureUDID.h"

NSString *const AgainLoginNotification = @"UserAgainNotification";

@implementation GlobalHelp

UINavigationController *selected_navigation_controller()
{
    UINavigationController *selectedNavi = nil;
    
    if ([[UIApplication sharedApplication].keyWindow.rootViewController isKindOfClass:[UITabBarController class]]) {
        selectedNavi = (UINavigationController *)((UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController).selectedViewController;
    }
    
    return selectedNavi;
}

NSString *device_id()
{
    NSString *UUID = [[NSUserDefaults standardUserDefaults] objectForKey:KEYCHAIN_SERVICE_NAME];
    if (!UUID || [UUID isEqualToString:@""]) {
        
        NSString *domain     = KEYCHAIN_SERVICE_NAME;
        NSString *key        = KEYCHAIN_ACCOUNT_UUID;
        NSString *identifier = [SecureUDID UDIDForDomain:[domain stringByAppendingString:@"uuid"] usingKey:[key stringByAppendingString:@"uuid"]];
        //本地没有，创建UUID
        UUID = identifier;
        if (identifier && ![identifier isEqualToString:@""]) {
            [[NSUserDefaults standardUserDefaults] setObject:identifier forKey:KEYCHAIN_SERVICE_NAME];
        }
    }
    
    return UUID;
}

NSString *app_version()
{
    NSString *appVersion = nil;
    NSString *marketingVersionNumber = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *developmentVersionNumber = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    if (marketingVersionNumber) {
        appVersion = marketingVersionNumber;
        return appVersion;
    }
    if (marketingVersionNumber && developmentVersionNumber) {
        
        if ([marketingVersionNumber isEqualToString:developmentVersionNumber]) {
            
            appVersion = marketingVersionNumber;
        } else {
            
            appVersion = [NSString stringWithFormat:@"%@ rv:%@",marketingVersionNumber,developmentVersionNumber];
        }
    } else {
        
        appVersion = (marketingVersionNumber ? marketingVersionNumber : developmentVersionNumber);
    }
    
    return appVersion;
}

@end
