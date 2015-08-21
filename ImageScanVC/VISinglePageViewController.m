//
//  VISinglePageViewController.m
//  testApp
//
//  Created by LCQ on 15/3/20.
//  Copyright (c) 2015年 simple. All rights reserved.
//

#import "VISinglePageViewController.h"
#import "UCZProgressView.h"
#import "DXLBaseUtils.h"
#define MAS_SHORTHAND_GLOBALS
#import <Masonry.h>

@interface VISinglePageViewController ()<VIPhotoViewDelegate>
{
    UIActivityIndicatorView *activity;
}
@property (nonatomic, strong) UCZProgressView *progressView;

@end

@implementation VISinglePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __weak typeof(self) weakself = self;
    self.photoView = [[VIPhotoView alloc] initWithFrame:self.view.frame withDelegate:self withGestureBlock:^(UITapGestureRecognizer *gesture) {
        if (weakself.vipEventDelegate && [weakself.vipEventDelegate respondsToSelector:@selector(didSingleTap:)]) {
            [weakself.vipEventDelegate didSingleTap:gesture];
        }
    }];
    [self.view addSubview:_photoView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.photoView setImage:_model.image];
    });
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [_photoView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - Progress

- (void)addProgressView
{
    if (!self.progressView) {
        self.progressView = [[UCZProgressView alloc] initWithFrame:CGRectZero];
        _progressView.showsText = YES;
        _progressView.tintColor = [DXLBaseUtils getColor:@"999999"];
        _progressView.textColor = [DXLBaseUtils getColor:@"999999"];
        _progressView.backgroundView.backgroundColor = [UIColor clearColor];
        _progressView.indeterminate = NO;
        _progressView.finishAnimation = NO;
        [self.photoView addSubview:_progressView];
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.photoView.mas_centerX);
            make.centerY.equalTo(self.photoView.mas_centerY);
            make.width.equalTo(80);
            make.height.equalTo(80);
        }];
    }

    
    activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.photoView addSubview:activity];
    [activity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.photoView);
    }];
    
    [activity startAnimating];
}


#pragma mark - VIPhotoView Delegate


- (void)vIImageLoadingStart
{
    [self addProgressView];
}

- (void)vIImageLoadingWithProgress:(double)progress
{
    if (progress > 0.01) {
        if (activity) {
            [activity  stopAnimating];
            activity = nil;
        }
        [_progressView setProgress:progress animated:YES];
    }
}

- (void)vIImageLoadingEndSuccess:(BOOL)success
{
    if (activity) {
        [activity  stopAnimating];
        activity = nil;
    }
    [_progressView setProgress:1 animated:YES];
}

- (void)dealloc
{
    
}

@end
