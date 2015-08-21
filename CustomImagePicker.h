//
//  CustomImagePicker.h
//  BlockTest
//
//  Created by huyang on 15/4/7.
//  Copyright (c) 2015年 huyang. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVCaptureDevice.h>
#import "BaseViewController.h"

@protocol ImagePickerDelegate <NSObject>

-(void)imagePickerCallBackFunction:(UIImage *)image ;

@end

@interface CustomImagePicker : NSObject<UIAlertViewDelegate>

@property(weak,nonatomic)BaseViewController<ImagePickerDelegate,UIImagePickerControllerDelegate,
UINavigationControllerDelegate> *imageDelegate;

+(CustomImagePicker*)shareCustomImagePicker ;

-(void)openImagePickerConWithViewController:(__weak BaseViewController<ImagePickerDelegate,
                                             UINavigationControllerDelegate,
                                             UIImagePickerControllerDelegate> *)viewController
                               andEditOrNot:(BOOL)edit
                             withSourceType:(NSInteger)type;
//拍摄结束后的调用函数
-(void)saveImageWithPicker:(UIImagePickerController *)picker andDictionary:(NSDictionary *)info;


@end
