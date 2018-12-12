//
//  ChatDetailViewController.h
//  BaseTrunk
//
//  Created by king on 2018/12/12.
//  Copyright © 2018 wang yong. All rights reserved.
//

#import "WYTableApiViewController.h"
#import "YCVideoListObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChatDetailViewController : WYTableApiViewController

- (instancetype)initWithUserObject:(YCVideoListInfoObject *)object;

@end

NS_ASSUME_NONNULL_END
