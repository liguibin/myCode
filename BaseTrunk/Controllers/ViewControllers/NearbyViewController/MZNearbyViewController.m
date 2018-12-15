//
//  MZNearbyViewController.m
//  Onion
//
//  Created by king on 2018/12/10.
//  Copyright © 2018 King. All rights reserved.
//

#import "MZNearbyViewController.h"
#import "MZNearbyCell.h"
#import "MZVideoListObject.h"

@interface MZNearbyViewController ()

{
    NSInteger last;
}

@end

@implementation MZNearbyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor appBgColor];
}

- (void)requestDidFinishLoad:(id)data
{
    [super requestDidFinishLoad:data];
    if(data && [data isKindOfClass:[NSDictionary class]])
    {
        last = [[data objectForKey:@"last"] integerValue];
        if ([data containsObjectForKey:@"last"]) {
            last = [data intValueForKey:@"last" default:0];
        }
    }
}

- (id)paramsObject:(BOOL)more
{
    MZVideoListObject *videoListObejct = [MZVideoListObject new];
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
    return [MZNearbyCell class];
}

@end
