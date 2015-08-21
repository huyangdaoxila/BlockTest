//
//  DXLBaseUtils.m
//  DXLLibrary
//
//  Created by LCQ on 15/2/10.
//  Copyright (c) 2015年 lcqgrey. All rights reserved.
//

#import "DXLBaseUtils.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "NSString+DXLExtension.h"

@implementation DXLBaseUtils


+ (UIColor *)getColor:(id)sender
{
    UIColor *color = nil;
    if ([sender isKindOfClass:[UIColor class]]) {
        color = sender;
    }
    else if ([sender isKindOfClass:[NSString class]]) {
        NSString *str = [sender stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSArray *tempArr = [str componentsSeparatedByString:@","];
        if (tempArr.count == 1) {
            color = [self colorWithHexString:tempArr[0]];
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

+ (UIFont *)getFont:(id)sender
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

+ (CGRect)getFrame:(id)sender
{
    CGRect rect = CGRectNull;
    
    if ([sender isKindOfClass:[NSValue class]]) {
        rect = [sender CGRectValue];
    }
    else if ([sender isKindOfClass:[NSString class]]) {
        NSString *str = [sender stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSArray *tempArr = [str componentsSeparatedByString:@","];
        if (tempArr.count == 4) {
            rect = CGRectMake([tempArr[0] floatValue], [tempArr[1] floatValue], [tempArr[2] floatValue], [tempArr[3] floatValue]);
        }
        else {
            NSAssert(tempArr.count != 4, @"you must past a para like this \"x,y,w,h\" ");
        }
    }
    
    return rect;
}

+ (CGSize)getSize:(id)sender
{
    CGSize size = CGSizeZero;
    if ([sender isKindOfClass:[NSValue class]]) {
        size = [sender CGSizeValue];
    }
    else if ([sender isKindOfClass:[NSString class]]) {
        NSString *str = [sender stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSArray *tempArr = [str componentsSeparatedByString:@","];
        if (tempArr.count == 2) {
            size = CGSizeMake([tempArr[0] floatValue], [tempArr[1] floatValue]);
        }
        else {
            NSAssert(tempArr.count != 2, @"you must past a para like this \"w,h\" ");
        }
    }
    
    return size;
}


+ (UIImage *)getImage:(id)sender
{
    if (sender == nil) {
        return nil;
    }
    UIImage *image = nil;
    NSAssert(!(![sender isKindOfClass:[NSString class]] && ![sender isKindOfClass:[UIImage class]]), @"past must be a NSString  or UIImage class");
    if ([sender isKindOfClass:[NSString class]]) {
        if ([sender hasPrefix:@"/"]) {
            NSString *str = [ImageBoundle stringByAppendingString:sender];
            image = [UIImage imageNamed:str];
        }
        else {
            NSString *str = sender;
            image = [UIImage imageNamed:str];
        }
    }
    else if ([sender isKindOfClass:[UIImage class]]) {
        image = sender;
    }
    if (image == nil) {
        NSLog(@"%@",[NSString stringWithFormat:@"image with name \"%@\" has not found",sender]);
    }
    return image;
}

+ (UIImage *)getImageFromBundle:(id)sender
{
    if (sender == nil) {
        return nil;
    }
    UIImage *image = nil;
    NSAssert(!(![sender isKindOfClass:[NSString class]] && ![sender isKindOfClass:[UIImage class]]), @"past must be a NSString  or UIImage class");
    
    NSString *str = [ImageBoundle stringByAppendingString:sender];
    image = [UIImage imageNamed:str];
    
    if (image == nil) {
        NSLog(@"%@",[NSString stringWithFormat:@"image with name \"%@\" has not found",sender]);
    }
    return image;
}


+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {
    if ([stringToConvert hasPrefix:@"#"]) {
        stringToConvert = [stringToConvert substringFromIndex:1];
    }
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    return [DXLBaseUtils colorWithRGBHex:hexNum];
}

+ (CGFloat)distanceFromPoint:(CGPoint)fromPoint toPoint:(CGPoint)topoint
{
    CGFloat x = fromPoint.x - topoint.x;
    CGFloat y = fromPoint.y - topoint.y;
    return sqrtf(x * x + y * y);
}

+ (UIViewController*)viewControllerForView:(UIView *)view
{
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

+ (UIViewController *)viewControllerFromNavigationPenultimate:(UINavigationController *)navigationtionController
{
    NSArray *arr = navigationtionController.viewControllers;
    NSInteger count = arr.count;
    return [arr objectAtIndex:count - 2];
}

+ (UIViewController *)viewControllerFromNavigation:(UINavigationController *)navigationtionController atIndex:(NSInteger)index
{
    NSArray *arr = navigationtionController.viewControllers;
    return [arr objectAtIndex:index];
}


+ (BOOL)checkString:(NSString *)string withRegex:(NSString *)regexString
{
    BOOL isRightFormat = NO;
    if (string != nil) {
        NSError *error = nil;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:&error];
        NSArray *matches = [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
        NSString *tagString = nil;
        for (NSTextCheckingResult *match in matches) {
            NSRange matchRange = [match range];
            tagString = [string substringWithRange:matchRange];
        }
        if (!tagString) {
            isRightFormat = NO;
        }
        else {
            isRightFormat = YES;
        }
    }
    return isRightFormat;
}

+ (id)getObjectFrom:(NSString *)string withRegex:(NSString *)regexString
{
    id object = nil;
    if (string != nil) {
        NSError *error = nil;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:&error];
        NSArray *matches = [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSTextCheckingResult *match in matches) {
            NSRange matchRange = [match range];
            NSString *tagString = [string substringWithRange:matchRange];
            [arr addObject:tagString];
        }
        if (arr.count > 1) {
            object = arr;
        }
        else if (arr.count == 1) {
            object = arr[0];
        }
    }
    return object;
}


+ (NSData *)archiverObject:(id)object
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:object forKey:@"dxl.app.com"];
    [archiver finishEncoding];
    return data;
}


+ (id)unarchiverObject:(NSData *)data
{
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    id object = [unarchiver decodeObjectForKey:@"dxl.app.com"];
    [unarchiver finishDecoding];
    return object;
}


+ (NSString *)fetchIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address.length > 0 ? address : @"";
}


+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,183,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0235-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGSize size = CGSizeMake(1.f, 1.f);
    return [DXLBaseUtils imageWithColor:color size:size];
}


+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, .0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [color set];
    CGContextFillRect(context, CGRectMake(.0, .0, size.width, size.height));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (NSString *)formatTimestamp2String:(NSTimeInterval)timestamp withFormatter:(NSString *)aformatter{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:aformatter];
    return [formatter stringFromDate:date];
}

+ (NSArray *)fetchNumberOfString:(NSString *)string
{
    NSMutableArray *returnAry = [@[] mutableCopy];
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\d+" options:0 error:&error];
    if (regex != nil) {
        NSArray *results = [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
        
        for (NSTextCheckingResult *result in results) {
            NSRange range = [result rangeAtIndex:0];
            NSString *r = [string substringWithRange:range];
            [returnAry addObject:r];
        }
    }
    return [returnAry copy];
}


+ (NSString *)subMobileNum:(NSString *)str {
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[0-9]*\\-?[0-9]*" options:0 error:&error];
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            
            //从str当中截取数据
            NSString *result=[str substringWithRange:resultRange];
            //输出结果
            return result;
        }
    }
    return @"";
}

