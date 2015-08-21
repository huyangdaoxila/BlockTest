//
//  CHTCollectionVC.m
//  BlockTest
//
//  Created by huyang on 15/4/16.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "CHTCollectionVC.h"
#import <UIColor+Expanded.h>

#import "CHTCollectionCell.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define CellWidth ([UIScreen mainScreen].bounds.size.width-40)/2.f
static NSString *const identifier = @"collectionViewCell" ;
@interface CHTCollectionVC ()

@end

@implementation CHTCollectionVC

#pragma mark --- viewController lifecycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadAssets];
    [self initCollectionView];
}

-(void)createCollectionDataWithArray:(NSMutableArray*)array
{
    for (int i = 0 ; i < array.count/2; i++)
    {
        [array exchangeObjectAtIndex:i withObjectAtIndex:array.count-1-i ] ;
    }
    _collectionDataArray = array ;
}
#pragma mark --- init collectionview
-(void)initCollectionView
{
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    layout.columnCount = 2 ;                                  // 设置有几列  此处为2列
    layout.sectionInset = UIEdgeInsetsMake(15, 15, 10, 15) ;  // 设置collectionview边缘 (上,左,下,右)
    layout.minimumColumnSpacing = 10 ;                        // 设置水平方向两个cell之间的间距
    layout.minimumInteritemSpacing = 10 ;                     // 设置纵向两个cell之间的间距
    CGRect rect = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout] ;
    _collectionView.backgroundColor = [UIColor whiteColor] ;
    _collectionView.delegate = self ;
    _collectionView.dataSource = self ;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    [_collectionView registerNib:[CHTCollectionCell nib] forCellWithReuseIdentifier:@"CHTCollectionCell"];
    [self.view addSubview:_collectionView] ;
}

#pragma mark -- collection datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1 ;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _assets.count ;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CHTCollectionCell *CHTCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CHTCollectionCell" forIndexPath:indexPath];
    
    __weak CHTCollectionCell *weakCell = CHTCell ;
    ALAsset *asset = [_assets objectAtIndex:indexPath.row] ;
    NSURL *url = asset.defaultRepresentation.url ;
    ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
    [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset)  {
        UIImage *image=[UIImage imageWithCGImage:asset.aspectRatioThumbnail];
        weakCell.customImage.image = image ;
    }failureBlock:^(NSError *error) {
        NSLog(@"error=%@",error);
    }];
    
    return CHTCell ;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float height = 0.f ;
    if (indexPath.row % 2 == 0) {
        height = 150.f ;
    }else if (indexPath.row % 2 == 1){
        height = 190.f ;
    }
    return CGSizeMake(CellWidth, height) ;
}
#pragma mark - Load Assets

- (void)loadAssets
{
    __weak CHTCollectionVC *weakself = self ;
    // Initialise // 初始化
    _assets = [NSMutableArray new];
    _assetLibrary = [[ALAssetsLibrary alloc] init];
    
    // Run in the background as it takes a while to get all assets from the library
    // 在全局队列执行获取相册图片的耗时操作
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableArray *assetGroups = [[NSMutableArray alloc] init];
        NSMutableArray *assetURLDictionaries = [[NSMutableArray alloc] init];
        
        // Process assets // 处理相片资产
        void (^assetEnumerator)(ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result != nil) {
                if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                    [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
                    NSURL *url = result.defaultRepresentation.url;
                    [weakself.assetLibrary assetForURL:url
                                           resultBlock:^(ALAsset *asset){
                                               if (asset)
                                               {
                                                   @synchronized(weakself.assets)
                                                   {
                                                       [weakself.assets addObject:asset];
                                                   }
                                               }
                                               // 主队列 刷新collectionView UI
                                               dispatch_sync(dispatch_get_main_queue(), ^{
//                                                   [weakself createCollectionDataWithArray:weakself.assets];
                                                   [weakself.collectionView reloadData];
                                               }) ;
                                           }
                                          failureBlock:^(NSError *error){
                                              NSLog(@"operation was not successfull!");
                                          }];
                    
                }
            }
        };
        
        // Process groups
        void (^ assetGroupEnumerator) (ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop) {
            if (group != nil) {
                [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:assetEnumerator];
                [assetGroups addObject:group];
            }
        };
        
        // Process!
        [weakself.assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                                             usingBlock:assetGroupEnumerator
                                           failureBlock:^(NSError *error) {
                                               NSLog(@"There is an error");
                                           }];
        
    });
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
