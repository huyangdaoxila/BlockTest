//
//  CustomCollectionCell.h
//  BlockTest
//
//  Created by huyang on 15/4/14.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImageManager.h>
#import <AssetsLibrary/AssetsLibrary.h>

#define CellHeightOrWidth [UIScreen mainScreen].bounds.size.width/4

@protocol customSelectedImage <NSObject>

-(void)selectcurrentImage ;

@end

@interface CustomCollectionCell : UICollectionViewCell

@property(assign,nonatomic)id<customSelectedImage>delegate ;
@property(strong,nonatomic)UIImageView *customImage ;
@property(strong,nonatomic)UIButton    *selectedButton ;
@property(assign,nonatomic)BOOL        showSelectedButton ;
@property(strong,nonatomic)NSURL       *imageUrl ;

@end
