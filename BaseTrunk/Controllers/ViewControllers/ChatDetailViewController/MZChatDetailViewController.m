//
//  MZChatDetailViewController.m
//  BaseTrunk
//
//  Created by king on 2018/12/12.
//  Copyright © 2018 wang yong. All rights reserved.
//

#import "MZChatDetailViewController.h"

@interface MZChatDetailViewController ()

@property (nonatomic, retain) MZVideoListInfoObject *videoListInfoObject;

@end

@implementation MZChatDetailViewController

- (instancetype)initWithUserObject:(MZVideoListInfoObject *)object
{
    self = [super init];
    if (self) {
        self.videoListInfoObject = object;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.videoListInfoObject.nickname;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBarButtonItem)];
}

- (void)clickLeftBarButtonItem
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)paramsObject:(BOOL)more
{
    return nil;
}

@end
