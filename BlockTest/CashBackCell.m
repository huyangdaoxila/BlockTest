//
//  CashBackCell.m
//  BlockTest
//
//  Created by huyang on 15/5/25.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "CashBackCell.h"
#import <Masonry.h>

@interface CashBackCell ()

@property(strong,nonatomic)UIImageView *cicleImage ;
@property(strong,nonatomic)UIImageView *verticalLineImage ;

@end

@implementation CashBackCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        [self configSubviews];
        [self addMasonryConstraints];
    }
    return  self ;
}

-(void)configSubviews
{

}
-(void)addMasonryConstraints
{

}

@end
