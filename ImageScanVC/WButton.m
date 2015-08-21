//
//  WButton.m
//  WineApp
//
//  Created by stone on 14-8-7.
//  Copyright (c) 2014年 lcqgrey. All rights reserved.
//

#import "WButton.h"
#import "DXLBaseUtils.h"
#import <objc/runtime.h>

#define ButtonRadius 5
#define ButtonClickMinInterval 1

@interface WButton ()

@property (nonatomic, strong) NSDate *lastClickDate;

@property (nonatomic, copy) ButtonClickEventTouchDown downBlock;
@property (nonatomic, copy) ButtonClickEventTouchDownRepeat downRepeatBlock;
@property (nonatomic, copy) ButtonClickEventTouchDragInside dragInsideBlock;
@property (nonatomic, copy) ButtonClickEventTouchDragOutside dragOutsideBlock;
@property (nonatomic, copy) ButtonClickEventTouchDragExit dragExitBlock;
@property (nonatomic, copy) ButtonClickEventTouchDragEnter dragEnterBlock;
@property (nonatomic, copy) ButtonClickEventTouchUpInside upInsideBlock;
@property (nonatomic, copy) ButtonClickEventTouchUpOutside upOutsideBlock;
@property (nonatomic, copy) ButtonClickEventTouchCancel cancelBlock;

@end

@implementation WButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)setBgNorColor:(UIColor *)bgNormalColor withBgHighlightedColor:(UIColor *)bgHighlightedColor withBorderColor:(UIColor *)borderColor withBorderWith:(CGFloat)width
{
    self.layer.cornerRadius = ButtonRadius;
    if (borderColor) {
        [self.layer setBorderColor:borderColor.CGColor];
    }
    if (width != 0) {
        [self.layer setBorderWidth:width];
    }
    if (bgNormalColor) {
        UIImage *image = [DXLBaseUtils imageWithColor:bgNormalColor];
        [self setBackgroundImage:image forState:UIControlStateNormal];
    }
    if (bgHighlightedColor) {
        UIImage *bg = [DXLBaseUtils imageWithColor:bgHighlightedColor];
        [self setBackgroundImage:bg forState:UIControlStateHighlighted];
    }
}

- (void)setAttributes:(NSDictionary *)attributes
{
    [self setAttributes:attributes withClickBlock:nil];
}

