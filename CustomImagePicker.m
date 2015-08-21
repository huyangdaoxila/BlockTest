//
//  CustomImagePicker.m
//  BlockTest
//
//  Created by huyang on 15/4/7.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "CustomImagePicker.h"

static CustomImagePicker *customPicker = nil ;
@implementation CustomImagePicker

+(CustomImagePicker*)shareCustomImagePicker
{
    static dispatch_once_t once_token ;
    dispatch_once(&once_token,^{
        customPicker = [[CustomImagePicker alloc] init] ;
    });
    return customPicker ;
}

-(void)openImagePickerConWithViewController:(BaseViewController<ImagePickerDelegate,UIImagePickerControllerDelegate,
                                             UINavigationControllerDelegate> *)viewController
                               andEditOrNot:(BOOL)edit
                             withSourceType:(NSInteger)type
{
    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
    picker.allowsEditing = edit;
    picker.videoQuality = UIImagePickerControllerQualityTypeHigh;
    customPicker.imageDelegate = viewController;
    picker.delegate = viewController;
    
    switch (type)
    {
        case 0:
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                //检查用户的设备是否支持使用摄像头
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                if (viewController) {
                    [customPicker.imageDelegate presentViewController:picker animated:YES completion:nil];
                }
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
                    if ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] == AVAuthorizationStatusDenied) {
                        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"请在iPhone的“设置-隐私-相机”选项中，允许访问您的相机。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                        [alert show];
                    }
                }
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的设备不支持拍照功能" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alert show];
            }
            break;
        case 1:
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                if (viewController) {
                    [customPicker.imageDelegate presentViewController:picker animated:YES completion:nil];
                }
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的设备不支持相册" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alert show];
            }
            break;
        default:
            break;
    }
}

-(void)saveImageWithPicker:(UIImagePickerController *)picker andDictionary:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage * photo = [info objectForKey:UIImagePickerControllerEditedImage];
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            UIImageWriteToSavedPhotosAlbum(photo, customPicker, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        }//如果是相机拍摄的，保存图片
        else
        {;}
        if (customPicker.imageDelegate && [customPicker.imageDelegate respondsToSelector:@selector(imagePickerCallBackFunction:)])//回调函数
        {
            [customPicker.imageDelegate imagePickerCallBackFunction:photo];
        }
    }];
}

-(void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
}

#pragma mark alertDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [alertView removeFromSuperview];
}
@end
