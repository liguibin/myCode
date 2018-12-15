//
//  MZChatListViewController.m
//  BaseTrunk
//
//  Created by king on 2018/12/12.
//  Copyright © 2018 wang yong. All rights reserved.
//

#import "MZChatListViewController.h"
#import "MZVideoListObject.h"
#import "MZChatListCell.h"

@interface MZChatListViewController ()

@end

@implementation MZChatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor appBgColor];
}

- (id)paramsObject:(BOOL)more
{
    MZVideoListObject *videoListObejct = [MZVideoListObject new];
    videoListObejct.page = 0;
    return videoListObejct;
}

- (Class)cellClass
{
    return [MZChatListCell class];
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
