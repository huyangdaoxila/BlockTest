//
//  CashBackCell.h
//  BlockTest
//
//  Created by huyang on 15/5/25.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CashBackCellType) {
    leftCell,
    rightCell
};

@interface CashBackCell : UITableViewCell

@property(assign,nonatomic)CashBackCellType *type ;

@property(strong,nonatomic)UILabel *priceLabel ;
@property(strong,nonatomic)UILabel *descLabel ;
@property(strong,nonatomic)UILabel *orderLabel ;
@property(strong,nonatomic)UILabel *dateLabel ;

@end
