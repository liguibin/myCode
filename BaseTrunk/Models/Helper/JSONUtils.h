//
//  JSONUtils.h
//  BaseModel
//
//  Created by jor on 17/4/13.
//  Copyright © 2017年 jor. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSString (JSON)

- (NSMutableDictionary * _Nullable)jsonDictionary;

- (NSArray * _Nullable)jsonArray;

@end


@interface NSDictionary (JSON)

- (NSData * _Nullable)jsonData;

- (NSString * _Nullable)jsonString;

@end

@interface NSArray (JSON)

- (NSData * _Nullable)jsonData;

- (NSMutableString * _Nullable)jsonString;

@end
