//
//  Global.h
//  Whisper
//
//  Created by wangyong on 14-2-27.
//  Copyright (c) 2014年 Whisper. All rights reserved.
//


#import "UIView+Addition.h"
#import "NSArray+Addition.h"
#import "UIAlertView+Addition.h"
#import "NSString+Additions.h"
#import "NSDate+Addition.h"
#import "UIImage+Addition.h"
#import "Colours.h"
#import "WYNavigationController.h"
#import "SVProgressHUD.h"
#import "DateUtil.h"
#import "UINavigationBar+Addition.h"
#import "UITabBarController+hidable.h"
#import "UINavigationController+TRVSNavigationControllerTransition.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Addition.h"
#import "UIActionSheet+Addtions.h"

/*
 *  System Versioning Preprocessor Macros
 */

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

#ifndef __OPTIMIZE__
# define NSLog(...) NSLog(__VA_ARGS__)
#else
# define NSLog(...) {}
#endif

//平台账号
/*
 注**
 redirectURL必须要和微博设置的回调一致
 */
/* 新浪 */

/* 项目第三方分享物料
 
 微信的key
 appkey：
 
 
 微博：
 App Key：
 App Secret：
 
 
 QQ：
 APP ID:
 APP KEY:
 
 */

#define WB_App_key @"3558281054"
#define WB_RedirectURI @"https://api-f2.kinstalk.com/user/third_party/login"

#define ID_WX_APP_KEY @"wx66381b2e09ee5904"
#define QQ_APP_KEY @"1105809336"

#define WX_ACCESS_TOKEN @"access_token"
#define WX_OPEN_ID @"openid"
#define WX_REFRESH_TOKEN @"refresh_token"
#define WX_UNION_ID @"unionid"

#define SDKAppID     1400106255
#define AccountType  30059

#define Locs(key) NSLocalizedString(key, comment)

#define iPhone5_down  (([UIScreen mainScreen].bounds.size.height <= 568)?YES: NO)
#define iPhone6_down  (([UIScreen mainScreen].bounds.size.height <= 667)?YES: NO)

#define iphoneX (((ScreenWidth == 375.0f && ScreenHeight == 812.0f) || (ScreenWidth == 414.0f && ScreenHeight == 896.0f))? YES : NO)
#define YCNavbar_Height (iphoneX ? 88.0f : 64.0f)
#define YCNavbar_DiffH  (iphoneX ? 24.0f : 0.0f)
#define YCTabbar_Height (iphoneX ? 83.0f : 49.0f)
#define YCTabBar_DiffH  (iphoneX ? 34.0f : 0.0f)


//获得屏幕的宽高
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
//iPhoneX / iPhoneXS
#define  isIphoneX_XS       (kScreenWidth == 375.f && kScreenHeight == 812.f ? YES : NO)
//iPhoneXR / iPhoneXSMax
#define  isIphoneXR_XSMax   (kScreenWidth == 414.f && kScreenHeight == 896.f ? YES : NO)
//异性全面屏
#define  isFullScreen       (isIphoneX_XS || isIphoneXR_XSMax)
// Status bar height.
#define  StatusBarHeight    (isFullScreen ? 44.f : 20.f)
// Navigation bar height.
#define  NavigationBarHeight    44.f
// Status bar & navigation bar height.
#define  StatusBarAndNavigationBarHeight    (isFullScreen ? 88.f : 64.f)
// Tabbar height.
#define  TabbarHeight       (isFullScreen ? (49.f+34.f) : 49.f)
// Tabbar safe bottom margin.
#define  TabbarSafeBottomMargin (isFullScreen ? 34.f : 0.f)



#define KEYCHAIN_SERVICE_NAME       @"com.xxx.xx"
#define KEYCHAIN_ACCOUNT_UUID       @"keychain_account_uuid.com.xxx.xx"

#define ERROR_DOMAIN @"com.***"
#define USER_DEFAULTS_SYSTEM_USER   @"USER_DEFAULTS_SYSTEM_USER"
#define DEVICE_REMOTE_PUSH_TOKEN    @"com.shuzijiayuan.f2.remote.push.token"
#define APP_URL @"http://www.xxx.com"
#define URL_BAIDU_IMAGE @"http://image.baidu.com/i"

#define OBJ_IS_NIL(s) (s==nil || [NSNull isEqual:s] || [s class]==nil || [@"<null>" isEqualToString:[s description]] ||[@"(null)" isEqualToString:[s description]])

extern NSString* const AgainLoginNotification;

@interface GlobalHelp : NSObject

UINavigationController *selected_navigation_controller();
NSString *device_id(void);
NSString *app_version(void);

@end

