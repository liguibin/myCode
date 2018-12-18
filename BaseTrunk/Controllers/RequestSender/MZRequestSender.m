//
//  MZRequestSender.m
//  BaseTrunk
//
//  Created by wangyong on 15/8/8.
//  Copyright (c) 2015年 wang yong. All rights reserved.
//


#import "MZRequestSender.h"
#import "MZFileClient.h"
#import "MZParamsBaseObject.h"
#import "JSONUtils.h"
#import "MZUserInfoObject.h"
#import <objc/runtime.h>

static const float TIME_OUT_INTERVAL = 10.0f;
#define CODE @"c"
#define DATA @"d"

typedef enum
{
    ERROR_CODE_SUCCESS = 0,
    ERROR_CODE_NORMAL,
    ERROR_CODE_NEED_AUTH,
    ERROR_CODE_BLOCKED,

}API_GET_CODE;

@implementation MZRequestSender
@synthesize argumentSelector;
@synthesize requestDelegate;
@synthesize completeSelector;
@synthesize errorSelector;
@synthesize cachePolicy;

+ (instancetype)currentClient
{
    static MZRequestSender *sharedInstance = nil;
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, ^{
        sharedInstance = [[MZRequestSender alloc] init];
    });
    return sharedInstance;
}

+ (id)requestSenderWithParams:(id)params
                  cachePolicy:(NSURLRequestCachePolicy)cachePolicy
                     delegate:(id)requestDelegate
             completeSelector:(SEL)completeSelector
                errorSelector:(SEL)errorSelector
             argumentSelector:(SEL)argumentSelector;
{
    MZRequestSender *requestSender = [[MZRequestSender alloc] init];
    requestSender.requestDelegate = requestDelegate;
    requestSender.completeSelector = completeSelector;
    requestSender.errorSelector = errorSelector;
    requestSender.argumentSelector = argumentSelector;
    requestSender.cachePolicy = cachePolicy;
    requestSender.paramsObject = params;
    return requestSender;
}

+ (NSMutableURLRequest *)getRequestWithURL:(NSString *)url
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [[self class] addHttpHeader:request];
    return request;
}

+ (void)addHttpHeader:(NSMutableURLRequest *)request
{
    if(!OBJ_IS_NIL([MZUserInfoObject sharedInstance].token))
    {
        [request addValue:[MZUserInfoObject sharedInstance].token forHTTPHeaderField:@"token"];
    }
    
    if (!OBJ_IS_NIL(device_id()))
    {
        [request addValue:device_id() forHTTPHeaderField:@"deviceId"];
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        [request addValue:@"1" forHTTPHeaderField:@"deviceType"];
    }
    else if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        [request addValue:@"2" forHTTPHeaderField:@"deviceType"];
    }
    
    if (app_version()) {
        [request addValue:app_version() forHTTPHeaderField:@"version"];
        [request addValue:@"iPhone" forHTTPHeaderField:@"type"];
    }
}

