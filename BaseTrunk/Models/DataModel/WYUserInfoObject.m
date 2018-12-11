//
//  WYUserInfoDto.m
//  BaseTrunk
//
//  Created by wangyong on 14-3-8.
//  Copyright (c) 2014年 Whisper. All rights reserved.
//

#import "WYUserInfoObject.h"
#import "DateUtil.h"
#import <objc/runtime.h>

@implementation WYUserInfoObject

+ (instancetype)sharedInstance {
    static WYUserInfoObject *instance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}


- (BOOL)parseUserInfo:(NSDictionary *)user_dict
{
    if (user_dict && (NSObject *)user_dict != [NSNull null]) {
        unsigned int ptcnt = 0;
        Class cls = [self class];
        
        objc_property_t *propertys = class_copyPropertyList(cls, &ptcnt);
        
        for (const objc_property_t *p = propertys; p < propertys + ptcnt; ++p)
        {
            objc_property_t const property = *p;
            const char *name = property_getName(property);
            NSString *key = [NSString stringWithUTF8String:name];
            
            id value = [user_dict objectForKey:key];
            
            if(value)
            {
                [self setValue:value forKey:key];
            }
            
        }
        
        free(propertys);
        
        return YES;
        
    }
    return NO;
}

- (BOOL)parse2:(NSDictionary *)result_dict
{
    NSDictionary *result = [result_dict objectForKey:@"user"];
    if(result)
    {
        [self parseUserInfo:result];
    }
    
    self.token = [result_dict objectForKey:@"token"];
    self.host = [result_dict objectForKey:@"host"];
    
    return YES;
}

- (BOOL)parse:(NSDictionary *)dict
{
    BOOL tf = YES;
    if (dict && (NSObject *)dict != [NSNull null]) {
        [self parse2:dict];
    } else {
        tf = NO;
    }
    //
    return tf;
}

/*与存储相关*/
- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int ptcnt = 0;
    Class cls = [self class];

    objc_property_t *propertys = class_copyPropertyList(cls, &ptcnt);
    
    for (const objc_property_t *p = propertys; p < propertys + ptcnt; ++p)
    {
        objc_property_t const property = *p;
        const char *name = property_getName(property);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    
    free(propertys);
}

/*与读取相关*/
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        
        unsigned int ptcnt = 0;
        Class cls = [self class];
        
        objc_property_t *propertys = class_copyPropertyList(cls, &ptcnt);
        
        for (const objc_property_t *p = propertys; p < propertys + ptcnt; ++p)
        {
            objc_property_t const ivar = *p;
            const char *name = property_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        
        free(propertys);
        
    }
    
    return self;
}

+ (void)saveUserInfo:(WYUserInfoObject *)loginUserInfo
{
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:loginUserInfo];
    
    if(userData){
        [[NSUserDefaults standardUserDefaults] setObject:userData forKey:USER_DEFAULTS_SYSTEM_USER];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (void)activeLoginUserInfo
{
    WYUserInfoObject *user = [WYUserInfoObject loginUserInfo];
    
    [WYUserInfoObject sharedInstance].user_id = user.user_id;
    [WYUserInfoObject sharedInstance].token = user.token;
    [WYUserInfoObject sharedInstance].host = user.host;
    [WYUserInfoObject sharedInstance].status = user.status;
    [WYUserInfoObject sharedInstance].create_time = user.create_time;
    [WYUserInfoObject sharedInstance].push_token = user.push_token;
    [WYUserInfoObject sharedInstance].device_id = user.device_id;
}

+ (WYUserInfoObject *)loginUserInfo
{
    
    NSData *userData = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_SYSTEM_USER];
    if (userData) {
        WYUserInfoObject *user = [[WYUserInfoObject alloc] init];
        user = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        
        return user;
    }
    
    return nil;
}

- (NSString*)getToken
{
    if([self.token isKindOfClass:[NSNull class]])
    {
        return @"";
    }
    
    else return self.token;
}

#pragma mark - Clear Local Data
+ (void)cleanAccountDTO
{
    [WYUserInfoObject sharedInstance].user_id = nil;
    [WYUserInfoObject sharedInstance].token = nil;
    [WYUserInfoObject sharedInstance].host = nil;
    [WYUserInfoObject sharedInstance].status = nil;
    [WYUserInfoObject sharedInstance].push_token = nil;
    [WYUserInfoObject sharedInstance].create_time = nil;
    [WYUserInfoObject sharedInstance].device_id = nil;
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_DEFAULTS_SYSTEM_USER];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
