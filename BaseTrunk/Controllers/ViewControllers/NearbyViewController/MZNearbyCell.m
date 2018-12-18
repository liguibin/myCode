//
//  MZNearbyCell.m
//  Onion
//
//  Created by king on 2018/12/10.
//  Copyright © 2018 King. All rights reserved.
//

#import "MZNearbyCell.h"
#import "MZNearbyView.h"

@interface MZNearbyCell ()

@property (nonatomic, strong) MZNearbyView *nearbyView;

@end

@implementation MZNearbyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.nearbyView = [[MZNearbyView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
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
    return [MZNearbyView rowHeightForObject:item];
}

@end
