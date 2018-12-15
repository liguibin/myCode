//
//  MZRecommendViewController.h
//  BaseTrunk
//
//  Created by King on 2018/12/11.
//  Copyright © 2018 wang yong. All rights reserved.
//

#import "MZCollectionApiViewController.h"

typedef NS_ENUM(NSInteger, ShowType)
{
    ShowTypeList = 1,
    ShowTypeGrid,
};

NS_ASSUME_NONNULL_BEGIN

@interface MZRecommendViewController : MZCollectionApiViewController

@property (nonatomic, assign, readonly) ShowType showType;

- (void)changeShowType:(ShowType)showType;

@end

NS_ASSUME_NONNULL_END
