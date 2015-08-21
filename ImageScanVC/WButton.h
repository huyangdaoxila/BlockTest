//
//  WButton.h
//  WineApp
//
//  Created by stone on 14-8-7.
//  Copyright (c) 2014年 lcqgrey. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const kWButtonBgColor = @"WButtonBgColor";
static NSString *const kWButtonTitleNomal = @"WButtonTitleNomal";
static NSString *const kWButtonTitleHighlight = @"WButtonTitleHighlight";
static NSString *const kWButtonTitleSelected = @"WButtonTitleSelected";
static NSString *const kWButtonTitleDisabled = @"WButtonTitleDisabled";
static NSString *const kWButtonImageNomal = @"WButtonImageNomal";
static NSString *const kWButtonImageSelected = @"WButtonImageSelected";
static NSString *const kWButtonImageDisabled = @"kWButtonImageDisabled";
static NSString *const kWButtonImageHightlight = @"WButtonImageHightlight";
static NSString *const kWButtonBgImageNomal = @"kWButtonBgImageNomal";
static NSString *const kWButtonBgImageHightlight = @"kWButtonBgImageHightlight";
static NSString *const kWButtonTitleColorNomal = @"WButtonTitleColorNomal";
static NSString *const kWButtonTitleColorHighlight = @"WButtonTitleColorHighlight";
static NSString *const kWButtonTitleColorSelected = @"WButtonTitleColorSelected";
static NSString *const kWButtonTitleColorDisabled = @"WButtonTitleColorDisabled";
static NSString *const kWButtonTitleFont = @"WButtonTitleFont";


static NSString *const kWButtonFrame = @"WButtonFrame";
static NSString *const kWButtonContentHorizontalAlignment = @"WButtonContentHorizontalAlignment";
static NSString *const kWButtonContentVerticalAlignment = @"WButtonContentVerticalAlignment";

static NSString *const kWButtonLayerCornerRadius = @"WButtonLayerCornerRadius";
static NSString *const kWButtonLayerBorderColor = @"WButtonLayerBorderColor";
static NSString *const kWButtonLayerBorderWidth = @"WButtonLayerBorderWidth";
static NSString *const kWButtonLayerShadowColor = @"WButtonLayerShadowColor";
static NSString *const kWButtonLayerShadowOffSet = @"WButtonLayerShadowOffSet";
static NSString *const kWButtonLayerShadowOpacity = @"WButtonLayerShadowOpacity";
static NSString *const kWButtonLayerShadowPath = @"WButtonLayerShadowPath";

@class WButton;

typedef void(^ButtonClickEventTouchDown)(WButton *reuseBtn);
typedef void(^ButtonClickEventTouchDownRepeat)(WButton *reuseBtn);
typedef void(^ButtonClickEventTouchDragInside)(WButton *reuseBtn);
typedef void(^ButtonClickEventTouchDragOutside)(WButton *reuseBtn);
typedef void(^ButtonClickEventTouchDragEnter)(WButton *reuseBtn);
typedef void(^ButtonClickEventTouchDragExit)(WButton *reuseBtn);
typedef void(^ButtonClickEventTouchUpInside)(WButton *reuseBtn);
typedef void(^ButtonClickEventTouchUpOutside)(WButton *reuseBtn);
typedef void(^ButtonClickEventTouchCancel)(WButton *reuseBtn);

@interface WButton : UIButton



- (void)setBgNorColor:(UIColor *)bgNormalColor withBgHighlightedColor:(UIColor *)bgHighlightedColor withBorderColor:(UIColor *)borderColor withBorderWith:(CGFloat)width;

- (void)setAttributes:(NSDictionary *)attributes;


- (void)setTouchUpInsideBlock:(ButtonClickEventTouchUpInside)callBlock;
- (void)setTouchUpOutsideBlock:(ButtonClickEventTouchUpOutside)callBlock;
- (void)setTouchDownBlock:(ButtonClickEventTouchDown)callBlock;
- (void)setTouchDownRepeatBlock:(ButtonClickEventTouchDownRepeat)callBlock;
- (void)setTouchDragInsideBlock:(ButtonClickEventTouchDragInside)callBlock;
- (void)setTouchDragOutsideBlock:(ButtonClickEventTouchDragOutside)callBlock;
- (void)setTouchDragExitBlock:(ButtonClickEventTouchDragExit)callBlock;
- (void)setTouchDragEnterBlock:(ButtonClickEventTouchDragEnter)callBlock;
- (void)setTouchCancelBlock:(ButtonClickEventTouchCancel)callBlock;

- (void)setAttributes:(NSDictionary *)attributes withClickBlock:(ButtonClickEventTouchUpInside)callBlock;

@end