+ (NSString *)getURLAbsoluteStringWithURL:(NSString *)url withParams:(NSDictionary *)params
{
    NSString *newURLStr = url;
    if (params)
    {
        newURLStr = [newURLStr stringByAppendingString:@"?"];
        //排序
        NSArray *keys = [params allKeys];
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:params.count];
        SEL sel = @selector(localizedCompare:);
        keys = [keys sortedArrayUsingSelector:sel];
        
        for (int i = 0; i < keys.count; i++) {
            NSString *key = keys[i];
            NSString *value = params[key];
            NSString *str = [key stringByAppendingString:@"="];
            if ([value isKindOfClass:[NSNumber class]]) {
                value = [(NSNumber *)value stringValue];
            }
            str = [str stringByAppendingString:value];
            [arr addObject:str];
        }
        newURLStr = [newURLStr stringByAppendingString:[arr componentsJoinedByString:@"&"]];
    }
    return newURLStr;
}

+ (NSString *)getURLAbsoluteStringWithBaseURL:(NSString *)baseUrl withURL:(NSString *)url withParams:(NSDictionary *)params
{
    NSString *newURLStr = baseUrl;
    if (url) {
        if (![newURLStr hasSuffix:@"/"]) {
            newURLStr = [newURLStr stringByAppendingString:@"/"];
        }
        newURLStr = [newURLStr stringByAppendingString:url];
    }
    return [self getURLAbsoluteStringWithURL:newURLStr withParams:params];
}


