//
//  MZProfileViewController.h
//  BaseTrunk
//
//  Created by king on 2018/12/12.
//  Copyright © 2018 wang yong. All rights reserved.
//

#import "MZTableApiViewController.h"
#import "MZVideoListObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface MZProfileViewController : MZTableApiViewController

@property (nonatomic, retain, readonly) MZVideoListInfoObject *videoListInfoObject;

@end

NS_ASSUME_NONNULL_END
