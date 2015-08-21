//
//  CameraPushedVC.h
//  BlockTest
//
//  Created by huyang on 15/4/8.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol changeHeaderIcon <NSObject>

-(void)changeAvatorWithImage:(UIImage*)img ;

@end

@interface CameraPushedVC : UIViewController

@property(assign,nonatomic)id<changeHeaderIcon>delegate ;
@property(strong,nonatomic)UIImage *gotImage ;

@end
