//
//  MZVideoListObject.h
//  BaseTrunk
//
//  Created by King on 2018/12/11.
//  Copyright © 2018 wang yong. All rights reserved.
//

#import "MZParamsBaseObject.h"
#import "MZItemParseBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface MZVideoListObject : MZParamsBaseObject

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger pullType;

@end

@interface MZVideoListInfoObject : MZItemParseBase

@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *coverUrl;

@end

NS_ASSUME_NONNULL_END
