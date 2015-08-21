//
//  CHTCollectionCell.m
//  BlockTest
//
//  Created by huyang on 15/6/15.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "CHTCollectionCell.h"

@implementation CHTCollectionCell

- (void)awakeFromNib {
    // Initialization code
}

+(UINib*)nib
{
    return [UINib nibWithNibName:@"CHTCollectionCell" bundle:[NSBundle mainBundle]];
}

@end
