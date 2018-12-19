//
//  MZMessageViewController.h
//  BaseTrunk
//
//  Created by King on 2018/12/19.
//  Copyright © 2018 wang yong. All rights reserved.
//

#import "JSQMessagesViewController.h"
#import "MZVideoListObject.h"

typedef NS_ENUM(NSInteger, AnimalTypeAction)
{
    AnimalTypeNormal,
    AnimalTypeEdit,
    AnimalTypeVoice,
    AnimalTypeFace,
    AnimalTypeMore
};

NS_ASSUME_NONNULL_BEGIN

@interface MZMessageViewController : JSQMessagesViewController 

- (instancetype)initWithUserObject:(MZVideoListInfoObject *)object;
- (void)receiveMessagePressed:(UIBarButtonItem *)sender;
- (void)closePressed:(UIBarButtonItem *)sender;

@end

NS_ASSUME_NONNULL_END
