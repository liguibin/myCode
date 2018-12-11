//
//  WYFileClient.h
//  BaseTrunk
//
//  Created by wangyong on 15/8/8.
//  Copyright (c) 2015年 wang yong. All rights reserved.
//

typedef NS_ENUM(NSInteger, NetWorkingType) {
    NetWorkingType_None = 0,
    NetWorkingType_3G   = 1,
    NetWorkingType_Wifi = 2,
};

#import <Foundation/Foundation.h>
#import "WYRequestSender.h"
#import "WYConfig.h"
#import "WYParamsBaseObject.h"

typedef void(^Block_Network_Status)(NSInteger status);

@interface WYFileClient : NSObject
{
    NetWorkingType nNetworkingType;
}
@property (nonatomic, copy)Block_Network_Status network_status;

+ (instancetype)sharedInstance;
- (int)getNetworkingType;
- (BOOL)isNetworkingDisconnect;
- (Boolean)isNetWorkingType3G;

- (void)request_send:(WYParamsBaseObject*)model cachePolicy:(NSURLRequestCachePolicy)cholicy delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;

typedef void(^Block_Complete)(id obj);
typedef void(^Block_Error)(id obj);

@property (nonatomic, copy) Block_Complete block_complete;
@property (nonatomic, copy) Block_Error block_error;

- (void)request_send:(WYParamsBaseObject*)model
         cachePolicy:(NSURLRequestCachePolicy)cachePolicy
    completeSelector:(Block_Complete)complete
       errorSelector:(Block_Error)error;

@end


