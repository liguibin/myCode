//
//  WYParamsBaseObject.h
//  BaseTrunk
//
//  Created by wangyong on 15/9/8.
//  Copyright (c) 2015年 wang yong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WYConfig.h"

@interface WYParamsBaseObject : WYConfig

@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *uploadUrl;
@property (nonatomic, copy) NSString *timesp;   //自带检验
@property (nonatomic, copy) NSString *ct; //校验用 时间戳
@property (nonatomic, assign) BOOL post;
@property (nonatomic, strong) id file;

@end
