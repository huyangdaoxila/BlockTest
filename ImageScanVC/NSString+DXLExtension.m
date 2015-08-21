//
//  NSString+DXLExtension.m
//  DXLLibrary
//
//  Created by LCQ on 15/3/2.
//  Copyright (c) 2015年 lcqgrey. All rights reserved.
//

#import "NSString+DXLExtension.h"
#import "DXLBaseUtils.h"
#import <UIColor+Expanded.h>

@implementation NSString (DXLExtension)


-  (int)byteLength {
    
    int strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

- (NSString *)stringWithNumberOfLines:(NSUInteger)lines width:(CGFloat)width font:(id)font lineBreak:(NSLineBreakMode)lineBreak
{
    NSString *targetStr = @"";
    UIFont *actualfont = [DXLBaseUtils getFont:font];
    CGFloat fontHeight = [self sizeWithFont:actualfont].height;
    CGFloat maxHeight = fontHeight * lines;
    CGSize size = [self sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:lineBreak];
    NSUInteger allLines = ceilf(size.height/fontHeight);
    if (allLines > lines) {
        BOOL cutForward = NO;
        NSInteger currentLength = 0;
        NSString *cutStr = nil;
        if (allLines > 2 * lines) {
            cutForward = YES;
            currentLength = 1;
        }
        else {
            cutForward = NO;
            currentLength = self.length;
        }
        if (cutForward) {
            for (int i = 0; ; i++) {
                cutStr = [[self substringWithRange:NSMakeRange(0, currentLength)] stringByAppendingString:@"..."];
                CGSize size = [cutStr sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:lineBreak];
                if (size.height <= maxHeight) {
                    currentLength++;
                }
                else {
                    targetStr = [[self substringWithRange:NSMakeRange(0, currentLength - 1)] stringByAppendingString:@"..."];
                    break;
                }
            }
        }
        else {
            for (int i = 0; ; i++) {
                cutStr = [[self substringWithRange:NSMakeRange(0, currentLength)] stringByAppendingString:@"..."];
                CGSize size = [cutStr sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:lineBreak];
                if (size.height > maxHeight) {
                    currentLength--;
                }
                else {
                    targetStr = [[self substringWithRange:NSMakeRange(0, currentLength)] stringByAppendingString:@"..."];;
                    break;
                }
            }
        }
    }
    else {
        targetStr = self;
    }
    return targetStr;
}

- (CGFloat)stringHeightWithNumberOfLines:(NSUInteger)lines width:(CGFloat)width font:(id)font lineBreak:(NSLineBreakMode)breakMode
{
    NSString *str = [self stringWithNumberOfLines:lines width:width font:font lineBreak:breakMode];
    return [str sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:breakMode].height;
}

- (NSMutableAttributedString *)attributeStringWithTextColor:(id)color font:(id)font lineSpace:(CGFloat)space paragraphSpace:(CGFloat)paraSpace
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self];
    if (font) {
        [str addAttribute:NSFontAttributeName value:[DXLBaseUtils getFont:font] range:NSMakeRange(0, self.length)];
    }
    if (color) {
        [str addAttribute:NSForegroundColorAttributeName value:[self getColor:color] range:NSMakeRange(0, self.length)];
    }
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:space];
    [style setParagraphSpacing:paraSpace];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    [str addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.length)];
    return str;
}


- (UIColor *)getColor:(id)sender
{
    UIColor *color = nil;
    if ([sender isKindOfClass:[UIColor class]]) {
        color = sender;
    }
    else if ([sender isKindOfClass:[NSString class]]) {
        NSString *str = [sender stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSArray *tempArr = [str componentsSeparatedByString:@","];
        if (tempArr.count == 1) {
            color = [UIColor colorWithHexString:tempArr[0]];
        }
        else if (tempArr.count == 3) {
            color = [UIColor colorWithRed:[tempArr[0] floatValue]/255.0 green:[tempArr[1] floatValue]/255.0 blue:[tempArr[2] floatValue]/255.0 alpha:1];
        }
        else if (tempArr.count == 4) {
            color = [UIColor colorWithRed:[tempArr[0] floatValue]/255.0 green:[tempArr[1] floatValue]/255.0 blue:[tempArr[2] floatValue]/255.0 alpha:[tempArr[3] floatValue]];
        }
        else {
            NSAssert(tempArr.count != 1 || tempArr.count != 3 || tempArr.count != 4, @"you must past a para like this \"#666666\" or \"666666\" or \"r,g,b\" or \"r,g,b,a\" ");
        }
    }
    
    return color;
}

- (UIFont *)getFont:(id)sender
{
    UIFont *font = nil;
    if ([sender isKindOfClass:[UIFont class]]) {
        font = sender;
    }
    else if ([sender isKindOfClass:[NSString class]]) {
        NSString *str = [sender stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSArray *tempArr = [str componentsSeparatedByString:@","];
        if (tempArr.count == 1) {
            font = [UIFont systemFontOfSize:[tempArr[0] floatValue]];
        }
        else if (tempArr.count == 2) {
            font = [UIFont fontWithName:tempArr[0] size:[tempArr[1] floatValue]];
        }
        else {
            NSAssert(tempArr.count != 1 || tempArr.count != 2, @"you must past a para like this \"fontName ,fontSize\" or \"fontSize\" ");
        }
    }
    
    return font;
}

@end
