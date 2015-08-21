//
//  VISinglePageViewController.h
//  testApp
//
//  Created by LCQ on 15/3/20.
//  Copyright (c) 2015年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIPhotoView.h"
#import "VIModel.h"


@protocol VISinglePageViewControllerDelegate <NSObject>

@optional
- (void)didSingleTap:(UITapGestureRecognizer *)gesture;


@end

@interface VISinglePageViewController : UIViewController

@property (nonatomic, strong) VIPhotoView *photoView;
@property (nonatomic, strong) VIModel *model;
@property (nonatomic, weak) id<VISinglePageViewControllerDelegate> vipEventDelegate;


@end
