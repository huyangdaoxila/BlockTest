//
//  WaterFallCell.h
//  BlockTest
//
//  Created by huyang on 15/3/30.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestModel.h"
@interface WaterFallCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView *imageView ;
@property(nonatomic,strong)UILabel     *titleLabel ;
@property(nonatomic,strong)TestModel   *model ;
@property(nonatomic,strong)UILabel     *styleLabel ;
@property(nonatomic,strong)UILabel     *colorLabel ;

@end
