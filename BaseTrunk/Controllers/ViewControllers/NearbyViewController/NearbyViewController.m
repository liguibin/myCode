//
//  YCNearbyViewController.m
//  Onion
//
//  Created by king on 2018/12/10.
//  Copyright © 2018 King. All rights reserved.
//

#import "NearbyViewController.h"
#import "YCNearbyCell.h"
#import "YCVideoListObject.h"

@implementation NearbyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor colorFromHexString:@"#212121" withAlpha:1.];
}

- (id)paramsObject:(BOOL)more
{
    YCVideoListObject *videoListObejct = [YCVideoListObject new];
    videoListObejct.pageSize = 20;
    if (more) {
        //        videoListObejct.page = last + 1;
    } else {
        //        [self setReset];
        //        if ([YCAppDelegate sharedAppDelegate].didFinishLaunching) {
        //            videoListObejct.page = 1; //启动app
        //            [YCAppDelegate sharedAppDelegate].didFinishLaunching = NO;
        //        } else {
        videoListObejct.page = 0; //手动刷新
        //        }
    }
    return videoListObejct;
}

- (Class)cellClass
{
    return [YCNearbyCell class];
}

@end
