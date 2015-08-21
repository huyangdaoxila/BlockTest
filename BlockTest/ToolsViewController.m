//
//  ToolsViewController.m
//  BlockTest
//
//  Created by huyang on 15/3/30.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "ToolsViewController.h"
#import "WaterFallVC.h"           // CHC第三方瀑布流效果
#import "PhotoViewController.h"   // 照片截取图像
#import "GCDViewController.h"     // MJRefresh
#import "TestViewController.h"    // HUD使用示例
#import "MWPhotoVC.h"             // 图片浏览
#import "CityLocationVC.h"        // 城市定位
#import "CustomIPCVC.h"           // 仿照IPC
#import "TableViewVC.h"           // tableView Plain做Grouped效果
#import "CHTCollectionVC.h"       // CHTCollection 瀑布流
#import "TTTLabelViewController.h"// TTTAttributedLabel 简单使用
#import "TableHeaderViewController.h" // tableView HeaderView 特效
#import "FMDBController.h"            // sqlite_fmdb 练习

@interface ToolsViewController ()
<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)UITableView *tableView ;
@property(strong,nonatomic)NSArray *dataArray ;


@end

@implementation ToolsViewController

/**
 *  在 iOS 5.0 后,导航栏新增了一个属性,leftItemsSupplementBackButton,设置为YES时,可以让leftBarButtonItem 和 backBarButtonItem 同时显示,其中leftBarButtonItem在backBarButtonItem的右侧显示
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"工具" ;
    
    self.navigationItem.backBarButtonItem.tintColor = [UIColor blackColor];
    
    _dataArray = @[@"瀑布流",@"MJ_tableView",@"照片",@"MBProgressHUD",@"MWPhotoBrowser",@"城市定位",@"仿照IPC",@"Plain-Grouped",@"CHTCollection",@"TTTAttributedLabel",@"TableView-Header",@"FMDB"] ;
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self ;
    _tableView.dataSource = self ;
    [self.view addSubview:_tableView] ;
}
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
    static NSString *identifier = @"tableViewCell" ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _dataArray[indexPath.row] ;
    return cell ;
}

#pragma mark - tableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {  // 瀑布流界面
        WaterFallVC *water = [[WaterFallVC alloc] init] ;
        [self.navigationController pushViewController:water animated:YES] ;
    }
    else if (indexPath.row == 1){  // tableView__MJRefresh
        GCDViewController *gcd = [[GCDViewController alloc] init] ;
        [self.navigationController pushViewController:gcd animated:YES] ;
    }
    else if (indexPath.row == 2){ // 照片选择
        PhotoViewController *photo = [[PhotoViewController alloc] init];
        [self.navigationController pushViewController:photo animated:YES] ;
    }
    else if (indexPath.row == 3){  //  hud 展示
        TestViewController *hud = [[TestViewController alloc] init] ;
        [self.navigationController pushViewController:hud animated:YES] ;
    }
    else if (indexPath.row == 4){ //  MWPhotoBrowser 简单使用
        MWPhotoVC *photo = [[MWPhotoVC alloc] init] ;
        [self.navigationController pushViewController:photo animated:YES ] ;
    }
    else if (indexPath.row == 5){ //  城市定位
        CityLocationVC *city = [[CityLocationVC alloc] init];
        [self.navigationController pushViewController:city animated:YES ] ;
    }
    else if (indexPath.row == 6){ //  仿照IPC
        CustomIPCVC *ipc = [[CustomIPCVC alloc] init];
        ipc.title = @"我的IPC" ;
        [self.navigationController pushViewController:ipc animated:YES ] ;
    }
    else if (indexPath.row == 7){ //  tableView: Plain-Grouped
        TableViewVC *table = [[TableViewVC alloc] init];
        table.title = @"Plain-Grouped" ;
        [self.navigationController pushViewController:table animated:YES ] ;
    }
    else if (indexPath.row == 8){ //  CHTCollection 瀑布流
        CHTCollectionVC *cht = [[CHTCollectionVC alloc] init];
        cht.title = @"CHTCollection" ;
        [self.navigationController pushViewController:cht animated:YES ] ;
    }
    else if (indexPath.row == 9){ //  TTTAttributedLabel 简单使用
        TTTLabelViewController *tttLabel = [[TTTLabelViewController alloc] init];
        tttLabel.title = @"TTTAttributeLabel" ;
        [self.navigationController pushViewController:tttLabel animated:YES ] ;
    }
    else if (indexPath.row == 10){ //  tableView headerview 特效
        TableHeaderViewController *header = [[TableHeaderViewController alloc] init];
        header.title = @"headerview 特效" ;
        [self.navigationController pushViewController:header animated:YES ] ;
    }
    else if (indexPath.row == 11){ //  sqlite_fmdb 练习
        FMDBController  *fmdb = [[FMDBController alloc] init];
        fmdb.title = @"sqlite_fmdb" ;
        [self.navigationController pushViewController:fmdb animated:YES ] ;
    }

    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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
