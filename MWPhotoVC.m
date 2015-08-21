//
//  MWPhotoVC.m
//  BlockTest
//
//  Created by huyang on 15/4/7.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "MWPhotoVC.h"
#import <MWPhotoBrowser.h>


static NSString *const identifier = @"tableViewCell";
@interface MWPhotoVC ()
<UITableViewDataSource,UITableViewDelegate,MWPhotoBrowserDelegate>

@property(strong,nonatomic)UITableView        *tableView ;
@property(strong,nonatomic)NSArray            *dataArray ;
@property(strong,nonatomic)NSMutableArray     *photos ;
@property(strong,nonatomic)NSMutableArray     *thumbs ;

@end

@implementation MWPhotoVC

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"MWPhotoBrowser" ;
    
    _dataArray = @[@"单张图片",@"多张图片",@"多张图片网格",@"相册图片(可选)",@"相册图片(浏览)"];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain] ;
    _tableView.delegate = self ;
    _tableView.dataSource = self ;
    [self.view addSubview:_tableView] ;
    
    [self loadAssets] ;
}

#pragma mark ----- tableView datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count ;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    }
    cell.textLabel.text = _dataArray[indexPath.row] ;
    return cell ;
}

#pragma mark ----- tableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *currentPhotos = [[NSMutableArray alloc] init] ;
    NSMutableArray *currentThumbs = [[NSMutableArray alloc] init] ;
    MWPhoto *photo = nil ;
    BOOL displayActionButton = NO;       // 右上角分享按钮是否显示  此处设为NO
    BOOL displaySelectionButtons = NO;   // 选择按钮是否显示
    BOOL displayNavArrows = NO;          // 是否显示导航栏
    BOOL enableGrid = NO;                // 是否网格显示
    BOOL startOnGrid = NO;               // 是否开始以网格小图展示图片
    switch (indexPath.row) {
        case 0:  // 单张图片
        {
            photo = [MWPhoto photoWithImage:[UIImage imageNamed:@"01.JPG"]] ;
            photo.caption = @"我的手机壁纸";
            [currentPhotos addObject:photo] ;
            displayNavArrows = YES ;
        }
            break;
        case 1:  // 多张图片
        {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"ImagePlist" ofType:@"plist"];
            NSArray *images = [NSArray arrayWithContentsOfFile:path] ;
            for (NSString *name in images)
            {
                photo = [MWPhoto photoWithImage:[UIImage imageNamed:name]] ;
                photo.caption = [NSString stringWithFormat:@"这张图片是->%@",name] ;
                [currentPhotos addObject:photo] ;
            }
            
        }
            break;
        case 2:  // 多张图片网格
        {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"ImagePlist" ofType:@"plist"];
            NSArray *images = [NSArray arrayWithContentsOfFile:path] ;
            for (NSString *name in images)
            {
                [currentPhotos addObject:[MWPhoto photoWithImage:[UIImage imageNamed:name]]] ;
                [currentThumbs addObject:[MWPhoto photoWithImage:[UIImage imageNamed:name]]] ;
            }
            startOnGrid = YES ;
            displayNavArrows = YES ;
            displaySelectionButtons = NO ;
        }
            break;
        case 3:  // 相册图片(可选)
        {
            NSMutableArray *copy = [_assets copy] ;
            
            for (ALAsset *asset in copy)
            {
                [currentPhotos addObject:[MWPhoto photoWithURL:asset.defaultRepresentation.url]];
                [currentThumbs addObject:[MWPhoto photoWithImage:[UIImage imageWithCGImage:asset.thumbnail]]] ;
            }
            startOnGrid = YES ;
            displaySelectionButtons = YES ;
            displayActionButton = NO ;
        }
            break;
        case 4:  // 相册图片(浏览)
        {
            NSMutableArray *copy = [_assets copy] ;
            
            for (ALAsset *asset in copy)
            {
                [currentPhotos addObject:[MWPhoto photoWithURL:asset.defaultRepresentation.url]];
                [currentThumbs addObject:[MWPhoto photoWithImage:[UIImage imageWithCGImage:asset.thumbnail]]] ;
            }
            startOnGrid = YES ;
        }
            break;
            
        default:
            break;
    }
    self.photos = currentPhotos ;
    self.thumbs = currentThumbs ;
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self] ;
    browser.displayActionButton = displayActionButton ;             //分享按钮是否显示
    browser.displayNavArrows = displayNavArrows ;                   //导航栏是否显示
    browser.displaySelectionButtons = displaySelectionButtons ;     //选择按钮是否显示
    browser.enableGrid = enableGrid ;                               //是否可以网格显示
    browser.startOnGrid = startOnGrid ;                             //开始就以网格形式显示
    browser.alwaysShowControls = NO ;                               //导航栏和工具栏是否一直显示
    browser.zoomPhotosToFill = YES ;                                //照片等比例填充
    browser.enableSwipeToDismiss = YES ;                            //滑动查看图片时导航栏是否隐藏
    [browser setCurrentPhotoIndex:0] ;
    
    if (displaySelectionButtons)
    {
        _selections = [NSMutableArray new];
        for (int i = 0 ; i < currentPhotos.count ; i++ )
        {
            [_selections addObject:[NSNumber numberWithBool:NO]];
        }
    }
    
    [self.navigationController pushViewController:browser animated:YES] ;
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - MWPhotoBrowserDelegate

// 图片浏览器中有多少张图片
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < _photos.count)
    {
        return [_photos objectAtIndex:index];
    }
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < _thumbs.count)
        return [_thumbs objectAtIndex:index];
    return nil;
}


- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index
{
    // 正在展示是的那张图片的索引
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index
{
    // 当前的这张图片是否被选中
    return [[_selections objectAtIndex:index] boolValue];
}


- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected
{
    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
    NSLog(@"Photo at index %lu selected %@", (unsigned long)index, selected ? @"YES" : @"NO");
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser
{
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index
{
    NSLog(@"action with %d",(int)index) ;
}

#pragma mark - Load Assets

- (void)loadAssets {
    
    // Initialise
    _assets = [NSMutableArray new];
    _assetLibrary = [[ALAssetsLibrary alloc] init];
    
    // Run in the background as it takes a while to get all assets from the library
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableArray *assetGroups = [[NSMutableArray alloc] init];
        NSMutableArray *assetURLDictionaries = [[NSMutableArray alloc] init];
        
        // Process assets
        void (^assetEnumerator)(ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result != nil) {
                if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                    [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
                    NSURL *url = result.defaultRepresentation.url;
                    [_assetLibrary assetForURL:url
                                   resultBlock:^(ALAsset *asset) {
                                       if (asset) {
                                           @synchronized(_assets) {
                                               [_assets addObject:asset];
                                               if (_assets.count == 1) {
                                                   // Added first asset so reload data
                                                   [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                                               }
                                           }
                                       }
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
        [self.assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                                         usingBlock:assetGroupEnumerator
                                       failureBlock:^(NSError *error) {
                                           NSLog(@"There is an error");
                                       }];
        
    });
    
}


@end
