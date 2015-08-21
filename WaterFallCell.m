//
//  WaterFallCell.m
//  BlockTest
//
//  Created by huyang on 15/3/30.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "WaterFallCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry.h>

@implementation WaterFallCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame] ;
    if (self) {
        self.backgroundColor = [UIColor whiteColor] ;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left) ;
            make.top.equalTo(self.mas_top) ;
            make.right.equalTo(self.mas_right) ;
            make.bottom.equalTo(self.mas_bottom).offset(-60.f) ;
        }];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-20, frame.size.width, 20.f)];
        _titleLabel.font = [UIFont systemFontOfSize:12.f];
        _titleLabel.textColor = [UIColor blackColor] ;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left) ;
            make.top.equalTo(_imageView.mas_bottom) ;
            make.right.equalTo(self.mas_right) ;
            make.bottom.equalTo(self.mas_bottom).offset(-40) ;
        }];
        
        _styleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _styleLabel.font = [UIFont systemFontOfSize:12.f];
        _styleLabel.textColor = [UIColor blackColor] ;
        _styleLabel.text = @"风格: 奢华 童话 清新" ;
        [self.contentView addSubview:_styleLabel];
        [_styleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left) ;
            make.top.equalTo(_titleLabel.mas_bottom) ;
            make.right.equalTo(self.mas_right) ;
            make.height.equalTo(@20) ;
        }];
        
        _colorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _colorLabel.font = [UIFont systemFontOfSize:12.f];
        _colorLabel.textColor = [UIColor blackColor] ;
        _colorLabel.text = @"颜色: 黑色 粉色 蓝色" ;
        [self.contentView addSubview:_colorLabel];
        [_colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left) ;
            make.top.equalTo(_styleLabel.mas_bottom) ;
            make.right.equalTo(self.mas_right) ;
            make.height.equalTo(@20) ;
        }];
        
        [self updateMasonryConstraints];
    }
    return self ;
}

-(void)updateMasonryConstraints
{
    [_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left) ;
        make.top.equalTo(self.mas_top) ;
        make.right.equalTo(self.mas_right) ;
        make.bottom.equalTo(self.mas_bottom).offset(-20.f) ;
    }];
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left) ;
        make.top.equalTo(_imageView.mas_bottom) ;
        make.right.equalTo(self.mas_right) ;
        make.bottom.equalTo(self.mas_bottom).offset(0.f) ;
    }];
    [_styleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left) ;
        make.top.equalTo(_titleLabel.mas_bottom) ;
        make.right.equalTo(self.mas_right) ;
        make.bottom.equalTo(_titleLabel.mas_bottom).offset(0.f) ;
    }];
    [_colorLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left) ;
        make.top.equalTo(_titleLabel.mas_bottom) ;
        make.right.equalTo(self.mas_right) ;
        make.bottom.equalTo(_titleLabel.mas_bottom).offset(0.f) ;
    }];
    
    [_styleLabel removeFromSuperview];
    [_colorLabel removeFromSuperview];
}
-(void)setModel:(TestModel *)model
{
    _model = model ;
    _titleLabel.text = model.title ? model.title : @"test+++test" ;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.imageURL] placeholderImage:[UIImage imageNamed:@"16.JPG"]] ;
}
@end
