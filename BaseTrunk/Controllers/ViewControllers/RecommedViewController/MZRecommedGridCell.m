//
//  MZRecommedGridCell.m
//  Onion
//
//  Created by king on 2018/12/10.
//  Copyright © 2018 King. All rights reserved.
//

#import "MZRecommedGridCell.h"
#import "MZRecommedGridView.h"

@interface MZRecommedGridCell ()

@property (nonatomic, strong) MZRecommedGridView *recommedGridView;

@end

@implementation MZRecommedGridCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.recommedGridView = [[MZRecommedGridView alloc] initWithFrame:self.bounds];
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
