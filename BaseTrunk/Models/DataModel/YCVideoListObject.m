//
//  YCVideoListObject.m
//  BaseTrunk
//
//  Created by King on 2018/12/11.
//  Copyright © 2018 wang yong. All rights reserved.
//

#import "YCVideoListObject.h"

@implementation YCVideoListObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.url = @"feed/recommend";
        self.post = NO;
    }
    return self;
}

@end

@implementation YCVideoListInfoObject

@end
