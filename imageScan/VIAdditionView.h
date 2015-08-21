//
//  VIAdditionView.h
//  TTT
//
//  Created by LCQ on 15/3/20.
//  Copyright (c) 2015年 lcqgrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VIAdditionView : UIView

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) BOOL prohibitAnimation;

- (void)showAnimation:(BOOL)animation;

- (void)hiddenAnimation:(BOOL)animation;


@end
