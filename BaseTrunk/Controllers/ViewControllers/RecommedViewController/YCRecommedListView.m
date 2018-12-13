//
//  YCRecommedListView.m
//  BaseTrunk
//
//  Created by King on 2018/12/11.
//  Copyright © 2018 wang yong. All rights reserved.
//

#import "YCRecommedListView.h"
#import "WYConfig.h"
#import "YCVideoListObject.h"

@interface YCRecommedListView ()

@property (nonatomic, strong) UIImageView *coverView;
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, retain) UIImageView *vipView;
@property (nonatomic, retain) UILabel *photoCountLabel;
@property (nonatomic, retain) UILabel *ageView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) YCVideoListInfoObject *videoListInfoObject;

@end

@implementation YCRecommedListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubView];
    }
    return self;
}

- (void)createSubView
{
    self.coverView = [[UIImageView alloc] initWithFrame:CGRectMake(0., 0., ScreenWidth, ScreenHeight)];
    [self addSubview:self.coverView];
    
    self.avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(0., 0., 150, 150)];
    [self.coverView addSubview:self.avatarView];
    
    self.vipView = [[UIImageView alloc] initWithFrame:CGRectMake(5., 3., 30., 15.)];
    [self.coverView addSubview:self.vipView];
    
    self.photoCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.avatarView.width - 2. - 40., self.avatarView.height - 2. - 14., 40., 14.)];
    [self.coverView addSubview:self.photoCountLabel];
    
    self.ageView = [[UILabel alloc] initWithFrame:CGRectMake(self.avatarView.left, self.avatarView.bottom + 8., 27., 14.)];
    [self.coverView addSubview:self.ageView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.ageView.right + 4., self.avatarView.bottom + 5., ScreenWidth, 23.)];
    self.nameLabel.textColor = [UIColor colorWithWhite:1 alpha:0.5];
    self.nameLabel.font = [UIFont systemFontOfSize:13.];
    self.nameLabel.numberOfLines = 1;
    self.nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.coverView addSubview:self.nameLabel];
}

- (void)setObject:(id)item {
    if (!self.videoListInfoObject) {
        self.videoListInfoObject = [YCVideoListInfoObject new];
    }
    if (item && [self.videoListInfoObject parseData:item]) {
        [self.coverView sd_setImageWithURL:[WYConfig getImageUrl:self.videoListInfoObject.coverUrl] placeholderImage:[UIImage imageNamed:iphoneX?@"xwaiting_page":@"waiting_page"] options:SDWebImageLowPriority|SDWebImageRetryFailed completed:nil];
        [self.nameLabel setText:self.videoListInfoObject.nickname];
    }
}

@end
