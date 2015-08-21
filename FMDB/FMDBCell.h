//
//  FMDBCell.h
//  BlockTest
//
//  Created by huyang on 15/5/14.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LVModal.h"

@interface FMDBCell : UITableViewCell

@property(strong,nonatomic)UILabel *nameLabel ;
@property(strong,nonatomic)UILabel *ageLabel ;
@property(strong,nonatomic)UILabel *idLabel ;
@property(strong,nonatomic)LVModal *model ;

@end
