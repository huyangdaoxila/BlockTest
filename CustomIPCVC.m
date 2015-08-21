//
//  CustomIPCVC.m
//  BlockTest
//
//  Created by huyang on 15/4/14.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "CustomIPCVC.h"
#import "CustomCollectionCell.h"
#import <SDWebImageManager.h>
#import <AFNetworking.h>
#import <KGModal.h>

#define BottomViewHeight 50.f
#define KFullWidth [UIScreen mainScreen].bounds.size.width
#define KFullHeight [UIScreen mainScreen].bounds.size.height
static NSString *const identifier = @"identifier" ;
@interface CustomIPCVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(strong,nonatomic)UICollectionView *myCollection ;
@property(strong,nonatomic)UILabel          *imageNumLabel ;
@property(strong,nonatomic)UIButton         *upload ;
@property(assign,nonatomic)int              selectedImagesCount ;
@property(strong,nonatomic)NSMutableArray   *uploadImages ;
@property(strong,nonatomic)NSMutableArray   *indexPaths ;

@end

@implementation CustomIPCVC

#pragma mark -- viewController lifecycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor] ;
    self.dataArray = [NSMutableArray array] ;
    self.selectedImagesCount = 0 ;
    self.uploadImages = [[NSMutableArray alloc] init] ;
    self.indexPaths = [[NSMutableArray alloc] init];
    
    [self loadAssets];
    [self initMyCollectionView];
    [self initBottomView];
}

-(void)initBottomView
{
    UIView *bottom = [[UIView alloc] initWithFrame:CGRectMake(0, KFullHeight-BottomViewHeight, KFullWidth, BottomViewHeight)];
//    bottom.backgroundColor = [UIColor redColor];
    [self.view addSubview:bottom];
    
    _imageNumLabel = [[UILabel alloc] init] ;
    _imageNumLabel.frame = CGRectMake(10, 10, KFullWidth/2, 30) ;
    _imageNumLabel.textColor = [UIColor orangeColor] ;
    _imageNumLabel.text = [NSString stringWithFormat:@"选中%d张图片",self.selectedImagesCount] ;
    _imageNumLabel.backgroundColor = [UIColor clearColor];
    [bottom addSubview:_imageNumLabel];
    
    _upload = [UIButton buttonWithType:UIButtonTypeCustom] ;
    _upload.frame = CGRectMake(KFullWidth-110, 10, 100, 30) ;
    _upload.layer.masksToBounds = YES ;
    _upload.layer.cornerRadius = 5 ;
    [_upload setTitle:@"上传图片" forState:UIControlStateNormal];
    [_upload setBackgroundColor:[UIColor orangeColor]];
    [_upload addTarget:self action:@selector(uploadImagesByRequestServer) forControlEvents:UIControlEventTouchUpInside];
    [bottom addSubview:_upload];
}
#pragma mark -- init collectionView
-(void)initMyCollectionView
{
    _dataArray = [_assets copy] ;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical] ;
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5) ;
    layout.minimumInteritemSpacing = 5.f; //每一行相邻的两个cell之间的间距
    layout.minimumLineSpacing = 5.f; //每一行的间距
    CGRect rect = CGRectMake(0, 0, KFullWidth, KFullHeight-BottomViewHeight) ;
    _myCollection = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout] ;
    _myCollection.delegate = self ;
    _myCollection.dataSource = self ;
    _myCollection.backgroundColor = [UIColor whiteColor] ;
    [_myCollection registerClass:[CustomCollectionCell class] forCellWithReuseIdentifier:identifier];
    [self.view addSubview:_myCollection];
    [_myCollection reloadData];
}
#pragma mark --  collectionView  datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1 ;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _assets.count ;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float width_height = ([UIScreen mainScreen].bounds.size.width-25)/4 ;
    return CGSizeMake(width_height,width_height) ;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath] ;
    ALAsset *asset = [_assets objectAtIndex:_assets.count-1-indexPath.row] ;
    NSURL *url = asset.defaultRepresentation.url ;
    cell.imageUrl = url ;
    if ([_indexPaths containsObject:indexPath])
    {
        cell.selectedButton.selected = YES ;
    }
    else{
        cell.selectedButton.selected = NO ;
    }
    return cell ;
}
#pragma mark --  collectionView  delegate
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES ;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_uploadImages.count <= 8 || [_indexPaths containsObject:indexPath])
    {
        CustomCollectionCell *cell = (CustomCollectionCell*)[_myCollection cellForItemAtIndexPath:indexPath] ;
        BOOL isSelected = !cell.selectedButton.selected ;
        cell.selectedButton.selected = isSelected ;
        if (cell.selectedButton.selected == YES)
        {
            [_uploadImages addObject:cell.customImage.image];
            [_indexPaths addObject:indexPath];
        }
        else
        {
            [_uploadImages removeObject:cell.customImage.image];
            [_indexPaths removeObject:indexPath];
        }
        _selectedImagesCount = (int)_uploadImages.count ;
        _imageNumLabel.text = [NSString stringWithFormat:@"选中%d张图片",self.selectedImagesCount] ;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"最多只能选择9张图片" message:@"" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles: nil];
        [alert show];
    }
    
//    NSLog(@"选中的图片个数--- %@",_indexPaths);
}
-(void)showKGModalAlert
{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KFullWidth-40.f, KFullWidth-40.f)];
    
    CGRect welcomeLabelRect = contentView.bounds;
    welcomeLabelRect.origin.y = 20;
    welcomeLabelRect.size.height = 20;
    UIFont *welcomeLabelFont = [UIFont boldSystemFontOfSize:17];
    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:welcomeLabelRect];
    welcomeLabel.text = @"KGModal 提示";
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
    
    
    KGModal *kgAlert = [KGModal sharedInstance] ;
    kgAlert.modalBackgroundColor = [UIColor whiteColor] ;
    kgAlert.closeButtonLocation = KGModalCloseButtonLocationRight ;
    [kgAlert showWithContentView:contentView andAnimated:YES];
}

#pragma mark === uploadImagesByRequestServer
-(void)uploadImagesByRequestServer
{
    [self showKGModalAlert] ;
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"你说上传就上传啊?" message:@"" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles: nil];
//    alert.alertViewStyle = UIAlertViewStyleDefault ;
//    [alert show];
    
    /*
     #### `POST` URL-Form-Encoded Request
     
     ```objective-c
     AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
     NSDictionary *parameters = @{@"foo": @"bar"};
     [manager POST:@"http://example.com/resources.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
     NSLog(@"JSON: %@", responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     NSLog(@"Error: %@", error);
     }];
     ```
     
     #### `POST` Multi-Part Request
     
     ```objective-c
     AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
     NSDictionary *parameters = @{@"foo": @"bar"};
     NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
     [manager POST:@"http://example.com/resources.json" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
     [formData appendPartWithFileURL:filePath name:@"image" error:nil];
     } success:^(AFHTTPRequestOperation *operation, id responseObject) {
     NSLog(@"Success: %@", responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     NSLog(@"Error: %@", error);
     }];
     */
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
}
#pragma mark - Load Assets

- (void)loadAssets
{
    __weak CustomIPCVC *weakself = self ;
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
                                           [weakself.myCollection reloadData];
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
