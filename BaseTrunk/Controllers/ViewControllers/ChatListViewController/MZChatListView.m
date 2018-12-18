//
//  MZChatListView.m
//  BaseTrunk
//
//  Created by king on 2018/12/12.
//  Copyright © 2018 wang yong. All rights reserved.
//

#import "MZChatListView.h"
#import "MZConfig.h"
#import "MZMessageViewController.h"
#import "MZVideoListObject.h"

@interface MZChatListView ()

@property (nonatomic, retain) UIImageView *avatarView;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) MZVideoListInfoObject *videoListInfoObject;

@end

@implementation MZChatListView

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
    self.avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(15., 15., 60., 60.)];
    [self addSubview:self.avatarView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.avatarView.right + 15., self.avatarView.top + 3., ScreenWidth - 200., 23.)];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = [UIFont systemFontOfSize:16.];
    self.nameLabel.numberOfLines = 1;
    self.nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self addSubview:self.nameLabel];
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

- (void)cellSelectedByIndexPath:(NSIndexPath *)index {
    MZMessageViewController *messageViewController = [[MZMessageViewController alloc] initWithUserObject:self.videoListInfoObject];
    messageViewController.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:messageViewController animated:YES];
}

+ (CGFloat)rowHeightForObject:(id)item {
    return 80.;
}

@end
