//
//  MWPhotoVC.h
//  BlockTest
//
//  Created by huyang on 15/4/7.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface MWPhotoVC : UIViewController

@property (nonatomic, strong) NSMutableArray  *selections;
@property (nonatomic, strong) ALAssetsLibrary *assetLibrary;
@property (nonatomic, strong) NSMutableArray  *assets;

-(void)loadAssets ;

@end
