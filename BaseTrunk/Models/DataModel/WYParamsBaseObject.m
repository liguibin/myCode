//
//  WYParamsBaseObject.m
//  BaseTrunk
//
//  Created by wangyong on 15/9/8.
//  Copyright (c) 2015年 wang yong. All rights reserved.
//

#import "WYParamsBaseObject.h"

@implementation WYParamsBaseObject

- (id)init
{
    self = [super init];
    if(self)
    {
        NSNumber *timesNum = [NSNumber numberWithLongLong:[[NSDate date] timeIntervalSince1970] *1000];
        NSString *timeSp = [NSString stringWithFormat:@"%lld", [timesNum longLongValue]];
        self.ct = timeSp;
    }
    
    return self;
}

- (void)setUrl:(NSString *)api
{
    _url = [self getServerApiUrl:api];
}

- (void)setUploadUrl:(NSString *)uploadUrl
{
    _uploadUrl = [self getUploadApiUrl:uploadUrl];
}

@end
