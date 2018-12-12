//
//  ChatListViewController.m
//  BaseTrunk
//
//  Created by king on 2018/12/12.
//  Copyright © 2018 wang yong. All rights reserved.
//

#import "ChatListViewController.h"
#import "YCVideoListObject.h"
#import "ChatListCell.h"

@interface ChatListViewController ()

@end

@implementation ChatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorFromHexString:@"#212121" withAlpha:1.];
}

- (id)paramsObject:(BOOL)more
{
    YCVideoListObject *videoListObejct = [YCVideoListObject new];
    videoListObejct.page = 0;
    return videoListObejct;
}

- (Class)cellClass
{
    return [ChatListCell class];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
