//
//  GCDViewController.m
//  BlockTest
//
//  Created by huyang on 15/3/9.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "GCDViewController.h"
#import <UIColor+Expanded.h>
#import <MBProgressHUD.h>
#import <MJRefresh.h>
#import "CollectionViewController.h"

@interface GCDViewController ()<MBProgressHUDDelegate>

@property(strong,nonatomic)MBProgressHUD *hud ;

@end

@implementation GCDViewController


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"MJ-Table";
    
    _indicator = [[UIActivityIndicatorView alloc] init];
    _indicator.frame = CGRectMake((SCREENWIDTH-100)/2, (SCREENHEIGHT-100)/2, 100, 100) ;
    //_indicator.backgroundColor = [UIColor blackColor];
    _indicator.hidden = YES ;
    [self.view addSubview:_indicator];
    
    //[self useGCD];
    
    
    _hud = [[MBProgressHUD alloc] initWithView:self.view];
    _hud.delegate = self ;
    [_hud showWhileExecuting:@selector(myHUDTask) onTarget:self withObject:nil animated:YES];
    [self.view addSubview:_hud];
    
    
}
-(void)myHUDTask
{
    sleep(2);
    
    [self createFakeData];
    
    CGRect rect = self.view.bounds ;
    rect.origin.y += 64 ;
    rect.size.height -= 64 ;
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _tableView.delegate = self ;
    _tableView.dataSource = self ;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    [self.view addSubview:_tableView] ;
    
    // 使用  MJRefresh  下拉刷新数据
    __weak typeof(self) weakSelf = self ;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf refreshData] ;
    }];
    
    // 使用  MJRefresh  上拉加载更多数据
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

#pragma mark - 上拉加载更多数据
-(void)loadMoreData
{
    for (int i = 0 ; i < 10 ; i++)
    {
        NSString *str = [NSString stringWithFormat:@"随机数据---%d",arc4random_uniform(100)] ;
        [_dataArray addObject:str] ;
    }
    
    double delayInSecond = 2.0 ;
    dispatch_time_t poptime = dispatch_time(DISPATCH_TIME_NOW, delayInSecond * NSEC_PER_SEC);
    dispatch_after(poptime, dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData] ;
        [self.tableView.footer endRefreshing] ;
    });
}
#pragma mark - 下拉刷新数据
-(void)refreshData
{
    double delayInSecond = 2.0 ;
    dispatch_time_t poptime = dispatch_time(DISPATCH_TIME_NOW, delayInSecond * NSEC_PER_SEC);
    dispatch_after(poptime, dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData] ;
        [self.tableView.header endRefreshing] ;
    });
    
}
#pragma mark - useGCD
-(void)useGCD
{
    self.indicator.hidden = NO ;
    [self.indicator startAnimating];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
        NSError *error = nil ;
        NSString *dataStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error] ;
        
        if (dataStr != nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                sleep(3);
                [self.indicator stopAnimating];
                self.indicator.hidden = YES ;
                self.view.backgroundColor = [UIColor blueColor];
                //NSLog(@"dataStr = %@",dataStr);
            });
        }
        else{
            NSLog(@"error when download:%@",error);
        }
    });
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary] ;
    param[@"age"] = @"20" ;
    param[@"name"] = @"Lee" ;
    param[@"phoneNum"] = @"18165251225" ;
    NSLog(@"param.name = %@",param[@"name"]) ;
}
#pragma mark - createFakeData
-(void)createFakeData
{
    _dataArray = [[NSMutableArray alloc] init] ;
    
    for (int i = 0 ; i < 20; i++)
    {
        NSString *str = [NSString stringWithFormat:@"%d%d%d",i,i+1,i+2] ;
        [_dataArray addObject:str] ;
    }
}
#pragma mark - tableView dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count ;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    cell.backgroundColor = [UIColor randomColor] ;
    cell.textLabel.text = _dataArray[indexPath.row] ;
    return cell ;
}
#pragma mark - tableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath] ;
    cell.backgroundColor = [UIColor randomColor] ;
    
    CollectionViewController *collect = [[CollectionViewController alloc] init] ;
    [self.navigationController pushViewController:collect animated:YES] ;
    
    //[self.tableView removeFromSuperview] ;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES ;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [_dataArray removeObjectAtIndex:indexPath.row];
        
        [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
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
