//
//  VIScanViewController.h
//  TTT
//
//  Created by LCQ on 15/3/20.
//  Copyright (c) 2015年 lcqgrey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VITopView.h"
#import "VIBottomView.h"
#import "VIModel.h"

@protocol VIScanViewControllerDelegate <NSObject>

@optional
- (void)vIScanViewControllerScrollToPage:(NSInteger)page;

@end

@interface VIScanViewController : UIPageViewController

@property (nonatomic, assign) BOOL showTopView; //default NO
@property (nonatomic, assign) BOOL showBottomView; //default NO

    //不设置则为默认值top 64 bottom 118
@property (nonatomic, assign) CGFloat topHeight;
@property (nonatomic, assign) CGFloat bottomHeight;

@property (nonatomic, assign) NSInteger firstIndex; //first show index;

@property (nonatomic, assign) BOOL portraitShowAdditionView; //切换为竖屏是否显示附加视图,默认为YES
@property (nonatomic, assign) BOOL landscapeShowAdditionView; //切换为横屏是否显示附加视图,默认为NO

@property (nonatomic, assign) CGFloat portraitToLandscapeTopHeight; //竖屏与横屏顶部高度差，默认0
@property (nonatomic, assign) CGFloat portraitToLandscapeBottomHeight; //竖屏与横屏底部高度差，默认0

@property (nonatomic, strong) UIColor *topViewBackgroundColor;
@property (nonatomic, strong) UIColor *bottomViewBackgroundColor;

@property (nonatomic, strong) NSArray *imageDataSource;

@property (nonatomic, weak) id<VIScanViewControllerDelegate> vIScrollDelegate;


- (void)topViewSetting:(void(^)(VITopView *topView))setting;

- (void)bottomViewSetting:(void(^)(VIBottomView *bottomView))setting;

@end
