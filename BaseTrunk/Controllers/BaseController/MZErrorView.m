//
//  MZErrorView.m
//  BaseTrunk
//
//  Created by wangyong on 15/8/9.
//  Copyright (c) 2015年 wang yong. All rights reserved.
//

#import "MZErrorView.h"

@implementation MZErrorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 150, 150)];
        [_imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:_imageView];
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 280, 15)];
        [_textLabel setFont:[UIFont systemFontOfSize:14.]];
        [_textLabel setTextColor:[UIColor colorWithRed:155./255. green:155./255. blue:155./255. alpha:1.0]];
        [_textLabel setTextAlignment:NSTextAlignmentCenter];
        [_textLabel setBackgroundColor:[UIColor clearColor]];
        
        self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _textLabel.bottom + 2, 280, 30)];
        [_detailLabel setFont:[UIFont systemFontOfSize:12.]];
        [_detailLabel setTextColor:[UIColor black75PercentColor]];
        [_detailLabel setTextAlignment:NSTextAlignmentCenter];
        [_detailLabel setBackgroundColor:[UIColor clearColor]];
        [_detailLabel setNumberOfLines:0];
        [_detailLabel setClipsToBounds:NO];
        
        //[_errorView addSubview:_errorImageView];
        [self addSubview:_textLabel];
        [self addSubview:_detailLabel];
    }
    
    return self;
}

- (void)setText:(NSString*)text detailText:(NSString *)detailText imageName:(NSString *)imageName
{
    [self setHidden:NO];
    
    if(text)
    {
        [_textLabel setText:text];
    }
    
    if(detailText)
    {
        [_detailLabel setText:detailText];
    }
    
    if(imageName && imageName.length > 0)
    {
        [_imageView setHidden:NO];
        [_imageView setImage:[UIImage imageNamed:imageName]];
        [_imageView setCenterX:self.centerX];
        [_imageView setTop:(self.height - self.imageView.height)/2];
        [_textLabel setTop:_imageView.bottom + 8];
        [_textLabel setCenterX:self.centerX];
        [_detailLabel setTop:_textLabel.bottom + 8];
        [_detailLabel setCenterX:self.centerX];
    }
    else
    {
        [_imageView setHidden:YES];
        [_textLabel setCenterY:(self.height - _textLabel.height)/2.0];
        [_textLabel setCenterX:self.centerX];
        [_detailLabel setTop:_textLabel.bottom + 8];
        [_detailLabel setCenterX:self.centerX];
    }
}

@end
