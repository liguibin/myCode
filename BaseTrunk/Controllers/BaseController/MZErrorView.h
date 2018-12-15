//
//  MZErrorView.h
//  BaseTrunk
//
//  Created by wangyong on 15/8/9.
//  Copyright (c) 2015年 wang yong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MZErrorView : UIView

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *imageView;

- (void)setText:(NSString*)text detailText:(NSString *)detailText imageName:(NSString *)image;

@end
