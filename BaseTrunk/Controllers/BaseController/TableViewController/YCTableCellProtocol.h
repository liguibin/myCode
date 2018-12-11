//
//  QJTableCellProtocol.h
//  BaseTrunk
//
//  Created by wangyong on 15/8/8.
//  Copyright (c) 2015年 wang yong. All rights reserved.
//

@protocol YCTableCellProtocol <NSObject>

+ (CGFloat)rowHeightForObject:(id)item;
- (void)setObject:(id)item;
@optional
- (void)cellSelectedByIndexPath:(NSIndexPath *)index;
- (void)cellPlayByIndexPath:(NSIndexPath *)index;
- (UIView *)getCellView;
- (void)setDelegate:(id)cellDelegate;
@end
