//
//  MZMessageToolBarActionItem.h
//  BaseTrunk
//
//  Created by King on 2018/12/19.
//  Copyright © 2018 wang yong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define kActionViewWidth 40
#define kActionViewPadding 10

@protocol MZMessageToolBarActionItemDelegate <NSObject>

@optional
- (void)messageToolbarVoiceButtonPressed;
- (void)messageToolbarFaceButtonPressed;
- (void)messageToolbarMoreButtonPressed;

- (void)messageToolbarRecordBegin;
- (void)messageToolbarRecordFinish;
- (void)messageToolbarRecordCancel;
- (void)messageToolbarRecordGoOn;
- (void)messageToolbarRecordWillCancel;

@end

@interface MZMessageToolBarActionItem : NSObject

@property (weak, nonatomic, nullable) id<MZMessageToolBarActionItemDelegate> delegate;

- (UIButton *)voiceButtonItem;
- (UIButton *)faceButtonItem;
- (UIButton *)moreButtonItem;
- (UIView *)rightBarItems;
- (UIButton *)recordButtonItem;

@end

NS_ASSUME_NONNULL_END
