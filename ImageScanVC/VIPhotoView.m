//
//  VIPhotoView.m
//  VIPhotoViewDemo
//
//  Created by Vito on 1/7/15.
//  Copyright (c) 2015 vito. All rights reserved.
//

#import "VIPhotoView.h"
#import <SDWebImage/SDWebImageManager.h>
#define MAS_SHORTHAND_GLOBALS
#import <Masonry.h>

@interface UIImage (VIUtil)

- (CGSize)sizeThatFits:(CGSize)size;

@end

@implementation UIImage (VIUtil)

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize imageSize = CGSizeMake(self.size.width / self.scale,
                                  self.size.height / self.scale);
    
    CGFloat widthRatio = imageSize.width / size.width;
    CGFloat heightRatio = imageSize.height / size.height;
    
    if (widthRatio > heightRatio) {
        imageSize = CGSizeMake(size.width, imageSize.height / widthRatio);
    } else {
        imageSize = CGSizeMake(size.height, imageSize.height / heightRatio);
    }
    
    return imageSize;
}

@end

@interface UIImageView (VIUtil)

- (CGSize)contentSize;

@end

@implementation UIImageView (VIUtil)

- (CGSize)contentSize
{
    return [self.image sizeThatFits:self.bounds.size];
}

@end

@interface VIPhotoView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic) BOOL rotating;
@property (nonatomic) CGSize minSize;

@property (nonatomic, copy) void(^gestureOperation)(UITapGestureRecognizer *gesture);

@end

@implementation VIPhotoView


- (instancetype)initWithFrame:(CGRect)frame withDelegate:(id)delegate withGestureBlock:(void (^)(UITapGestureRecognizer *gesture))block
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.bouncesZoom = NO;
        self.backgroundColor = [UIColor blackColor];
        
        
        // Add container view
        
        
        self.gestureOperation = block;
        
        UIView *containerView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:containerView];
        _containerView = containerView;
        if (delegate) {
            self.vipDelegate = delegate;
        }
        
        
        [self setupGestureRecognizer];
    }
    return self;
}


- (void)setImage:(id)image
{
    [self dealImage:image];
}

- (void)dealImage:(id)image
{
    if ([image isKindOfClass:[NSString class]]) {
        // Add image view
        
        if (self.vipDelegate && [self.vipDelegate respondsToSelector:@selector(vIImageLoadingStart)]) {
            [self.vipDelegate vIImageLoadingStart];
        }
        __weak typeof(self) weakself = self;
        
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:image] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            double progress = receivedSize/(double)expectedSize;
            if (weakself.vipDelegate && [weakself.vipDelegate respondsToSelector:@selector(vIImageLoadingWithProgress:)]) {
                [weakself.vipDelegate vIImageLoadingWithProgress:progress];
            }
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (image && !error) {
                [weakself addImageView:image];
                if (self.vipDelegate && [self.vipDelegate respondsToSelector:@selector(vIImageLoadingEndSuccess:)]) {
                    [self.vipDelegate vIImageLoadingEndSuccess:YES];
                }
            }
            else {
                UIImage *failImage = [UIImage imageNamed:@"library.bundle/placeholder"];
                [weakself addImageView:failImage];
                if (self.vipDelegate && [self.vipDelegate respondsToSelector:@selector(vIImageLoadingEndSuccess:)]) {
                    [self.vipDelegate vIImageLoadingEndSuccess:NO];
                }
            }

        } ];
    }
    else {
        [self addImageView:image];
    }
}

- (void)addImageView:(UIImage *)image
{
    // Add image view
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = _containerView.bounds;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_containerView addSubview:imageView];
    _imageView = imageView;
    
    
    [self calculateSize];
    [self setMaxMinZoomScale];
    [self centerContent];
    
    // Setup other events
    [self setupRotationNotification];
    
}


- (void)calculateSize
{
    // Fit container view's size to image size
    if (_imageView.image) {
        CGSize size = _imageView.image.size;
        CGFloat scale = size.width/size.height;
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        CGFloat widthScale = size.width/width;
        CGFloat heightScale = size.height/height;
        if (widthScale > heightScale) {
            self.containerView.frame = CGRectMake(0, 0, width, width / scale);
        }
        else {
            self.containerView.frame = CGRectMake(0, 0, height * scale, height);
            
        }
        
        width = CGRectGetWidth(_containerView.bounds);
        height = CGRectGetHeight(_containerView.bounds);
        
        self.contentSize = CGSizeMake(width, height);
    }
    
    // Center containerView by set insets
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.rotating) {
        self.rotating = NO;
        // Center container view
        [self centerContent];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Setup

- (void)setupRotationNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
}

- (void)setupGestureRecognizer
{
    
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapHandle:)];
    
    [self addGestureRecognizer:tapG];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    tapGestureRecognizer.numberOfTapsRequired = 2;
    [self addGestureRecognizer:tapGestureRecognizer];
    
    [tapG requireGestureRecognizerToFail:tapGestureRecognizer];
}


#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.containerView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self centerContent];
}

#pragma mark - GestureRecognizer

- (void)tapHandler:(UITapGestureRecognizer *)recognizer
{
    if (self.zoomScale > self.minimumZoomScale) {
        [self setZoomScale:self.minimumZoomScale animated:YES];
    } else if (self.zoomScale < self.maximumZoomScale) {
        CGPoint location = [recognizer locationInView:recognizer.view];
        CGRect zoomToRect = CGRectMake(0, 0, 50, 50);
        zoomToRect.origin = CGPointMake(location.x - CGRectGetWidth(zoomToRect)/2, location.y - CGRectGetHeight(zoomToRect)/2);
        [self zoomToRect:zoomToRect animated:YES];
    }
}

- (void)singleTapHandle:(UITapGestureRecognizer *)recognizer
{
    if (self.gestureOperation) {
        self.gestureOperation(recognizer);
    }
}

#pragma mark - Notification

- (void)orientationChanged:(NSNotification *)notification
{
    self.rotating = YES;
    [self setZoomScale:self.minimumZoomScale animated:NO];
    [self calculateSize];
}


#pragma mark - Helper

- (void)setMaxMinZoomScale
{
    self.maximumZoomScale = 2.0;
    self.minimumZoomScale = 1.0;
}

- (void)centerContent
{
    CGRect frame = self.containerView.frame;
    
    CGFloat top = 0, left = 0;
    if (self.contentSize.width < self.bounds.size.width) {
        left = (self.bounds.size.width - self.contentSize.width) * 0.5f;
    }
    if (self.contentSize.height < self.bounds.size.height) {
        top = (self.bounds.size.height - self.contentSize.height) * 0.5f;
    }
    
    top -= frame.origin.y;
    left -= frame.origin.x;
    
    self.contentInset = UIEdgeInsetsMake(top, left, top, left);
}

@end
