//
//  MZRecommedListCell.m
//  BaseTrunk
//
//  Created by King on 2018/12/11.
//  Copyright © 2018 wang yong. All rights reserved.
//

#import "MZRecommedListCell.h"
#import "MZRecommedListView.h"

@interface MZRecommedListCell ()

@property (nonatomic, strong) MZRecommedListView *recommedListView;

@end

@implementation MZRecommedListCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.recommedListView = [[MZRecommedListView alloc] initWithFrame:self.bounds];
        [self addSubview:self.recommedListView];
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
    if(self.recommedListView)
    {
        [self.recommedListView setObject:item];
    }
}

@end