- (void)setAttributes:(NSDictionary *)attributes withClickBlock:(ButtonClickEventTouchUpInside)callBlock
{
    [self setTouchUpInsideBlock:callBlock];
    
    for (NSString *key in attributes) {
        id value = [attributes objectForKey:key];
        if ([key caseInsensitiveCompare:kWButtonBgColor] == NSOrderedSame) {
            UIColor *color = [DXLBaseUtils getColor:value];
            if (color) {
                [self setBackgroundColor:color];
            }
            else {
                [self inputError:kWButtonBgColor class:@[@"UIColor",@"NSString"]];
            }
        }
        else if ([key caseInsensitiveCompare:kWButtonTitleNomal] == NSOrderedSame) {
            if ([value isKindOfClass:[NSString class]]) {
                [self setTitle:value forState:UIControlStateNormal];
            }
            else {
                [self inputError:kWButtonTitleNomal class:@[@"NSString"]];
            }
        }
        else if ([key caseInsensitiveCompare:kWButtonTitleHighlight] == NSOrderedSame) {
            if ([value isKindOfClass:[NSString class]]) {
                [self setTitle:value forState:UIControlStateHighlighted];
            }
            else {
                [self inputError:kWButtonTitleHighlight class:@[@"NSString"]];
            }
        }
        else if ([key caseInsensitiveCompare:kWButtonTitleSelected] == NSOrderedSame) {
            if ([value isKindOfClass:[NSString class]]) {
                [self setTitle:value forState:UIControlStateSelected];
            }
            else {
                [self inputError:kWButtonTitleSelected class:@[@"NSString"]];
            }
        }
        else if ([key caseInsensitiveCompare:kWButtonTitleDisabled] == NSOrderedSame) {
            if ([value isKindOfClass:[NSString class]]) {
                [self setTitle:value forState:UIControlStateDisabled];
            }
            else {
                [self inputError:kWButtonTitleDisabled class:@[@"NSString"]];
            }
        }
        else if ([key caseInsensitiveCompare:kWButtonTitleColorNomal] == NSOrderedSame) {
            UIColor *color = [DXLBaseUtils getColor:value];
            if (color) {
                [self setTitleColor:color forState:UIControlStateNormal];
            }
            else {
                [self inputError:kWButtonTitleColorNomal class:@[@"UIColor",@"NSString"]];
            }
        }
        else if ([key caseInsensitiveCompare:kWButtonTitleColorHighlight] == NSOrderedSame) {
            UIColor *color = [DXLBaseUtils getColor:value];
            if (color) {
                [self setTitleColor:color forState:UIControlStateHighlighted];
            }
            else {
                [self inputError:kWButtonTitleColorHighlight class:@[@"UIColor",@"NSString"]];
            }
        }
        else if ([key caseInsensitiveCompare:kWButtonTitleColorSelected] == NSOrderedSame) {
            UIColor *color = [DXLBaseUtils getColor:value];
            if (color) {
                [self setTitleColor:color forState:UIControlStateSelected];
            }
            else {
                [self inputError:kWButtonTitleColorSelected class:@[@"UIColor",@"NSString"]];
            }
        }
        else if ([key caseInsensitiveCompare:kWButtonTitleColorDisabled] == NSOrderedSame) {
            UIColor *color = [DXLBaseUtils getColor:value];
            if (color) {
                [self setTitleColor:color forState:UIControlStateDisabled];
            }
            else {
                [self inputError:kWButtonTitleColorDisabled class:@[@"UIColor",@"NSString"]];
            }
        }
        else if ([key caseInsensitiveCompare:kWButtonTitleFont] == NSOrderedSame) {
            UIFont *font = [DXLBaseUtils getFont:value];
            if (font) {
                self.titleLabel.font = font;
            }
            else {
                [self inputError:kWButtonTitleFont class:@[@"UIFont",@"NSString"]];
            }
        }
        else if ([key caseInsensitiveCompare:kWButtonImageNomal] == NSOrderedSame) {
            UIImage *image = [DXLBaseUtils getImage:value];
            if (image) {
                [self setImage:image forState:UIControlStateNormal];
            }
        }
        else if ([key caseInsensitiveCompare:kWButtonImageSelected] == NSOrderedSame)
        {
            UIImage *image = [DXLBaseUtils getImage:value];
            if (image) {
                [self setImage:image forState:UIControlStateSelected];
            }
        }
        else if ([key caseInsensitiveCompare:kWButtonImageDisabled] == NSOrderedSame) {
            UIImage *image = [DXLBaseUtils getImage:value];
            if (image) {
                [self setImage:image forState:UIControlStateDisabled];
            }
        }
        else if ([key caseInsensitiveCompare:kWButtonImageHightlight] == NSOrderedSame) {
            UIImage *image = [DXLBaseUtils getImage:value];
            if (image) {
                [self setImage:image forState:UIControlStateHighlighted];
            }
        }
        else if ([key caseInsensitiveCompare:kWButtonBgImageNomal] == NSOrderedSame)
        {
            UIImage * image = [self imageWithColor:[DXLBaseUtils getColor:value] size:self.frame.size];
            if (image) {
                [self setBackgroundImage:image forState:UIControlStateNormal];
            }
        }
        else if ([key caseInsensitiveCompare:kWButtonBgImageHightlight] == NSOrderedSame)
        {
            UIImage * image = [self imageWithColor:[DXLBaseUtils getColor:value] size:self.frame.size];
            if (image) {
                [self setBackgroundImage:image forState:UIControlStateHighlighted];
            }
        }
        else if ([key caseInsensitiveCompare:kWButtonLayerCornerRadius] == NSOrderedSame) {
            if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
                [self.layer setCornerRadius:[value floatValue]];
                self.layer.masksToBounds = YES;
            }
            else {
                [self inputError:kWButtonLayerCornerRadius class:@[@"NSString",@"NSNumber"]];
            }
        }
        else if ([key caseInsensitiveCompare:kWButtonLayerBorderWidth] == NSOrderedSame) {
            if ([value isKindOfClass:[NSString class]]) {
                [self.layer setBorderWidth:[value floatValue]];
            }
            else {
                [self inputError:kWButtonLayerBorderColor class:@[@"NSString"]];
            }
        }
        else if ([key caseInsensitiveCompare:kWButtonLayerBorderColor] == NSOrderedSame) {
            UIColor *color = [DXLBaseUtils getColor:value];
            if (color) {
                [self.layer setBorderColor:color.CGColor];
            }
            else {
                [self inputError:kWButtonLayerBorderColor class:@[@"UIColor",@"NSString"]];
            }
        }
        else if ([key caseInsensitiveCompare:kWButtonLayerShadowOffSet] == NSOrderedSame) {
            CGSize size = [DXLBaseUtils getSize:value];
            if (!CGSizeEqualToSize(size, CGSizeZero)) {
                [self.layer setShadowOffset:size];
            }
            else {
                [self inputError:kWButtonFrame class:@[@"NSValue",@"NSString"]];
            }
        }
        else if ([key caseInsensitiveCompare:kWButtonLayerShadowColor] == NSOrderedSame) {
            UIColor *color = [DXLBaseUtils getColor:value];
            if (color) {
                [self.layer setShadowColor:color.CGColor];
            }
            else {
                [self inputError:kWButtonLayerShadowColor class:@[@"UIColor",@"NSString"]];
            }
        }
        else if ([key caseInsensitiveCompare:kWButtonLayerShadowOpacity] == NSOrderedSame) {
            if ([value isKindOfClass:[NSString class]]) {
                [self.layer setShadowOpacity:[value floatValue]];
            }
            else {
                [self inputError:kWButtonLayerShadowOpacity class:@[@"NSString"]];
            }
        }
        else if ([key caseInsensitiveCompare:kWButtonFrame] == NSOrderedSame) {
            CGRect frame = [DXLBaseUtils getFrame:value];
            if (!CGRectEqualToRect(frame, CGRectNull)) {
                self.frame = frame;
            }
            else {
                [self inputError:kWButtonFrame class:@[@"NSValue",@"NSString"]];
            }
        }
        else if ([key caseInsensitiveCompare:kWButtonContentHorizontalAlignment] == NSOrderedSame) {
            if ([value isKindOfClass:[NSNumber class]]) {
                self.contentHorizontalAlignment = [value integerValue];
            }
            else {
                [self inputError:kWButtonFrame class:@[@"NSNumber"]];
            }
        }
        else if ([key caseInsensitiveCompare:kWButtonContentVerticalAlignment] == NSOrderedSame) {
            if ([value isKindOfClass:[NSNumber class]]) {
                self.contentVerticalAlignment = [value integerValue];
            }
            else {
                [self inputError:kWButtonFrame class:@[@"NSNumber"]];
            }
        }
        else {
            [self inputError:key class:nil];
        }
    }
    
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, .0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [color set];
    CGContextFillRect(context, CGRectMake(.0, .0, size.width, size.height));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)setTouchUpInsideBlock:(ButtonClickEventTouchUpInside)callBlock
{
    if (callBlock) {
        [self addEvent:UIControlEventTouchUpInside with:@selector(clickButtonEventUpInside)];
        self.upInsideBlock = callBlock;
    }
}