AFURLSessionManager *requestManager = nil;
+ (AFURLSessionManager *)getRequestManager
{
    if(!requestManager)
    {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *managerTemp = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        //        managerTemp.securityPolicy.allowInvalidCertificates = YES; // not recommended for production
        managerTemp.securityPolicy.validatesDomainName = NO;
        managerTemp.responseSerializer = [AFHTTPResponseSerializer serializer];
        ((AFHTTPResponseSerializer*)managerTemp.responseSerializer).acceptableContentTypes = [NSSet setWithObjects:@"application/javascript", @"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
        requestManager = managerTemp;
    }
    
    return requestManager;
}

- (void)send
{
    NSString *bodyString = [self httpBodyString:self.paramsObject];
    NSString *url = self.paramsObject.url;
    if(!self.paramsObject.post)
    {
        url = [self.paramsObject.url stringByAppendingString:[NSString stringWithFormat:@"?%@",bodyString]];
    }
    NSMutableURLRequest *request = [[self class] getRequestWithURL:url];
    [request setCachePolicy:self.cachePolicy];
    [request setTimeoutInterval:TIME_OUT_INTERVAL];
    [request setHTTPMethod:self.paramsObject.post?@"POST":@"GET"];
    
    //百度搜图添加httpHeader
    if ([[url description] hasPrefix:URL_BAIDU_IMAGE]) {
        [request setValue:@"http://image.baidu.com/i?tn=baiduimage" forHTTPHeaderField:@"Referer"];
        [request setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146" forHTTPHeaderField:@"User-Agent"];
    }
    
    [request setHTTPMethod:self.paramsObject.post?@"POST":@"GET"];
    if(self.paramsObject.post)
    {
        [request setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    __weak typeof(self)weak_self = self;
    NSURLSessionDataTask *dataTask = [[[self class] getRequestManager] dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if(!error)
        {
            if(self.requestDelegate)
            {
                //            NSLog(@"get Data sucess");
                id object = responseObject;
                
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                if(weak_self.completeSelector && [weak_self.requestDelegate respondsToSelector:weak_self.completeSelector])
                {
                    
                    object = [weak_self transitionData:responseObject cache:NO];
                    
                    if (object)
                    {
                        
                        if ([object isKindOfClass:[NSError class]])
                        {
                            if(weak_self.errorSelector){
                                [weak_self.requestDelegate performSelector:weak_self.errorSelector withObject:(NSError *)object];
                            }
                            
                        }
                        else
                        {
                            if(weak_self.completeSelector)
                                [weak_self.requestDelegate performSelector:weak_self.completeSelector withObject:object];
                        }
                    }
                    else if(weak_self.errorSelector)
                    {
                        [weak_self.requestDelegate performSelector:weak_self.errorSelector withObject:(NSError *)object];
                    }
                    
                }
                else if(weak_self.errorSelector)
                {
                    [weak_self.requestDelegate performSelector:weak_self.errorSelector withObject:(NSError *)object];
                }
#pragma clang diagnostic pop
                
            }
        }
        else
        {
            if(weak_self.requestDelegate)
            {
                NSLog(@"return Data error");
                
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                
                if(weak_self.errorSelector && [weak_self.requestDelegate respondsToSelector:weak_self.errorSelector])
                {
                    NSMutableDictionary *reasonDict = [NSMutableDictionary new];
                    NSString *strFailText = Locs(@"网络异常，请稍后重试");
                    [reasonDict setObject:strFailText forKey:@"data"];
                    if(weak_self.paramsObject.timesp)
                    {
                        [reasonDict setObject:weak_self.paramsObject.timesp forKey:@"timesp"];
                    }
                    
                    NSError *er = [NSError errorWithDomain:ERROR_DOMAIN code:error.code userInfo:[NSDictionary dictionaryWithObject:reasonDict forKey:@"reason"]];
                    [weak_self.requestDelegate performSelector:weak_self.errorSelector withObject:er];
                }
#pragma clang diagnostic pop
                
            }
        }
    }];
    [dataTask resume];
}

- (void)uploadData
{
    NSString *url = self.paramsObject.url;
    
    __weak typeof(self)weak_self = self;
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //图片压缩至100kb以内
        NSData * data = nil;
        NSString *filePath = nil;
        if([weak_self.paramsObject.file isKindOfClass:[UIImage class]])
        {
            //            if(![self.paramsObject.file isKindOfClass:NSClassFromString(@"_UIAnimatedImage")])
            {
                data = UIImageJPEGRepresentation(weak_self.paramsObject.file, 1.0);
                for (float i = 1.0; [data length] > 202400 && i > 0.0; i = i-0.1)
                {
                    data = UIImageJPEGRepresentation(weak_self.paramsObject.file, i);
                }
                
//                NSString *pathComponent = @"avatar.png";
//                filePath =  [[YCFileHelper getUploadPath] stringByAppendingPathComponent:pathComponent];
//                [YCFileHelper clearFile:filePath];
                [data writeToFile:filePath atomically:YES];
            }
        }
        else
        {
            filePath = weak_self.paramsObject.file;
        }
        
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:@"file1" error:nil];
    } error:nil];
    
    [[self class] addHttpHeader:request];
    
    [request setCachePolicy:self.cachePolicy];
    [request setTimeoutInterval:TIME_OUT_INTERVAL * 500];
    
    NSURLSessionUploadTask *uploadTask = [[[self class] getRequestManager] uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"error : %@",error);
            if(weak_self.requestDelegate && weak_self.errorSelector){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                if(weak_self.paramsObject.timesp){
                    NSMutableDictionary *reasonDict = nil;
                    
                    if(error.userInfo && [error.userInfo isKindOfClass:[NSDictionary class]]){
                        reasonDict = [NSMutableDictionary dictionaryWithDictionary:error.userInfo];
                    }
                    else{
                        reasonDict = [NSMutableDictionary new];
                    }
                    
                    [reasonDict setObject:weak_self.paramsObject.timesp forKey:@"timesp"];
                    
                    NSError *errorr = [NSError errorWithDomain:ERROR_DOMAIN code:error.code userInfo:[NSDictionary dictionaryWithObject:reasonDict forKey:@"reason"]];
                    [weak_self.requestDelegate performSelector:weak_self.errorSelector withObject:errorr];
                    
                }else{
                    [weak_self.requestDelegate performSelector:weak_self.errorSelector withObject:error];
                }
            }
            
#pragma clang diagnostic pop
        } else {
            if(weak_self.requestDelegate && weak_self.completeSelector){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                //去皮
                id object = [weak_self transitionData:responseObject  cache:NO];
                
                if (object) {
                    if ([object isKindOfClass:[NSError class]]) {
                        [weak_self.requestDelegate performSelector:weak_self.errorSelector withObject:(NSError *)object];
                    }else{
                        [weak_self.requestDelegate performSelector:weak_self.completeSelector withObject:object];
                    }
                }
#pragma clang diagnostic pop
            }
        }
    }];
    
    [uploadTask resume];
}

