//
//  ShareBounsView.m
//  BlockTest
//
//  Created by huyang on 15/5/21.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "ShareBounsView.h"

#define KFullWidth [UIScreen mainScreen].bounds.size.width
static NSString *identifier = @"collectionViewCell";
@interface ShareBounsView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(strong,nonatomic)UICollectionView *collectionView ;

@end

@implementation ShareBounsView

-(void)fullfillKGModal
{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KFullWidth-40.f, KFullWidth-40.f + 50.f)];
    
    CGRect welcomeLabelRect = contentView.bounds;
    welcomeLabelRect.origin.y = 20;
    welcomeLabelRect.size.height = 20;
    UIFont *welcomeLabelFont = [UIFont boldSystemFontOfSize:17];
    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:welcomeLabelRect];
    welcomeLabel.text = @"分享到:";
    welcomeLabel.font = welcomeLabelFont;
    welcomeLabel.textColor = [UIColor blackColor];
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    welcomeLabel.backgroundColor = [UIColor clearColor];
    [contentView addSubview:welcomeLabel];
    
    UIImageView *lineView = [[UIImageView alloc] init];
    lineView.frame = CGRectMake(0, welcomeLabel.frame.origin.y+welcomeLabel.frame.size.height+20, 280, 1);
    lineView.layer.borderWidth = 0.5 ;
    lineView.layer.borderColor = [UIColor grayColor].CGColor ;
    [contentView addSubview:lineView];
    
    CGRect infoLabelRect = CGRectInset(contentView.bounds, 5, 5);
    infoLabelRect.origin.y = CGRectGetMaxY(welcomeLabelRect)+ 5;
    infoLabelRect.size.height -= CGRectGetMinY(infoLabelRect) + 50;
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:infoLabelRect];
    infoLabel.text = @"KGModal 简单使用!";
    infoLabel.numberOfLines = 0;
    infoLabel.textColor = [UIColor blackColor];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.backgroundColor = [UIColor clearColor];
    [contentView addSubview:infoLabel];
    
    float itemSizeWidth = (KFullWidth-40.f)/3 ;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0.f;
    layout.minimumLineSpacing = 0.f;
    layout.itemSize = CGSizeMake(itemSizeWidth , itemSizeWidth);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, (KFullWidth-40.f), (KFullWidth-40.f)) collectionViewLayout:layout];
    _collectionView.delegate = self ;
    _collectionView.dataSource = self ;
    [contentView addSubview:_collectionView];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    
    KGModal *kgAlert = [KGModal sharedInstance] ;
    kgAlert.modalBackgroundColor = [UIColor whiteColor] ;
    kgAlert.closeButtonLocation = KGModalCloseButtonLocationRight ;
    [kgAlert showWithContentView:contentView andAnimated:YES];
}

+(void)showShareKGModal
{
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1 ;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6 ;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor purpleColor];
    return cell ;
}

@end
