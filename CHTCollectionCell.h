//
//  CHTCollectionCell.h
//  BlockTest
//
//  Created by huyang on 15/6/15.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHTCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *customImage;



+(UINib*)nib ;

@end
