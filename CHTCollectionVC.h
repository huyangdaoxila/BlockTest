//
//  CHTCollectionVC.h
//  BlockTest
//
//  Created by huyang on 15/4/16.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "CHTCollectionViewWaterfallLayout.h"

@interface CHTCollectionVC : UIViewController<UICollectionViewDataSource,
                                              UICollectionViewDelegate,
                                              CHTCollectionViewDelegateWaterfallLayout>

@property(strong,nonatomic)UICollectionView *collectionView ;
@property(strong,nonatomic)NSMutableArray   *collectionDataArray ;
@property (nonatomic, strong) ALAssetsLibrary *assetLibrary;
@property (nonatomic, strong) NSMutableArray  *assets;

-(void)loadAssets ;

@end
