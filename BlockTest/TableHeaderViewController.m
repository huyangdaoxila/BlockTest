//
//  TableHeaderViewController.m
//  BlockTest
//
//  Created by huyang on 15/4/28.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "TableHeaderViewController.h"
#import <MJExtension.h>

#import "WCGiftCell.h"
#import "WCSeiresCouponModel.h"

#define KFullWidth  [UIScreen mainScreen].bounds.size.width
#define KFullHeight [UIScreen mainScreen].bounds.size.height
static NSString *const identifier = @"tableViewCell";
@interface TableHeaderViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)UITableView *tableView ;
@property(strong,nonatomic)NSArray     *dataArray ;

@property(strong,nonatomic)UIImageView *headerImage ;
@property(strong,nonatomic)UIView      *headerView ;

@property(strong,nonatomic)WCSeiresCouponModel *model ;

@end

@implementation TableHeaderViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    _headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 100)];
//    _headerImage.image = [UIImage imageNamed:@"header.jpg"];
//    [self.view addSubview:_headerImage];
    
    _dataArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"] ;
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
//    _tableView.separatorColor = [UIColor clearColor];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    _tableView.delegate = self ;
    _tableView.dataSource = self ;
    [self.view addSubview:_tableView];
    
    _model = [[WCSeiresCouponModel alloc] init];
    _model.is_cashBack = NO ;
    _model.is_couponLi = NO ;
    _model.is_couponHui = YES ;
    _model.cashBackText = @"通过到喜啦预定，立享10%返现" ;
    _model.liText = @"到店就送礼,高级保温杯一个!";
    _model.huiText = @"礼包大赠送,再送400元现金大礼包" ;
}

#pragma mark -- tableView datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BOOL isEmpty = (!_model.is_cashBack && !_model.is_couponLi && !_model.is_couponHui);
    return isEmpty ? 0 : 1;//_dataArray.count ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getCellFinalHeight] ;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WCGiftCell *cell = [[WCGiftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    
    cell.model = _model ;
    return cell ;
}

- (CGFloat)getCellFinalHeight
{
    CGFloat height = 100.f ;
    
    height = _model.is_cashBack ? height : height-30.f ;
    height = _model.is_couponLi ? height : height-30.f ;
    height = _model.is_couponHui ? height : height-30.f ;
    
    return height ;
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
