//
//  MZItemParseBase.h
//
//
//  Created by wangyong on 15/7/20.
//  Copyright (c) 2015年 wang yong. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface MZItemParseBase : NSObject

{
    NSMutableDictionary *resultDictnary;
}

- (id)init:(NSString *)dict;
- (BOOL)parseData:(NSDictionary *)result;
- (NSMutableDictionary*)dtoResult;
- (void)setDtoResult:(NSDictionary*)result;
- (NSDictionary *)toDictionary;
+ (NSDictionary *)toDictionaryWithModle:(id)model;

+ (NSInteger)getIntValue:(NSNumber *)num;
+ (float)getFloatValue:(NSNumber *)num;
+ (BOOL)getBoolValue:(NSNumber *)num;
+ (NSString *)getStrValue:(NSString *)str;
+ (double)getDoubleValue:(NSNumber *)num;
- (long long )getLonglongValue:(NSNumber *)num;

- (NSMutableDictionary*)dtoResult;
- (void)setDtoResult:(NSDictionary*)result;
- (NSDictionary *)toDictionary;

@end
