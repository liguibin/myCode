//
//  YCRecommedGridCell.m
//  Onion
//
//  Created by king on 2018/12/10.
//  Copyright © 2018 King. All rights reserved.
//

#import "YCRecommedGridCell.h"
#import "YCRecommedGridView.h"

@interface YCRecommedGridCell ()

@property (nonatomic, strong) YCRecommedGridView *recommedGridView;

@end

@implementation YCRecommedGridCell

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        self.recommedGridView = [[YCRecommedGridView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
//        [self.contentView addSubview:self.recommedGridView];
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    return self;
//}
//
//- (void)setObject:(id)item
//{
//    if (item && [item isKindOfClass:[NSDictionary class]]) {
//        [self.recommedGridView setObject:item];
//    }
//}
//
//+ (CGFloat)rowHeightForObject:(id)item
//{
//    return [YCRecommedGridView rowHeightForObject:item];
//}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.recommedGridView = [[YCRecommedGridView alloc] initWithFrame:self.bounds];
        [self addSubview:self.recommedGridView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj respondsToSelector:@selector(setSelected:)]) {
            [obj setSelected:selected];
        }
    }];
}

- (void)setObject:(id)item
{
    if(self.recommedGridView)
    {
        [self.recommedGridView setObject:item];
    }
}

@end
