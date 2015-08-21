//
//  YOUNGUtils.m
//  BlockTest
//
//  Created by huyang on 15/5/19.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "YOUNGUtils.h"

@implementation YOUNGUtils

+(UIColor*)randomColor
{
    UIColor *color = [UIColor randomColor];
    return color ;
}

+(CGFloat)getTextHeightWithString:(NSString *)str andFontSize:(CGFloat)font andCertainWidth:(CGFloat)width
{
    CGFloat height = 0.f ;
    
    if (__IOS_Version_Lessthan_7__)
    {
        CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(width,MAXFLOAT)];
        height += size.width ;
    }
    else
    {
        NSDictionary *dicAttribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName, nil] ;
        
        CGRect textSize = [str boundingRectWithSize:CGSizeMake(width,MAXFLOAT)
                                            options:
                           NSStringDrawingUsesFontLeading|
                           NSStringDrawingUsesLineFragmentOrigin|
                           NSStringDrawingTruncatesLastVisibleLine
                                         attributes:dicAttribute
                                            context:nil];
        height += textSize.size.width ;
    }
    
    return height ;
}

+(CGFloat)getTextWidthWithString:(NSString*)str andFontSize:(CGFloat)font
{
    CGFloat width = 0.f ;
    
    if (__IOS_Version_Lessthan_7__)
    {
        CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(MAXFLOAT,30)];
        width += size.width ;
    }
    else
    {
        NSDictionary *dicAttribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font],NSFontAttributeName, nil] ;
        
        CGRect textSize = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, 30)
                                            options:
                           NSStringDrawingUsesFontLeading|
                           NSStringDrawingUsesLineFragmentOrigin|
                           NSStringDrawingTruncatesLastVisibleLine
                                         attributes:dicAttribute
                                            context:nil];
        width += textSize.size.width ;
    }
    return width ;
}

@end
