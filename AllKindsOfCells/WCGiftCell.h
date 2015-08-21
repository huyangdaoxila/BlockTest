//
//  WCGiftCell.h
//  BlockTest
//
//  Created by huyang on 15/6/1.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCSeiresCouponModel.h"

@interface WCGiftCell : UITableViewCell

@property(nonatomic,strong)WCSeiresCouponModel *model ;
@property(nonatomic,strong)UILabel *liLabel ;
@property(nonatomic,strong)UILabel *huiLabel ;
@property(nonatomic,strong)UILabel *liDetailLabel ;
@property(nonatomic,strong)UILabel *huiDetailLabel ;
@property(nonatomic,strong)UIImageView *rightImage ;
@property(nonatomic,strong)UILabel *CBDescLabel ;
@property(nonatomic,strong)UILabel *CBDetailLabel ;

@end
