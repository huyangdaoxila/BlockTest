//
//  DXLBaseUtils.h
//  DXLLibrary
//
//  Created by LCQ on 15/2/10.
//  Copyright (c) 2015年 lcqgrey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DXLBaseUtils : NSObject

#define ImageBoundle @"images.bundle/" //you should to write your image boundle path if you has
#define MakeRect( x, y, w, h) CGRectMake( (x), (y), (w), (h))


//sender is a UIColor or NSString class (if NSString class like this "#666666" or "666666" or "r,g,b" or "r,g,b,a" )
+ (UIColor *)getColor:(id)sender;
//sender is a UIFont or NSString class
+ (UIFont *)getFont:(id)sender;
//sender is a NSString or NSValue class
+ (CGRect)getFrame:(id)sender;
//sender is a NSValue or NSString class
+ (CGSize)getSize:(id)sender;

//sender is  a UIImage or NSString class (if NSString class like this "/imageName" or "imageName" or "boundlePath/imageName" )
+ (UIImage *)getImage:(id)sender;

+ (UIImage *)getImageFromBundle:(id)sender;

+ (UIColor *)colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

+ (CGFloat)distanceFromPoint:(CGPoint)fromPoint toPoint:(CGPoint)topoint;

+ (UIViewController *)viewControllerForView:(UIView *)view;//视图所在控制器

+ (UIViewController *)viewControllerFromNavigationPenultimate:(UINavigationController *)navigationtionController;//获取导航控制器倒数第二个控制器

+ (UIViewController *)viewControllerFromNavigation:(UINavigationController *)navigationtionController atIndex:(NSInteger)index;//获取导航控制器对应index的控制器

/**是否满足正则*/
+ (BOOL)checkString:(NSString *)string withRegex:(NSString *)regexString;

/**获取满足正则的对象*/
+ (id)getObjectFrom:(NSString *)string withRegex:(NSString *)regexString;


+ (NSData *)archiverObject:(id)object;

+ (id)unarchiverObject:(NSData *)data;

+ (NSString *)fetchIPAddress;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (NSString *)formatTimestamp2String:(NSTimeInterval)timestamp withFormatter:(NSString*)formatter;

+ (NSArray *)fetchNumberOfString:(NSString *)string;

+ (NSString *)subMobileNum:(NSString *)str;


//获取请求绝对url

+ (NSString *)getURLAbsoluteStringWithURL:(NSString *)url withParams:(NSDictionary *)params;

+ (NSString *)getURLAbsoluteStringWithBaseURL:(NSString *)baseUrl withURL:(NSString *)url withParams:(NSDictionary *)params;


//单个文件的大小
+ (long long)fileSizeAtPath:(NSString*)filePath;

//遍历文件夹获得文件夹大小，返回多少M
+ (float )folderSizeAtPath:(NSString*)folderPath;

//获取特定长度的字符串,如果超出指定长度后面加...
+ (NSString *)stringFromString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font;

+ (NSString *)cilpingStringFromString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font;

//获取字符串在指定size的高度，string为NSString或NSAttributeString
+ (CGFloat)heightForString:(id)string withFont:(UIFont *)font withWidth:(CGFloat)width breakMode:(NSLineBreakMode)breakMode;


//创建URL

//绝对路径
+ (NSString *)createURLStringWithFilePath:(NSString *)path;

+ (NSURL *)createURLWithFilePath:(NSString *)path;

//bundle下的路径
+ (NSURL *)createURLWithFileBundlePath:(NSString *)path;

+ (NSString *)createURLStringWithFileBundlePath:(NSString *)path;

@end
