//
//  VIPhotoView.h
//  VIPhotoViewDemo
//
//  Created by Vito on 1/7/15.
//  Copyright (c) 2015 vito. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VIPhotoView;

@protocol VIPhotoViewDelegate <NSObject>

@optional

- (void)vIImageLoadingStart;

- (void)vIImageLoadingWithProgress:(double)progress;

- (void)vIImageLoadingEndSuccess:(BOOL)success;


@end



@interface VIPhotoView : UIScrollView

@property (nonatomic, weak) id<VIPhotoViewDelegate> vipDelegate;

- (instancetype)initWithFrame:(CGRect)frame withDelegate:(id)delegate withGestureBlock:(void(^)(UITapGestureRecognizer *gesture))block;

- (void)setImage:(id)image;


@end
