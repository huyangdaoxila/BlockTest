//
//  DXLCustomControl.h
//  BlockTest
//
//  Created by huyang on 15/3/17.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DXLControlDelegate <NSObject>

-(void)buttonClinked;

@end

@interface DXLCustomControl : UIControl

{
    UIView      *_backgroundView ;
    UIImageView *_iconView       ;
    UILabel     *_titleLabel     ;
}

@end
