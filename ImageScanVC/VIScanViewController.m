//
//  VIScanViewController.m
//  TTT
//
//  Created by LCQ on 15/3/20.
//  Copyright (c) 2015年 lcqgrey. All rights reserved.
//

#import "VIScanViewController.h"
#import "VISinglePageViewController.h"
#import "UCZProgressView.h"
#define MAS_SHORTHAND_GLOBALS
#import <Masonry.h>
#import <SDWebImage/SDWebImageManager.h>

@interface VIScanViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,VISinglePageViewControllerDelegate>
{
    BOOL additionViewHidden;
}


@property (nonatomic, strong) VITopView *topView;
@property (nonatomic, strong) VIBottomView *bottomView;
@property (nonatomic, assign) NSInteger currentPage;


@property (nonatomic, assign) UIInterfaceOrientation currentOrientation;

@end

@implementation VIScanViewController

- (instancetype)initWithTransitionStyle:(UIPageViewControllerTransitionStyle)style navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation options:(NSDictionary *)options
{
    self = [super initWithTransitionStyle:style navigationOrientation:navigationOrientation options:options];
    if (self) {
        self.portraitShowAdditionView = YES;
        self.landscapeShowAdditionView = NO;
        self.delegate = self;
        self.dataSource = self;
        self.topHeight = 64.f;
        self.bottomHeight = 118.f;
        _currentPage = -1;
        self.topViewBackgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.bottomViewBackgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.delegate = self;
    self.dataSource = self;
    self.view.backgroundColor = [UIColor blackColor];
    VISinglePageViewController *currentVC = [self viewControllerAtIndex:self.firstIndex];
    self.currentPage = _firstIndex;
    [self setViewControllers:@[currentVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    
    [self addTopView:_showTopView];
    [self addBottomView:_showBottomView];

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [UIApplication sharedApplication].statusBarHidden = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        if (width > height) {
            CGFloat topHeight = CGRectGetHeight(_topView.bounds);
            CGFloat bottomHeight = CGRectGetHeight(_bottomView.bounds);
            [_topView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(topHeight - _portraitToLandscapeTopHeight);
            }];
            
            [_bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(bottomHeight - _portraitToLandscapeBottomHeight);
            }];
        }
    });
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIApplication sharedApplication].statusBarHidden = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

- (void)addTopView:(BOOL)showTopView
{
    if (showTopView) {
        if (!self.topView) {
            self.topView = [[VITopView alloc] initWithFrame:CGRectZero];
            self.topView.backgroundColor = self.topViewBackgroundColor;
            [self.view addSubview:_topView];
            [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view);
                make.right.equalTo(self.view);
                make.top.equalTo(self.view);
                make.height.equalTo(self.topHeight);
            }];
            
        }
    }

}

- (void)addBottomView:(BOOL)showBottomView
{
    if (showBottomView) {
        if (!self.bottomView) {
            self.bottomView = [[VIBottomView alloc] initWithFrame:CGRectZero];
            self.bottomView.backgroundColor = self.bottomViewBackgroundColor;
            [self.view addSubview:_bottomView];
            [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view);
                make.right.equalTo(self.view);
                make.bottom.equalTo(self.view);
                make.height.equalTo(self.bottomHeight);
            }];

        }
    }
}


- (void)topViewSetting:(void(^)(VITopView *topView))setting
{
    if (setting) {
        setting(_topView);
    }
}

- (void)bottomViewSetting:(void(^)(VIBottomView *bottomView))setting
{
    if (setting) {
        setting(_bottomView);
    }
}

#pragma mark - private


- (void)setCurrentPage:(NSInteger)currentPage
{
    if (_currentPage == currentPage) {
        return;
    }
    _currentPage = currentPage;
    if (self.vIScrollDelegate && [self.vIScrollDelegate respondsToSelector:@selector(vIScanViewControllerScrollToPage:)]) {
        [self.vIScrollDelegate vIScanViewControllerScrollToPage:_currentPage];
    }
}

