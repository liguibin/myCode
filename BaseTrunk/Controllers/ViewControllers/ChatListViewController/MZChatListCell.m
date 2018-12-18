//
//  MZChatListCell.m
//  BaseTrunk
//
//  Created by king on 2018/12/12.
//  Copyright © 2018 wang yong. All rights reserved.
//

#import "MZChatListCell.h"
#import "MZChatListView.h"

@interface MZChatListCell ()

@property (nonatomic, strong) MZChatListView *chatListView;

@end

@implementation MZChatListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.chatListView = [[MZChatListView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, [[self class] rowHeightForObject:nil])];
        [self.contentView addSubview:self.chatListView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor appBgColor];
    }
    return self;
}

- (void)setObject:(id)item
{
    if (item && [item isKindOfClass:[NSDictionary class]]) {
        [self.chatListView setObject:item];
    }
}

- (void)cellSelectedByIndexPath:(NSIndexPath *)index {
    if(self.chatListView){
        [self.chatListView cellSelectedByIndexPath:index];
    }
}

+ (CGFloat)rowHeightForObject:(id)item
{
    return [MZChatListView rowHeightForObject:item];
}

@end
