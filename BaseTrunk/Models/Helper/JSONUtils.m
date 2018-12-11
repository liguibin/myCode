//
//  JSONUtils.m
//  BaseModel
//
//  Created by jor on 17/4/13.
//  Copyright © 2017年 jor. All rights reserved.
//

#import "JSONUtils.h"

@implementation NSString (JSON)

- (NSMutableDictionary *)jsonDictionary {
    return [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
}

- (NSArray *)jsonArray {
    return [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
}

@end

@implementation NSDictionary (JSON)

- (NSData *)jsonData {
    return [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
}

- (NSString *)jsonString {
    return [[NSString alloc] initWithData:[self jsonData] encoding:NSUTF8StringEncoding];
}

@end

@implementation NSArray (JSON)

- (NSData *)jsonData {
    return [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
}

- (NSMutableString *)jsonString {
    return [[NSMutableString alloc] initWithData:[self jsonData] encoding:NSUTF8StringEncoding];
}

@end