///////////////
- (id)transitionData:(id)data cache:(BOOL)cache
{
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    jsonString = [self removeUnescapedCharacter:jsonString];
    if(jsonString.length > 0)
    {
//        if([[self.paramsObject.url description] hasPrefix:URL_BAIDU_IMAGE])
//        {
//            id responseObject = [[jsonString jsonDictionary] objectForKey:@"data"];
//            return responseObject;
//        }
        NSMutableDictionary *dict = [jsonString jsonDictionary];
        if(dict && [dict isKindOfClass:[NSDictionary class]]) {
            NSString *code = [dict objectForKey:CODE];
            if (code && ERROR_CODE_SUCCESS == [code intValue]) {
                id responseObject = [dict objectForKey:DATA];
                if(responseObject && [responseObject isKindOfClass:[NSDictionary class]])
                {
                    NSMutableDictionary *reasonDictionary = [NSMutableDictionary dictionaryWithDictionary:responseObject];
                    if(self.paramsObject.timesp && reasonDictionary && [reasonDictionary isKindOfClass:[NSDictionary class]])
                    {
                        [reasonDictionary setObject:self.paramsObject.timesp forKey:@"timesp"];
                    }
                    [reasonDictionary setObject:[NSNumber numberWithBool:cache] forKey:@"cache"];
                    return reasonDictionary;
                } else if(self.paramsObject.timesp && [self.paramsObject.timesp length] > 0) {
                    if(responseObject && [responseObject isKindOfClass:[NSArray class]])
                    {
                        NSMutableDictionary *mutableDictionary = [NSMutableDictionary new];
                        {
                            [mutableDictionary setObject:self.paramsObject.timesp forKey:@"timesp"];
                            [mutableDictionary setObject:responseObject forKey:DATA];
                        }
                        return mutableDictionary;
                    }
                }
                return responseObject;
            } else if (code && ERROR_CODE_NEED_AUTH == [code intValue]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:AgainLoginNotification object:nil];
            } else if ((code && ERROR_CODE_BLOCKED == [code intValue])) {
                NSError *error = [NSError errorWithDomain:ERROR_DOMAIN code:ERROR_CODE_BLOCKED userInfo:[NSDictionary dictionaryWithObject:[dict objectForKey:DATA] forKey:@"reason"]];
                return error;
            } else if (code && ERROR_CODE_NORMAL == [code intValue]) {
                if(self.paramsObject.timesp)
                {
                    NSMutableDictionary *reasonDictionary = [NSMutableDictionary dictionaryWithDictionary:dict];
                    if(self.paramsObject.timesp && reasonDictionary && [reasonDictionary isKindOfClass:[NSDictionary class]])
                    {
                        [reasonDictionary setObject:self.paramsObject.timesp forKey:@"timesp"];
                    }
                    NSError *error = [NSError errorWithDomain:ERROR_DOMAIN code:[code intValue] userInfo:[NSDictionary dictionaryWithObject:reasonDictionary forKey:@"reason"]];
                    return error;
                }
                NSError *error = [NSError errorWithDomain:ERROR_DOMAIN code:[code intValue] userInfo:[NSDictionary dictionaryWithObject:[dict objectForKey:DATA] forKey:@"reason"]];
                return error;
            } else {
                NSMutableDictionary *reasonDictionary = [NSMutableDictionary dictionaryWithDictionary:dict];
                if(self.paramsObject.timesp)
                {
                    if(self.paramsObject.timesp && reasonDictionary && [reasonDictionary isKindOfClass:[NSDictionary class]])
                    {
                        [reasonDictionary setObject:self.paramsObject.timesp forKey:@"timesp"];
                    }
                    NSError *error = [NSError errorWithDomain:ERROR_DOMAIN code:[code intValue] userInfo:[NSDictionary dictionaryWithObject:reasonDictionary forKey:@"reason"]];
                    return error;
                }
                return [NSError errorWithDomain:ERROR_DOMAIN code:[code intValue] userInfo:[NSDictionary dictionaryWithObject:reasonDictionary forKey:@"reason"]];
            }
        }
    }
    return nil;
}

