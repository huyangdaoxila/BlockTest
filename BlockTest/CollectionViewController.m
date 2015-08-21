//
//  CollectionViewController.m
//  BlockTest
//
//  Created by huyang on 15/3/9.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionCell.h"
#import <UIColor+Expanded.h>
#import <MJRefresh.h>
#import "PickerViewVC.h"
#import "WaterViewController.h"

#define CELLID @"collectionViewCell"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"MJ-Collection";
    
    _dataArray = [[NSMutableArray alloc] init] ;
    for (int i = 0 ; i < 10 ; i++)
    {
        [_dataArray addObject:[UIColor randomColor]] ;
    }
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init] ;
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical] ;
    layout.minimumInteritemSpacing = 10.f; //每一行相邻的两个cell之间的间距
    layout.minimumLineSpacing = 15.f; //每一行的间距
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CELLID];
    _collectionView.delegate = self ;
    _collectionView.dataSource = self ;
    [self.view addSubview:_collectionView] ;
    
    __weak typeof(self) weakSelf = self;
    
    [self.collectionView addLegendHeaderWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf.collectionView reloadData];
            
            // 结束刷新
            [weakSelf.collectionView.header endRefreshing];
        });
    }];
    
    [self.collectionView addLegendFooterWithRefreshingBlock:^{
        // 增加5条假数据
        for (int i = 0; i<10; i++)
        {
            [weakSelf.dataArray addObject:[UIColor randomColor]];
        }
        
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
            
            // 结束刷新
            [weakSelf.collectionView.footer endRefreshing];
        });
    }];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count ;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1 ;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width-40)/3, ([UIScreen mainScreen].bounds.size.width-40)/3+40) ;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5) ;
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES ;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELLID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor randomColor];
    return cell ;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath] ;
    cell.backgroundColor = [UIColor randomColor];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
