//
//  PhotoViewController.h
//  BlockTest
//
//  Created by huyang on 15/4/2.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "BaseViewController.h"

@interface PhotoViewController : BaseViewController
<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(strong,nonatomic)UIImagePickerController *ipc ;

@end