- (void)setTouchUpOutsideBlock:(ButtonClickEventTouchUpOutside)callBlock
{
    if (callBlock) {
        [self addEvent:UIControlEventTouchUpOutside with:@selector(clickButtonEventUpOutside)];
        self.upOutsideBlock = callBlock;
    }
}


- (void)setTouchDownBlock:(ButtonClickEventTouchDown)callBlock
{
    if (callBlock) {
        [self addEvent:UIControlEventTouchDown with:@selector(clickButtonEventDown)];
        self.downBlock = callBlock;
    }
}

- (void)setTouchDownRepeatBlock:(ButtonClickEventTouchDownRepeat)callBlock
{
    if (callBlock) {
        [self addEvent:UIControlEventTouchDownRepeat with:@selector(clickButtonEventDownRepeat)];
        self.downRepeatBlock = callBlock;
    }
}

- (void)setTouchDragEnterBlock:(ButtonClickEventTouchDragEnter)callBlock
{
    if (callBlock) {
        [self addEvent:UIControlEventTouchDragEnter with:@selector(clickButtonEventDragEnter)];
        self.dragEnterBlock = callBlock;
    }
}

- (void)setTouchDragExitBlock:(ButtonClickEventTouchDragExit)callBlock
{
    if (callBlock) {
        [self addEvent:UIControlEventTouchDragExit with:@selector(clickButtonEventDragExit)];
        self.dragExitBlock = callBlock;
    }
}

