//
//  CollectionViewController.h
//  BlockTest
//
//  Created by huyang on 15/3/9.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface CollectionViewController : UIViewController
<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(strong,nonatomic)UICollectionView *collectionView ;
@property(strong,nonatomic)NSMutableArray   *dataArray ;

@end
