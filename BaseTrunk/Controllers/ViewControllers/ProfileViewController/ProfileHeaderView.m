//
//  ProfileHeaderView.m
//  BaseTrunk
//
//  Created by King on 2018/12/13.
//  Copyright © 2018 wang yong. All rights reserved.
//

#import "ProfileHeaderView.h"
#import "YCVideoListObject.h"

@interface ProfileHeaderView ()

@property (nonatomic, retain) UIImageView *avatarView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *descriptionLabel;
@property (nonatomic, retain) YCVideoListInfoObject *videoListInfoObject;

@end

@implementation ProfileHeaderView

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
    self.avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(40., (ScreenWidth - 40.) / 2., 80., 80.)];
    self.avatarView.userInteractionEnabled = YES;
    self.avatarView.clipsToBounds = YES;
    self.avatarView.layer.cornerRadius = self.avatarView.width;
    [self.avatarView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAvatarView:)]];
    [self addSubview:self.avatarView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0., self.avatarView.bottom + 10., 0., 23.)];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont systemFontOfSize:16.];
    self.nameLabel.numberOfLines = 1;
    self.nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self addSubview:self.nameLabel];
}

- (void)setObjectWithObejct:(id)object
{
    if (!self.videoListInfoObject) {
        self.videoListInfoObject = [YCVideoListInfoObject new];
    }
    if (object && [self.videoListInfoObject parseData:object]) {
        [self.avatarView sd_setImageWithURL:[WYConfig getImageUrl:self.videoListInfoObject.coverUrl] placeholderImage:[UIImage imageNamed:iphoneX?@"xwaiting_page":@"waiting_page"] options:SDWebImageLowPriority|SDWebImageRetryFailed completed:nil];
        [self.nameLabel setText:self.videoListInfoObject.nickname];
        [self.nameLabel sizeToFit];
        self.nameLabel.centerX = ScreenWidth / 2.;
    }
}

- (void)clickAvatarView:(UIGestureRecognizer *)gesture
{
    
}

+ (CGFloat)getHeaderHeight
{
    return 200;
}

@end
