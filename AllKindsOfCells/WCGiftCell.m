//
//  WCGiftCell.m
//  BlockTest
//
//  Created by huyang on 15/6/1.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "WCGiftCell.h"
#import <UIColor+Expanded.h>
#import <Masonry.h>

#define Yellow_FF [UIColor colorWithHexString:@"FFAF4D"]
#define Gray_6    [UIColor colorWithHexString:@"666666"]
@implementation WCGiftCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ;
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        self.contentView.backgroundColor = [UIColor whiteColor] ;
        [self initSubviewUI];
        [self addMasonryConstraint];
    }
    return self ;
}
-(void)initSubviewUI
{
    UIImage *img = [UIImage imageNamed:@"arrow_right"];
    _rightImage = [[UIImageView alloc] initWithImage:img];
    [self.contentView addSubview:_rightImage];
    
    _CBDescLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _CBDescLabel.backgroundColor = [UIColor clearColor];
    _CBDescLabel.layer.borderWidth = 1.f ;
    _CBDescLabel.layer.cornerRadius = 3.f ;
    _CBDescLabel.font = [UIFont systemFontOfSize:11];
    _CBDescLabel.layer.borderColor = Yellow_FF.CGColor ;
    _CBDescLabel.textColor = Yellow_FF ;
    _CBDescLabel.textAlignment = NSTextAlignmentCenter ;
    _CBDescLabel.text = @"返现";
    [self.contentView addSubview:_CBDescLabel];
    
    _liLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _liLabel.backgroundColor = [UIColor clearColor];
    _liLabel.layer.borderWidth = 1.f ;
    _liLabel.layer.cornerRadius = 3.f ;
    _liLabel.font = [UIFont systemFontOfSize:11];
    _liLabel.layer.borderColor = Yellow_FF.CGColor ;
    _liLabel.textColor = Yellow_FF ;
    _liLabel.textAlignment = NSTextAlignmentCenter ;
    _liLabel.text = @"到店礼";
    [self.contentView addSubview:_liLabel];
    
    _huiLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _huiLabel.backgroundColor = [UIColor clearColor];
    _huiLabel.layer.borderWidth = 1.f ;
    _huiLabel.layer.cornerRadius = 3.f ;
    _huiLabel.font = [UIFont systemFontOfSize:11];
    _huiLabel.layer.borderColor = Yellow_FF.CGColor ;
    _huiLabel.textColor = Yellow_FF ;
    _huiLabel.textAlignment = NSTextAlignmentCenter ;
    _huiLabel.text = @"会员优惠";
    [self.contentView addSubview:_huiLabel];
    
    _CBDetailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _CBDetailLabel.backgroundColor = [UIColor clearColor];
    _CBDetailLabel.font = [UIFont systemFontOfSize:14];
    _CBDetailLabel.textColor = Gray_6 ;
    [self.contentView addSubview:_CBDetailLabel];
    
    _liDetailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _liDetailLabel.backgroundColor = [UIColor clearColor];
    _liDetailLabel.font = [UIFont systemFontOfSize:14];
    _liDetailLabel.textColor = Gray_6 ;
    [self.contentView addSubview:_liDetailLabel];
    
    _huiDetailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _huiDetailLabel.backgroundColor = [UIColor clearColor];
    _huiDetailLabel.font = [UIFont systemFontOfSize:14];
    _huiDetailLabel.textColor = Gray_6 ;
    [self.contentView addSubview:_huiDetailLabel];
}
-(void)addMasonryConstraint
{
    [_rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-15);
//        make.size.equalTo(CGSizeMake(13, 18));
        make.width.equalTo(@13);
        make.height.equalTo(@18);
    }];
    
    [_CBDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10) ;
        make.left.equalTo(self.mas_left).offset(15) ;
        make.height.equalTo(@20);
        make.width.equalTo(@60);
    }];
    
    
    [_liLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(40) ;
        make.left.equalTo(self.mas_left).offset(15) ;
        make.height.equalTo(@20);
        make.width.equalTo(@60);
    }];
    
    [_huiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(70) ;
        make.left.equalTo(self.mas_left).offset(15) ;
        make.height.equalTo(@20);
        make.width.equalTo(@60);
    }];
    
    [_CBDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_CBDescLabel.mas_right).offset(15) ;
        make.top.equalTo(_CBDescLabel.mas_top);
        make.right.equalTo(self.mas_right).offset(-30);
        make.height.equalTo(@20);
    }];
    
    [_liDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_liLabel.mas_right).offset(15) ;
        make.top.equalTo(_liLabel.mas_top);
        make.right.equalTo(self.mas_right).offset(-30);
        make.height.equalTo(@20);
    }];
    
    [_huiDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_huiLabel.mas_right).offset(15) ;
        make.top.equalTo(_huiLabel.mas_top);
        make.right.equalTo(self.mas_right).offset(-30);
        make.height.equalTo(@20);
    }];
}

-(void)setModel:(WCSeiresCouponModel *)model
{
    _model = model ;
    _CBDetailLabel.text = _model.cashBackText ;
    _liDetailLabel.text = _model.liText ;
    _huiDetailLabel.text = _model.huiText ;
    
    if (!_model.is_cashBack )
    {
        _CBDescLabel.hidden = YES ;
        _CBDetailLabel.hidden = YES ;
        if (!_model.is_couponLi){
            _liLabel.hidden = YES ;
            _liDetailLabel.hidden = YES ;
            [_huiLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top).offset(10);
            }];
        }
        else{
            [_liLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top).offset(10);
            }];
            if (!_model.is_couponHui) {
                _huiLabel.hidden = YES ;
                _huiDetailLabel.hidden = YES ;
            }
            else{
                [_huiLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.mas_top).offset(40);
                }];
            }
        }
    }
    else{
        if (!_model.is_couponLi) {
            _liLabel.hidden = YES ;
            _liDetailLabel.hidden = YES ;
            if (!model.is_couponHui) {
                _huiLabel.hidden = YES ;
                _huiDetailLabel.hidden = YES ;
            }
            else{
                [_huiLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.mas_top).offset(40);
                }];
            }
        }
        else{
            if (!model.is_couponHui) {
                _huiLabel.hidden = YES ;
                _huiDetailLabel.hidden = YES ;
            }
        }
    }
}


@end