- (void)setTouchDragInsideBlock:(ButtonClickEventTouchDragInside)callBlock
{
    if (callBlock) {
        [self addEvent:UIControlEventTouchDragInside with:@selector(clickButtonEventDragInside)];
        self.dragInsideBlock = callBlock;
    }
}

- (void)setTouchDragOutsideBlock:(ButtonClickEventTouchDragOutside)callBlock
{
    if (callBlock) {
        [self addEvent:UIControlEventTouchDragOutside with:@selector(clickButtonEventDragOutside)];
        self.dragOutsideBlock = callBlock;
    }
}

- (void)setTouchCancelBlock:(ButtonClickEventTouchCancel)callBlock
{
    if (callBlock) {
        [self addEvent:UIControlEventTouchCancel with:@selector(clickButtonEventCancel)];
        self.cancelBlock = callBlock;
    }
}



- (void)addEvent:(UIControlEvents)event with:(SEL)selector
{
    [self removeTarget:nil
                action:NULL
      forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:selector forControlEvents:event];
}

- (void)clickButtonEventDown
{
    if (_downBlock) {
        _downBlock(self);
    }
}

- (void)clickButtonEventDownRepeat
{
    if (_downRepeatBlock) {
        _downRepeatBlock(self);
    }
}

- (void)clickButtonEventDragInside
{
    if (_dragInsideBlock) {
        _dragInsideBlock(self);
    }
}

- (void)clickButtonEventDragOutside
{
    if (_dragOutsideBlock) {
        _dragOutsideBlock(self);
    }
}

- (void)clickButtonEventDragEnter
{
    if (_dragEnterBlock) {
        _dragEnterBlock(self);
    }
}

- (void)clickButtonEventDragExit
{
    if (_dragExitBlock) {
        _dragExitBlock(self);
    }
}

- (void)clickButtonEventUpInside
{
    //防止连点
    if (_lastClickDate == nil) {
        self.lastClickDate = [NSDate date];
        
    }
    else {
        double timeInterval = [[NSDate date] timeIntervalSinceDate:_lastClickDate];
        if (timeInterval < ButtonClickMinInterval) {
            return;
        }
        else
        {
            self.lastClickDate = [NSDate date];
            
        }
    }
    if (_upInsideBlock) {
        _upInsideBlock(self);
    }
}


- (void)clickButtonEventUpOutside
{
    if (_upOutsideBlock) {
        _upOutsideBlock(self);
    }
}

- (void)clickButtonEventCancel
{
    if (_cancelBlock) {
        _cancelBlock(self);
    }
}

- (void)inputError:(id)key class:(NSArray *)class
{
    if (class.count == 1) {
        NSLog(@"%@" ,[NSString stringWithFormat:@"value from key \"%@\" error , it is not a \"%@\" class",key,[class lastObject]]);
    }
    else if (class.count == 2) {
        NSLog(@"%@" ,[NSString stringWithFormat:@"value from key \"%@\" error , it is not a \"%@\" or \"%@\" class",key,[class firstObject],[class lastObject]]);
    }
    else if (class.count == 0) {
        NSLog(@"%@" ,[NSString stringWithFormat:@"%@ is invalid",key]);
    }
}


@end
