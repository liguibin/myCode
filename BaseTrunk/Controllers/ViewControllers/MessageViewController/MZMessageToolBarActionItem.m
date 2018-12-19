//
//  MZMessageToolBarActionItem.m
//  BaseTrunk
//
//  Created by King on 2018/12/19.
//  Copyright © 2018 wang yong. All rights reserved.
//

#import "MZMessageToolBarActionItem.h"

@implementation MZMessageToolBarActionItem

- (UIButton *)voiceButtonItem
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0., 0., kActionViewWidth, kActionViewWidth);
    [button setTitle:@"voice" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageToolbarVoiceButtonPressed)]) {
        [button addTarget:self.delegate action:@selector(messageToolbarVoiceButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}

- (UIButton *)faceButtonItem
{
    UIButton *faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    faceButton.frame = CGRectMake(0., 0., kActionViewWidth, kActionViewWidth);
    [faceButton setTitle:@"face" forState:UIControlStateNormal];
    [faceButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageToolbarFaceButtonPressed)]) {
        [faceButton addTarget:self.delegate action:@selector(messageToolbarFaceButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return faceButton;
}

- (UIButton *)moreButtonItem
{
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    moreButton.frame = CGRectMake(0., 0., kActionViewWidth, kActionViewWidth);
    [moreButton setTitle:@"+" forState:UIControlStateNormal];
    [moreButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageToolbarMoreButtonPressed)]) {
        [moreButton addTarget:self.delegate action:@selector(messageToolbarMoreButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return moreButton;
}


- (UIView *)rightBarItems
{
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UIButton *faceButton = [self faceButtonItem];
    [rightView addSubview:faceButton];
    
    UIButton *actionButton = [self moreButtonItem];
    actionButton.frame = CGRectMake(CGRectGetWidth(actionButton.frame) + kActionViewPadding, 0., kActionViewWidth, kActionViewWidth);
    [rightView addSubview:actionButton];

    CGFloat viewWidth = CGRectGetWidth(faceButton.frame) + CGRectGetWidth(actionButton.frame) + 10;
    rightView.frame = CGRectMake(ScreenWidth - viewWidth - kActionViewPadding, 0, viewWidth, kActionViewWidth);
    
    return rightView;
}

- (UIButton *)recordButtonItem
{
    UIButton *recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    recordButton.frame = CGRectMake(0., 0., kActionViewWidth, kActionViewWidth);
    [recordButton setTitle:@"按住 说话" forState:UIControlStateNormal];
    [recordButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [recordButton addTarget:self action:@selector(recordTouchDown:) forControlEvents:UIControlEventTouchDown];
    [recordButton addTarget:self action:@selector(recordTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
    [recordButton addTarget:self action:@selector(recordTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [recordButton addTarget:self action:@selector(recordTouchDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
    [recordButton addTarget:self action:@selector(recordTouchDragInside:) forControlEvents:UIControlEventTouchDragInside];
    [recordButton addTarget:self action:@selector(recordTouchDragOutside:) forControlEvents:UIControlEventTouchDragOutside];
    [recordButton addTarget:self action:@selector(recordTouchDragExit:) forControlEvents:UIControlEventTouchDragExit];
    return recordButton;
}

- (void)recordTouchDown:(UIButton *)button
{
    [button setTitle:@"松开 结束" forState:UIControlStateNormal];
    NSLog(@"开始录音");
}

- (void)recordTouchUpOutside:(UIButton *)button
{
    NSLog(@"取消录音");
}

- (void)recordTouchUpInside:(UIButton *)button
{
    NSLog(@"完成录音");
}

- (void)recordTouchDragEnter:(UIButton *)button
{
    NSLog(@"继续录音");
}

- (void)recordTouchDragInside:(UIButton *)button
{
    
}

- (void)recordTouchDragOutside:(UIButton *)button
{
    
}

- (void)recordTouchDragExit:(UIButton *)button
{
    NSLog(@"将要取消录音");
}

@end
