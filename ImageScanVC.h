//
//  ImageScanVC.h
//  BlockTest
//
//  Created by huyang on 15/4/3.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry.h>

@interface ImageScanVC : UIViewController

@property(strong,nonatomic)NSMutableArray *imagePaths ;
@property(assign,nonatomic)NSInteger       currentIndex ;

@end