//单个文件的大小
+ (long long)fileSizeAtPath:(NSString*)filePath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
//遍历文件夹获得文件夹大小，返回多少M
+ (float )folderSizeAtPath:(NSString*)folderPath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath])
        return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [DXLBaseUtils fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

+ (NSString *)stringFromString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font
{
    NSInteger currentLength = string.length;
    NSString *targetStr = @"";
    BOOL shouldCut = NO;
    for (int i = 0; ; i++) {
        NSString *str = nil;
        if (shouldCut) {
            str  = [string stringByAppendingString:@"..."];
//            str = [[string substringFromIndex:0 length:currentLength] stringByAppendingString:@"..."];
        }
        else {
            str = string;//[string substringFromIndex:0 length:currentLength];
        }
        CGSize size = [str sizeWithFont:font];
        if (size.width > width) {
            shouldCut = YES;
            currentLength -= 1;
        }
        else {
            targetStr = str;
            break;
        }
    }
    return targetStr;
}


+ (NSString *)cilpingStringFromString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font
{
    NSInteger currentLength = string.length;
    NSString *targetStr = @"";
    BOOL shouldCut = NO;
    for (int i = 0; ; i++) {
        NSString *str = string;
//        if (shouldCut) {
//            str = [string substringFromIndex:0 length:currentLength];
//        }
//        else {
//            str = [string substringFromIndex:0 length:currentLength];
//        }
        CGSize size = [str sizeWithFont:font];
        if (size.width > width) {
            shouldCut = YES;
            currentLength -= 1;
        }
        else {
            targetStr = str;
            break;
        }
    }
    return targetStr;
}

+ (CGFloat)heightForString:(id)string withFont:(UIFont *)font withWidth:(CGFloat)width breakMode:(NSLineBreakMode)breakMode
{
    CGFloat height = 0;
    if ([string isKindOfClass:[NSString class]]) {
        NSString *str = string;
        height = [str sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:breakMode].height;
    }
    else if ([string isKindOfClass:[NSAttributedString class]]) {
        NSAttributedString *str = string;
        height = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size.height;
    }
    return height;
}


//+ (NSString *)createURLStringWithFilePath:(NSString *)path
//{
//    return (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)path,NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
//}
//
//+ (NSURL *)createURLWithFilePath:(NSString *)path
//{
//    NSString *url = [DXLUtils createURLStringWithFilePath:path];
//    return [NSURL URLWithString:url relativeToURL:[NSURL fileURLWithPath:url]];
//}
//
//
//+ (NSString *)createURLStringWithFileBundlePath:(NSString *)path
//{
//    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
//    path = [bundlePath stringByAppendingString:path];
//    return (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)path,NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
//}
//
//+ (NSURL *)createURLWithFileBundlePath:(NSString *)path
//{
//    NSString *url = [DXLUtils createURLStringWithFileBundlePath:path];
//    return [NSURL URLWithString:url relativeToURL:[NSURL fileURLWithPath:url]];
//}

@end
