//
//  VIBottomView.m
//  TTT
//
//  Created by LCQ on 15/3/20.
//  Copyright (c) 2015年 lcqgrey. All rights reserved.
//

#import "VIBottomView.h"
#define MAS_SHORTHAND_GLOBALS
#import <Masonry.h>

@interface VIBottomView ()
{
    UITextView *_customTextView;
    
}

@end

@implementation VIBottomView

- (void)showAnimation:(BOOL)animation
{
    if (self.prohibitAnimation) {
        return;
    }
    if (animation) {
        [UIView animateWithDuration:0.15 animations:^{
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.superview).offset(0);
            }];
            [self layoutIfNeeded];
        }];
    }
    else {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.superview).offset(0);
        }];
    }
    
}


- (void)hiddenAnimation:(BOOL)animation
{
    if (self.prohibitAnimation) {
        return;
    }
    if (animation) {
        [UIView animateWithDuration:0.15 animations:^{
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.superview).offset(CGRectGetHeight(self.bounds));
            }];
            [self layoutIfNeeded];
        }];
    }
    else {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.superview).offset(CGRectGetHeight(self.bounds));
        }];
    }
    
}


@end
