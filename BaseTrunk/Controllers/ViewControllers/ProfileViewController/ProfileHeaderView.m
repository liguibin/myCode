//
//  ProfileHeaderView.m
//  BaseTrunk
//
//  Created by King on 2018/12/13.
//  Copyright © 2018 wang yong. All rights reserved.
//

#import "ProfileHeaderView.h"
#import "YCVideoListObject.h"
#import <FLAnimatedImage/FLAnimatedImageView.h>
#import "HZPhotoBrowser.h"

@interface ProfileHeaderView () <HZPhotoBrowserDelegate>

@property (nonatomic, retain) FLAnimatedImageView *avatarView;
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
    self.avatarView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 80.) / 2., 40., 80., 80.)];
    self.avatarView.userInteractionEnabled = YES;
    self.avatarView.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarView.clipsToBounds = YES;
    self.avatarView.layer.cornerRadius = self.avatarView.width / 2.;
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
        [self.avatarView sd_setImageWithURL:[WYConfig getImageUrl:self.videoListInfoObject.coverUrl] placeholderImage:[UIImage imageNamed:@"whiteplaceholder.png"] options:SDWebImageLowPriority|SDWebImageRetryFailed completed:nil];
        [self.nameLabel setText:self.videoListInfoObject.nickname];
        [self.nameLabel sizeToFit];
        self.nameLabel.centerX = ScreenWidth / 2.;
    }
}

- (void)clickAvatarView:(UIGestureRecognizer *)gesture
{
    FLAnimatedImageView *imageView = (FLAnimatedImageView *)gesture.view;
    //启动图片浏览器
    HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
    browser.isFullWidthForLandScape = YES;
    browser.isNeedLandscape = YES;
    browser.sourceImagesContainerView = self; // 原图的父控件
    browser.currentImageIndex = (int)imageView.tag;
    browser.imageCount = 1; // 图片总数
    browser.delegate = self;
    [browser show];
}

#pragma mark - photobrowser代理方法
// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    FLAnimatedImageView *imageView = (FLAnimatedImageView *)self.subviews[index];
    return imageView.image;
}

// 返回高质量图片的url
//- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
//{
//    NSString *urlStr = [self.urlArray[index] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
//    return [NSURL URLWithString:urlStr];
//}

+ (CGFloat)getHeaderHeight
{
    return 200;
}

@end
