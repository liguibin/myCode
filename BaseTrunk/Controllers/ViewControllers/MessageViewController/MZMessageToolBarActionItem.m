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
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
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
    recordButton.frame = CGRectZero;
    [recordButton setTitle:@"按住 说话" forState:UIControlStateNormal];
    [recordButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageToolbarRecordBegin)]) {
        [recordButton addTarget:self.delegate action:@selector(messageToolbarRecordBegin) forControlEvents:UIControlEventTouchDown];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageToolbarRecordCancel)]) {
        [recordButton addTarget:self.delegate action:@selector(messageToolbarRecordCancel) forControlEvents:UIControlEventTouchUpOutside];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageToolbarRecordFinish)]) {
        [recordButton addTarget:self.delegate action:@selector(messageToolbarRecordFinish) forControlEvents:UIControlEventTouchUpInside];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageToolbarRecordGoOn)]) {
        [recordButton addTarget:self.delegate action:@selector(messageToolbarRecordGoOn) forControlEvents:UIControlEventTouchDragEnter];
    }
//    if (self.delegate && [self.delegate respondsToSelector:@selector(recordTouchDragInside:)]) {
//        [recordButton addTarget:self.delegate action:@selector(recordTouchDragInside:) forControlEvents:UIControlEventTouchDragInside];
//    }
    //    if (self.delegate && [self.delegate respondsToSelector:@selector(recordTouchDragOutside:)]) {
    //        [recordButton addTarget:self.delegate action:@selector(recordTouchDragOutside:) forControlEvents:UIControlEventTouchDragOutside];
//    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageToolbarRecordGoOn)]) {
        [recordButton addTarget:self.delegate action:@selector(messageToolbarRecordGoOn) forControlEvents:UIControlEventTouchDragExit];
    }
    return recordButton;
}

@end
