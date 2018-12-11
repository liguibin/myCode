//
//  YCRecommedGridView.m
//  Onion
//
//  Created by king on 2018/12/10.
//  Copyright © 2018 King. All rights reserved.
//

#import "YCRecommedGridView.h"
#import "WYConfig.h"

#define RecommedGridAvatarTop   5.
#define RecommedGridAvatarWidth 105.
#define RecommedGridAvatarHeight 130.

@interface YCRecommedGridView ()

@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, retain) UIImageView *vipView;
@property (nonatomic, retain) UILabel *photoCountLabel;
@property (nonatomic, retain) UILabel *ageView;
@property (nonatomic, retain) UILabel *nameLabel;

@end


@implementation YCRecommedGridView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    self.backgroundColor = [UIColor redColor];
    self.avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(0., 0., RecommedGridAvatarWidth, RecommedGridAvatarWidth)];
    [self addSubview:self.avatarView];
    
    self.vipView = [[UIImageView alloc] initWithFrame:CGRectMake(5., 3., 30., 15.)];
    [self addSubview:self.vipView];
    
    self.photoCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.avatarView.width - 2. - 40., self.avatarView.height - 2. - 14., 40., 14.)];
    [self.avatarView addSubview:self.photoCountLabel];
    
    self.ageView = [[UILabel alloc] initWithFrame:CGRectMake(self.avatarView.left, self.avatarView.bottom + 8., 27., 14.)];
    [self addSubview:self.ageView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.ageView.right + 4., self.avatarView.bottom + 5., RecommedGridAvatarWidth - 30., 23.)];
    self.nameLabel.textColor = [UIColor colorWithWhite:1 alpha:0.5];
    self.nameLabel.font = [UIFont systemFontOfSize:13.];
    self.nameLabel.numberOfLines = 1;
    self.nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self addSubview:self.nameLabel];
}

- (void)setObject:(id)item
{
    [self.avatarView sd_setImageWithURL:[WYConfig getImageUrl:[item objectForKey:@"coverUrl"]] placeholderImage:[UIImage imageNamed:iphoneX?@"xwaiting_page":@"waiting_page"] options:SDWebImageLowPriority|SDWebImageRetryFailed completed:nil];
    [self.nameLabel setText:[item objectForKey:@"nickname"]];
}

@end
