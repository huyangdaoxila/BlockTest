//
//  NSString+DXLExtension.h
//  DXLLibrary
//
//  Created by LCQ on 15/3/2.
//  Copyright (c) 2015年 lcqgrey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (DXLExtension)

@property (nonatomic, readonly, assign) int byteLength; //获取字节长度

- (NSString *)stringWithNumberOfLines:(NSUInteger)lines width:(CGFloat)width font:(id)font lineBreak:(NSLineBreakMode)lineBreak;//获取限定长度的字符串

- (CGFloat)stringHeightWithNumberOfLines:(NSUInteger)lines width:(CGFloat)width font:(id)font lineBreak:(NSLineBreakMode)breakMode;//获取限定长度的字符串的高

- (NSMutableAttributedString *)attributeStringWithTextColor:(id)color font:(id)font lineSpace:(CGFloat)space paragraphSpace:(CGFloat)paraSpace;

@end

