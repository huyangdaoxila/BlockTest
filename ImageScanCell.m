//
//  ImageScanCell.m
//  BlockTest
//
//  Created by huyang on 15/4/3.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "ImageScanCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry.h>

@implementation ImageScanCell

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc ]initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleAspectFill ;
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView) ;
        }];
    };
    return self ;
}
-(void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl ;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:[UIImage imageNamed:@"16.JPG"]];
}
@end
