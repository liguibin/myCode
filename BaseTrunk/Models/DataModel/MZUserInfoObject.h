//
//  MZUserInfoDto.h
//  BaseTrunk
//
//  Created by wangyong on 14-3-8.
//  Copyright (c) 2014年 Whisper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MZItemParseBase.h"
#import <MapKit/MapKit.h>

@interface MZUserInfoObject : MZItemParseBase

@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *device_id;
@property (nonatomic, copy) NSString *push_token;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *host;

+ (instancetype)sharedInstance;
- (BOOL)parseUserInfo:(NSDictionary *)user_dict;
+ (void)saveUserInfo:(MZUserInfoObject *)loginUserInfo;
+ (void)cleanAccountDTO;
+ (void)activeLoginUserInfo;
+ (MZUserInfoObject *)loginUserInfo;
- (NSString*)getToken;

@end