//return http body
- (NSString *)httpBodyString:(id)params
{
    NSMutableString *bodyString = [[NSMutableString alloc] init];
    Class cls = [params class];
    unsigned int ivarsCnt = 0;
    objc_property_t *propertys = class_copyPropertyList(cls, &ivarsCnt);
    for (const objc_property_t *p = propertys; p < propertys + ivarsCnt; ++p)
    {
        objc_property_t const ivar = *p;
        NSString *key = [NSString stringWithUTF8String:property_getName(ivar)];
        id value = [params valueForKey:key];
        if(value)
        {
            if ([value isKindOfClass:[NSArray class]])
            {
                for (NSString *string in (NSArray *)value) {
                    [bodyString appendFormat:@"&%@=%@", key, [[NSString stringWithFormat:@"%@", string] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
                }
            } else {
                if(![value isKindOfClass:[NSString class]])
                {
                    value = [NSString stringWithFormat:@"%@",value];
                }
                NSString *encodedValue = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                                      (CFStringRef)value,
                                                                                                      NULL,
                                                                                                      (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                      kCFStringEncodingUTF8);
                [bodyString appendFormat:@"&%@=%@", key, encodedValue];
            }
        }
    }
    free(propertys);
    return bodyString;
}

- (NSString *)removeUnescapedCharacter:(NSString *)inputStr{
    NSCharacterSet *controlChars = [NSCharacterSet controlCharacterSet];
    //获取那些特殊字符
    NSRange range = [inputStr rangeOfCharacterFromSet:controlChars];
    //寻找字符串中有没有这些特殊字符
    if (range.location != NSNotFound)
    {
        NSMutableString *mutable = [NSMutableString stringWithString:inputStr];
        while (range.location != NSNotFound)
        {
            [mutable deleteCharactersInRange:range];
            //去掉这些特殊字符
            range = [mutable rangeOfCharacterFromSet:controlChars];
        }
        return mutable;
    }
    return inputStr;}
    
@end
