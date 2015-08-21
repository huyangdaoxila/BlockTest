//
//  CustomIPCVC.h
//  BlockTest
//
//  Created by huyang on 15/4/14.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface CustomIPCVC : UIViewController

@property (nonatomic, strong) NSMutableArray  *dataArray;
@property (nonatomic, strong) ALAssetsLibrary *assetLibrary;
@property (nonatomic, strong) NSMutableArray  *assets;

-(void)loadAssets ;

@end
