//
//  WYFileClient.m
//  BaseTrunk
//
//  Created by wangyong on 15/8/8.
//  Copyright (c) 2015年 wang yong. All rights reserved.
//


#import "WYFileClient.h"
#import "Reachability.h"


@implementation WYFileClient

#pragma mark -
#pragma mark Client Functions


+ (instancetype)sharedInstance
{
    static WYFileClient *instance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - Login

- (id)init
{
    if(self = [super init])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reachabilityChanged:)
                                                     name:kReachabilityChangedNotification
                                                   object:nil];
        
        Reachability * reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
        [reach startNotifier];
    }
    
    return self;
}

- (int)getNetworkingType
{
    return nNetworkingType;
}

- (BOOL)isNetworkingDisconnect
{
    return  ![AFNetworkReachabilityManager sharedManager].isReachable;
}

- (Boolean)isNetWorkingType3G{
    if(nNetworkingType == NetWorkingType_3G){
        return YES;
    }
    
    return NO;
}

- (void)reachabilityChanged:(NSNotification*)note
{
    Reachability *reach = [note object];
    if(self.network_status)
    {
        self.network_status([reach currentReachabilityStatus]);
    }

    
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            nNetworkingType = NetWorkingType_None;
            NSLog(@"没有网络");
            break;
        case ReachableViaWWAN:
            nNetworkingType = NetWorkingType_3G;
            NSLog(@"正在使用3G网络");
            break;
        case ReachableViaWiFi:
            nNetworkingType = NetWorkingType_Wifi;
            NSLog(@"正在使用wifi网络");
            break;
        default:
            nNetworkingType = NetWorkingType_3G;
            break;
    }
}

- (NSMutableDictionary*)getDefaultParams
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"iPhone" forKey:@"client_type"];
    [params setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"client_version"];
    return params;
}


- (void)request_send:(WYParamsBaseObject*)model cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError
{
    WYRequestSender *requestSender = [WYRequestSender requestSenderWithParams:model
                                                                    cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                                  delegate:theDelegate
                                                          completeSelector:theSelector
                                                             errorSelector:theSelectorError
                                                          argumentSelector:nil];
    if(model.uploadUrl)
    {
        [requestSender uploadData:UploadTypePicture];
    }
    else
    {
        [requestSender send];
    }
}

//file client must new object
- (void)request_send:(WYParamsBaseObject *)model
         cachePolicy:(NSURLRequestCachePolicy)cachePolicy
    completeSelector:(Block_Complete)complete
       errorSelector:(Block_Error)error
{
    
    
    self.block_complete = complete;
    self.block_error = error;
    
    WYRequestSender *requestSender = [WYRequestSender requestSenderWithParams:model
                                                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                                     delegate:self
                                                             completeSelector:@selector(request_send_done:)
                                                                errorSelector:@selector(request_send_error:)
                                                             argumentSelector:nil];
    
    if(model.uploadUrl)
    {
        [requestSender uploadData:UploadTypePicture];
    }
    else
    {
        [requestSender send];
    }
    
}

- (void)request_send_done:(id)data
{
    if(self.block_complete)
    {
        self.block_complete(data);
    }
    
}

- (void)request_send_error:(id)error
{
    if(self.block_error)
    {
        self.block_error(error);
    }
}

///////////////////////////////////////////////

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
