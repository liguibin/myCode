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

@interface NearbyViewController ()

{
    NSInteger last;
}

@end

@implementation NearbyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorFromHexString:@"#212121" withAlpha:1.];
}

- (void)requestDidFinishLoad:(id)data
{
    [super requestDidFinishLoad:data];
    if(data && [data isKindOfClass:[NSDictionary class]])
    {
        last = [[data objectForKey:@"last"] integerValue];
//        if ([data containsObjectForKey:@"last"]) {
//            last = [data intValueForKey:@"last" default:0];
//        }
    }
}

- (id)paramsObject:(BOOL)more
{
    YCVideoListObject *videoListObejct = [YCVideoListObject new];
    videoListObejct.pageSize = 20;
    if (more) {
        videoListObejct.page = last + 1;
    } else {
        videoListObejct.page = 0; //手动刷新
    }
    
    return videoListObejct;
}

- (Class)cellClass
{
    return [YCNearbyCell class];
}

@end
