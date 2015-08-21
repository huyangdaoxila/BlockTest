//
//  FMDBCell.m
//  BlockTest
//
//  Created by huyang on 15/5/14.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "FMDBCell.h"
#import "YoungMacrosHeader.h"
#import <Masonry.h>

@implementation FMDBCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViewUI];
        [self addMaronyConstraints];
    }
    return  self ;
}
-(void)initSubViewUI
{
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.font = [UIFont systemFontOfSize:12.f];
    [self.contentView addSubview:_nameLabel];
    
    _ageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _ageLabel.backgroundColor = [UIColor clearColor];
    _ageLabel.font = [UIFont systemFontOfSize:12.f];
    [self.contentView addSubview:_ageLabel];
    
    _idLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _idLabel.backgroundColor = [UIColor clearColor];
    _idLabel.font = [UIFont systemFontOfSize:12.f];
    [self.contentView addSubview:_idLabel];
}
-(void)addMaronyConstraints
{
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(5) ;
        make.left.equalTo(self.mas_left).offset(10) ;
        make.height.equalTo(@15) ;
        make.width.equalTo(@((KFullHeight-30)/2));
    }];
    
    [_ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(5) ;
        make.left.equalTo(_nameLabel.mas_right).offset(10) ;
        make.height.equalTo(@15) ;
        make.width.equalTo(@((KFullHeight-30)/2));
    }];
    
    [_idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(5) ;
        make.left.equalTo(self.mas_left).offset(10) ;
        make.height.equalTo(@15) ;
        make.width.equalTo(@(KFullHeight-30));
    }];
}
-(void)setModel:(LVModal *)model
{
    _model = model ;
    _nameLabel.text = [NSString stringWithFormat:@"姓名: %@",_model.name] ;
    _ageLabel.text = [NSString stringWithFormat:@"年龄: %lu",_model.age] ;
    _idLabel.text = [NSString stringWithFormat:@"身份证号码: %lu",_model.ID_No] ;
}
@end
