//
//  MZTableCellDelegate.h
//  BaseTrunk
//
//  Created by wangyong on 15/8/8.
//  Copyright (c) 2015年 wang yong. All rights reserved.
//

@protocol MZTableCellDelegate <NSObject>

+ (CGFloat)rowHeightForObject:(id)item;
- (void)setObject:(id)item;

@optional
- (void)setObject:(id)item IndexPath:(NSIndexPath *)index;
- (void)cellSelectedByIndexPath:(NSIndexPath *)index;

@end
