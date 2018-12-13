//
//  YCNearbyCell.m
//  Onion
//
//  Created by king on 2018/12/10.
//  Copyright © 2018 King. All rights reserved.
//

#import "YCNearbyCell.h"
#import "YCNearbyView.h"

@interface YCNearbyCell ()

@property (nonatomic, strong) YCNearbyView *nearbyView;

@end

@implementation YCNearbyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nearbyView = [[YCNearbyView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
        [self.contentView addSubview:self.nearbyView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor appBgColor];
    }
    return self;
}

- (void)setObject:(id)item
{
    if (item && [item isKindOfClass:[NSDictionary class]]) {
        [self.nearbyView setObject:item];
    }
}

+ (CGFloat)rowHeightForObject:(id)item
{
    return [YCNearbyView rowHeightForObject:item];
}

@end
