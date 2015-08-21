//
//  GoodButton.m
//  BlockTest
//
//  Created by huyang on 15/4/16.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "GoodButton.h"
#import <Masonry.h>

@implementation GoodButton

-(id)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        [self initSubViewUI];
        [self addMasonryConstraints];
        
//        [self addTarget:self action:@selector(pressGoodButton) forControlEvents:UIControlEventTouchUpInside];
        [self sendActionsForControlEvents:UIControlEventTouchUpInside];
        
    }
    return self ;
}
-(void)initSubViewUI
{
    _logoImage = [[UIImageView alloc] init];
    _logoImage.image = [UIImage imageNamed:@"love"];
    [self addSubview:_logoImage];
    
    _numLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _numLabel.layer.cornerRadius = 5;
    _numLabel.layer.masksToBounds = YES ;
    _numLabel.textColor = [UIColor lightGrayColor] ;
    _numLabel.textAlignment = NSTextAlignmentCenter ;
    _numLabel.font = [UIFont systemFontOfSize:9];
    _numLabel.text = [NSString stringWithFormat:@"%d",8] ;
    _numLabel.backgroundColor = [UIColor clearColor]  ;
    [self addSubview:_numLabel];
}
-(void)setHighlighted:(BOOL)highlighted
{
    if (highlighted)
    {
        _logoImage.image = [UIImage imageNamed:@"love-h"];
        _numLabel.textColor = [UIColor redColor] ;
//        int text = [_numLabel.text intValue];
//        _numLabel.text = [NSString stringWithFormat:@"%d",text+1];
        self.userInteractionEnabled = NO ;
    }
}
-(void)addMasonryConstraints
{
    UIImage *img = [UIImage imageNamed:@"love-h"];
    
    [_logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_numLabel.mas_top);
        make.left.equalTo(self.mas_left).offset(5);
        make.size.mas_equalTo(img.size) ;
    }];
    
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(5);
        make.height.equalTo(@(img.size.height));
        make.right.equalTo(self.mas_right).offset(-10);
        make.left.equalTo(_logoImage.mas_right).offset(5);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
