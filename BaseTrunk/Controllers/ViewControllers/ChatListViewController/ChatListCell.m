//
//  ChatListCell.m
//  BaseTrunk
//
//  Created by king on 2018/12/12.
//  Copyright © 2018 wang yong. All rights reserved.
//

#import "ChatListCell.h"
#import "ChatListView.h"

@interface ChatListCell ()

@property (nonatomic, strong) ChatListView *chatListView;

@end

@implementation ChatListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.chatListView = [[ChatListView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, [[self class] rowHeightForObject:nil])];
        [self.contentView addSubview:self.chatListView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = v;
    }
    return self;
}

- (void)setObject:(id)item
{
    if (item && [item isKindOfClass:[NSDictionary class]]) {
        [self.chatListView setObject:item];
    }
}

- (void)cellSelectedByIndexPath:(NSIndexPath *)index{
    if(self.chatListView){
        [self.chatListView cellSelectedByIndexPath:index];
    }
}

+ (CGFloat)rowHeightForObject:(id)item
{
    return [ChatListView rowHeightForObject:item];
}

@end
