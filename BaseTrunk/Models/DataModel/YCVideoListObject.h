//
//  YCVideoListObject.h
//  BaseTrunk
//
//  Created by King on 2018/12/11.
//  Copyright © 2018 wang yong. All rights reserved.
//

#import "WYParamsBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface YCVideoListObject : WYParamsBaseObject

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger pullType;

@end

NS_ASSUME_NONNULL_END
