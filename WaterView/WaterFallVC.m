//
//  WaterFallVC.m
//  BlockTest
//
//  Created by huyang on 15/3/30.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "WaterFallVC.h"
#import "WaterFallCell.h"
#import <AFNetworking.h>
#import "SDWebImageManager.h"
#import "TestModel.h"
#import "ImageSizeModel.h"
#import "ImageScanVC.h"
#import <MBProgressHUD.h>
#import <Masonry.h>
#import "VINomalViewController.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define CellWidth ([UIScreen mainScreen].bounds.size.width-40)/2.f
#define NEEDURL  @"https://api.daoxila.com/user/user/appointment"
//@"http://piao.163.com/m/movie/list.html?app_id=2&mobileType=iPhone&ver=2.5&channel=lede&deviceId=C1985DD9-0125-4AB5-B66B-B91A85824BBA&apiVer=11&city=110000"

static NSString *const identifer = @"waterFallCell" ;
@interface WaterFallVC ()<MBProgressHUDDelegate>

@property(strong,nonatomic)NSMutableArray   *dataArray ;
@property(strong,nonatomic)NSMutableArray   *imageArray ;
@property(strong,nonatomic)UICollectionView *collectionView ;
@property(strong,nonatomic)MBProgressHUD    *hud ;

@end

@implementation WaterFallVC

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _hud = [[MBProgressHUD alloc] initWithView:self.view];
    _hud.delegate = self ;
    [_hud showWhileExecuting:@selector(downloadData) onTarget:self withObject:nil animated:YES];
    [self.view addSubview:_hud];
    
}

-(void)downloadData
{
    _dataArray = [NSMutableArray array] ;
    _imageArray = [NSMutableArray array] ;
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init] ;
    layout.sectionInset = UIEdgeInsetsMake(15, 15, 10, 15) ;
    layout.minimumColumnSpacing = 10 ;
    layout.minimumInteritemSpacing = 10 ;
    CGRect rect = CGRectMake(0, 64, ScreenWidth, ScreenHeight-64);
    _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout] ;
    _collectionView.backgroundColor = [UIColor whiteColor] ;
    _collectionView.delegate = self ;
    _collectionView.dataSource = self ;
    [self.view addSubview:_collectionView] ;
    [_collectionView registerClass:[WaterFallCell class] forCellWithReuseIdentifier:identifer];
    
//    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view) ;
//    }];
    
    __weak WaterFallVC *weakself = self ;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager] ;
    [manager GET:NEEDURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
        NSArray *root = [responseObject objectForKey:@"list"] ;
        for (int i = 0 ; i < root.count; i++) {
            NSDictionary *dic = root[i] ;
            TestModel *model = [[TestModel alloc] init];
            model.imageURL = dic[@"logo"];
            model.title = dic[@"highlight"];
            [weakself.dataArray addObject:model];
            
            ImageSizeModel *imageModel = [[ImageSizeModel alloc] init];
            imageModel.imageURL = dic[@"logo"];
            [_imageArray addObject:imageModel];
            NSLog(@"_____%@",dic[@"logo"]);
        }
        [weakself.collectionView reloadData] ;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取数据失败");
    }];
}
- (void)imageDownloadWithModel:(ImageSizeModel *)model
{
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:model.imageURL] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        float screenWidth = [UIScreen mainScreen].bounds.size.width ;
        CGSize size = CGSizeMake((screenWidth-40)/2.f, 200);
        if (!error && image) {
            size.height = image.size.height/image.size.width * size.width;
        }
        else {
            //            NSLog(@"+++++++image download err");
        }
        model.mySize->width = size.width;
        model.mySize->height = size.height ;
        [_collectionView reloadData];
    }];
}
#pragma mark - collectionView dataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1 ;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count ;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float height = 0.f ;
    switch (indexPath.row % 2) {
        case 0:
        {
            height = 160.f ;
        }
            break;
        case 1:
        {
            height = 220.f ;
        }
            break;
        default:
            break;
    }

    return CGSizeMake(CellWidth, height+40) ;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaterFallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifer forIndexPath:indexPath] ;
    cell.model = _dataArray[indexPath.row] ;
    cell.backgroundColor = [UIColor lightGrayColor] ;
    
    return cell ;
}
#pragma mark - collectionView delegate
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES ;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    ImageScanVC *scan = [[ImageScanVC alloc] init];
//    scan.currentIndex = indexPath.row ;
//    scan.imagePaths = [[NSMutableArray alloc] init];
//    for (TestModel *model in _dataArray) {
//        [scan.imagePaths addObject:model.imageURL];
//    }
//    [self presentViewController:scan animated:YES completion:nil] ;
    
    VINomalViewController *vc = [[VINomalViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionInterPageSpacingKey: @30}];
    vc.showTopView = YES;
    vc.firstIndex = indexPath.row;
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:_dataArray.count];
    for (int i = 0; i < _dataArray.count; i++) {
        VIModel *model = [[VIModel alloc] init];
        TestModel *testModel = _dataArray[i] ;
        model.image = testModel.imageURL;
        model.index = i;
        [arr addObject:model];
    }
    vc.imageDataSource = arr;
    [self presentViewController:vc animated:YES completion:nil];
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
