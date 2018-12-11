//
//  WYConfig.m
//  BaseTrunk
//
//  Created by wangyong on 15/8/8.
//  Copyright (c) 2015年 wang yong. All rights reserved.
//


#import "WYConfig.h"

//#define __OPTIMIZE__MY__

@implementation WYConfig

+ (NSString *)getScopeUrl
{
    NSString *url = @"";
#ifdef __OPTIMIZE__MY__
    url = @"http://api-f2.shuzijiayuan.com/";
#else
    url = @"https://api-f2.kinstalk.com/";
#endif
    return url;
}

- (NSString*)applicationVersion
{
    return @"1";
}

- (NSString*)getServerApiUrl:(NSString*)api
{
    return [NSString stringWithFormat:@"%@%@", [[self class] getScopeUrl], api];
}

- (NSString*)getUploadApiUrl:(NSString*)api
{
#ifdef __OPTIMIZE__MY__
    return [NSString stringWithFormat:@"%@%@", @"https://test-api.kinstalk.com", api];
#else
    return [NSString stringWithFormat:@"%@%@", @"https://upload.kinstalk.com", api];
#endif
}

+ (NSURL *)getImageUrl:(NSString *)imageUrl
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://resources.kinstalk.com/%@", imageUrl]];
}

@end