- (VISinglePageViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (([self.imageDataSource count] == 0) || (index >= [self.imageDataSource count])) {
        return nil;
    }
    // 创建一个新的控制器类，并且分配给相应的数据
    VISinglePageViewController *dataViewController =[[VISinglePageViewController alloc] init];
    dataViewController.model = [self.imageDataSource objectAtIndex:index];
    dataViewController.vipEventDelegate = self;
    
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(VISinglePageViewController *)viewController {
    return viewController.model.index;
}


#pragma mark - UIPageViewControllerDataSource


- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    self.currentPage = [self indexOfViewController:(VISinglePageViewController *)[pageViewController.viewControllers firstObject]];
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if (_imageDataSource.count == 1) {
        return nil;
    }
    
    NSInteger index = [self indexOfViewController:(VISinglePageViewController *)viewController];
    index = index - 1;
    if (index < 0) {
        index = 0;
        return nil;
    }

    VISinglePageViewController *newVC = [self viewControllerAtIndex:index];
    return newVC;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if (_imageDataSource.count == 1) {
        return nil;
    }
    NSInteger index = [self indexOfViewController:(VISinglePageViewController *)viewController];
    index = index + 1;
    if (index > _imageDataSource.count - 1) {
        index = _imageDataSource.count - 1;
        return nil;
    }
    
    VISinglePageViewController *newVC = [self viewControllerAtIndex:index];
    return newVC;
}

- (void)changeViewLayoutWithTopHeight:(CGFloat)topHeight withBottomHeight:(CGFloat)bottomHeight animation:(BOOL)animation
{
    [_topView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(topHeight);
    }];
    
    [_bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(bottomHeight);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGFloat sWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat sHeight = [UIScreen mainScreen].bounds.size.height;
        if (sWidth > sHeight) {
            if (!self.landscapeShowAdditionView && !additionViewHidden) {
                [self topAndBottomHidden:animation];
            }
            else if (self.landscapeShowAdditionView && additionViewHidden) {
                [self topAndBottomShow:animation];
            }
        }
        else {
            if (!self.portraitShowAdditionView && !additionViewHidden) {
                [self topAndBottomHidden:animation];
            }
            else if (self.portraitShowAdditionView && additionViewHidden) {
                [self topAndBottomShow:animation];
            }
        }
    });
    

}


- (void)rotationOperationWithOrientation:(UIInterfaceOrientation)orientation animation:(BOOL)animation
{
    CGFloat topHeight = CGRectGetHeight(_topView.bounds);
    CGFloat bottomHeight = CGRectGetHeight(_bottomView.bounds);
    
    if ((orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) && (_currentOrientation == UIInterfaceOrientationLandscapeLeft || _currentOrientation == UIInterfaceOrientationLandscapeRight)) {
        return;
    }
    else if ((orientation == UIInterfaceOrientationMaskPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) && (_currentOrientation == UIInterfaceOrientationMaskPortrait || _currentOrientation == UIInterfaceOrientationPortraitUpsideDown)) {
        return;
    }
    _currentOrientation = orientation;
    
    switch (orientation) {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            [self changeViewLayoutWithTopHeight:topHeight + _portraitToLandscapeTopHeight withBottomHeight:bottomHeight + _portraitToLandscapeBottomHeight animation:animation];
            
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
        {
            [self changeViewLayoutWithTopHeight:topHeight - _portraitToLandscapeTopHeight withBottomHeight:bottomHeight - _portraitToLandscapeBottomHeight animation:animation];
            
        }
            break;
            
        default:
            break;
    }
}

- (void)dealloc
{
    
}

#pragma mark - VIPhoto

- (void)didSingleTap:(UITapGestureRecognizer *)gesture
{
    if (additionViewHidden) {
        [self topAndBottomShow:YES];
    }
    else {
        [self topAndBottomHidden:YES];
    }
}


- (void)topAndBottomShow:(BOOL)animation
{
    additionViewHidden = NO;
    [_topView showAnimation:animation];
    [_bottomView showAnimation:animation];
}

- (void)topAndBottomHidden:(BOOL)animation
{
    additionViewHidden = YES;
    [_topView hiddenAnimation:animation];
    [_bottomView hiddenAnimation:animation];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self rotationOperationWithOrientation:toInterfaceOrientation animation:YES];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

@end
