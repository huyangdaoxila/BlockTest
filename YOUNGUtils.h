//
//  YOUNGUtils.h
//  BlockTest
//
//  Created by huyang on 15/5/19.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIColor+Expanded.h>
#import <UIKit/UIKit.h>
#import "YoungMacrosHeader.h"

@interface YOUNGUtils : NSObject

//获取随机颜色
+(UIColor *)randomColor ;

//根据文字内容,字体大小,指定宽度 计算文字高度
+(CGFloat)getTextHeightWithString:(NSString*)str andFontSize:(CGFloat)font andCertainWidth:(CGFloat)width ;

//根据文字内容,字体大小,计算文字宽度
+(CGFloat)getTextWidthWithString:(NSString*)str andFontSize:(CGFloat)font ;

@end
