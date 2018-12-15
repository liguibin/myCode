//
//  MZNearbyView.m
//  Onion
//
//  Created by king on 2018/12/10.
//  Copyright © 2018 King. All rights reserved.
//

#import "MZNearbyView.h"
#import "MZConfig.h"
#import "MZVideoListObject.h"

@interface MZNearbyView ()

@property (nonatomic, retain) UIImageView *avatarView;
@property (nonatomic, retain) UIImageView *vipView;
@property (nonatomic, retain) UILabel *photoCountLabel;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *descriptionLabel;
@property (nonatomic, retain) UILabel *ageView;
@property (nonatomic, retain) UILabel *distanceLabel;
@property (nonatomic, retain) UILabel *otherView;
@property (nonatomic, retain) MZVideoListInfoObject *videoListInfoObject;

@end

@implementation MZNearbyView

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
    self.avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(15., 15., 80., 80.)];
    [self addSubview:self.avatarView];
    
    self.vipView = [[UIImageView alloc] initWithFrame:CGRectMake(13., 19., 30., 15.)];
    [self addSubview:self.vipView];
    
    self.photoCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.avatarView.width - 2. - 40., self.avatarView.height - 2. - 14., 40., 14.)];
    [self.avatarView addSubview:self.photoCountLabel];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.avatarView.right + 15., self.avatarView.top + 3., ScreenWidth - 200., 23.)];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont systemFontOfSize:16.];
    self.nameLabel.numberOfLines = 1;
    self.nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self addSubview:self.nameLabel];
    
    self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.left, self.nameLabel.bottom + 6., ScreenWidth - 125., 19.)];
    self.descriptionLabel.textColor = [UIColor colorWithWhite:1 alpha:0.5];
    self.descriptionLabel.font = [UIFont systemFontOfSize:13.];
    self.descriptionLabel.numberOfLines = 1;
    self.descriptionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self addSubview:self.descriptionLabel];
    
    self.ageView = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.right, self.nameLabel.top, 27., 14.)];
    [self addSubview:self.ageView];
    
    self.distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth - 15. - 76., 19., 76., 19.)];
    self.distanceLabel.textColor = [UIColor colorWithWhite:1 alpha:0.5];
    self.distanceLabel.font = [UIFont systemFontOfSize:13.];
    [self addSubview:self.distanceLabel];
    
    self.otherView = [[UILabel alloc] initWithFrame:CGRectMake(self.descriptionLabel.left, self.descriptionLabel.bottom + 8., 0, 0)];
    [self addSubview:self.otherView];
}

- (void)setObject:(id)item {
    if (!self.videoListInfoObject) {
        self.videoListInfoObject = [MZVideoListInfoObject new];
    }
    if (item && [self.videoListInfoObject parseData:item]) {
        [self.avatarView sd_setImageWithURL:[MZConfig getImageUrl:self.videoListInfoObject.coverUrl] placeholderImage:[UIImage imageNamed:iphoneX?@"xwaiting_page":@"waiting_page"] options:SDWebImageLowPriority|SDWebImageRetryFailed completed:nil];
        [self.nameLabel setText:self.videoListInfoObject.nickname];
    }
}

+ (CGFloat)rowHeightForObject:(id)item {
    return 110.;
}

@end
