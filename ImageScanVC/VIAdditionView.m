//
//  VIAdditionView.m
//  TTT
//
//  Created by LCQ on 15/3/20.
//  Copyright (c) 2015年 lcqgrey. All rights reserved.
//

#import "VIAdditionView.h"
#define MAS_SHORTHAND_GLOBALS
#import <Masonry.h>

@interface VIAdditionView ()


@end

@implementation VIAdditionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setHeight:(CGFloat)height
{
    if (_height == height) {
        return;
    }
    _height = height;
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(_height);
    }];
}

- (void)showAnimation:(BOOL)animation
{

}


- (void)hiddenAnimation:(BOOL)animation
{
    
}


@end
