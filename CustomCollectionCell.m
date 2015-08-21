//
//  CustomCollectionCell.m
//  BlockTest
//
//  Created by huyang on 15/4/14.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "CustomCollectionCell.h"
#import <Masonry.h>
#import "UIImageView+WebCache.h"

@implementation CustomCollectionCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame] ;
    if (self) {
//        self.showSelectedButton = YES ;
        [self initSubviewUI];
        [self addMasonryConstraints];
        
    }
    return self ;
}
//-(void)setShowSelectedButton:(BOOL)showSelectedButton
//{
//    self.showSelectedButton = showSelectedButton ;
//    if (self.showSelectedButton == YES)
//    {
//        self.selectedButton.hidden = NO ;
//    }else{
//        self.selectedButton.hidden = YES ;
//    }
//}
-(void)setImageUrl:(NSURL *)imageUrl
{
    _imageUrl = imageUrl ;
//    [_customImage sd_setImageWithURL:_imageUrl placeholderImage:[UIImage imageNamed:@"16.JPG"]] ;
    
    ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
    [assetLibrary assetForURL:_imageUrl resultBlock:^(ALAsset *asset)  {
        UIImage *image=[UIImage imageWithCGImage:asset.thumbnail];
        _customImage.image=image;
        
    }failureBlock:^(NSError *error) {
        NSLog(@"error=%@",error);
    }];
}
-(void)initSubviewUI
{
    self.customImage = [[UIImageView alloc] init];
    self.customImage.contentMode = UIViewContentModeScaleAspectFill ;
    [self addSubview:self.customImage];
    
    _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectedButton setImage:[UIImage imageNamed:@"ImageSelectedOff"] forState:UIControlStateNormal];
    [_selectedButton setImage:[UIImage imageNamed:@"ImageSelectedOn"] forState:UIControlStateSelected];
    [_selectedButton addTarget:self action:@selector(imageSelectedOrNot:) forControlEvents:UIControlEventTouchUpInside];
    [self.customImage addSubview:_selectedButton];
}
-(void)addMasonryConstraints
{
    [_customImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self) ;
    }];
    
//    UIImage *img = [UIImage imageNamed:@"ImageSelectedOn"];
    CGSize size = CGSizeMake(CellHeightOrWidth/4, CellHeightOrWidth/4);
    [_selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_customImage.mas_top).offset(5.f) ;
        make.right.equalTo(_customImage.mas_right).offset(-5.f) ;
        make.size.mas_equalTo(size) ;
    }];
}
-(void)imageSelectedOrNot:(UIButton*)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectcurrentImage)])
    {
        [self.delegate selectcurrentImage] ;
    }
}
-(void)selectcurrentImage
{

}
@end
