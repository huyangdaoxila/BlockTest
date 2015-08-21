//
//  TableViewVC.m
//  BlockTest
//
//  Created by huyang on 15/4/15.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "TableViewVC.h"

static NSString *const identifier = @"tableViewCell" ;
@interface TableViewVC ()

@property(strong,nonatomic)UIImageView *headerImage ;

@end

@implementation TableViewVC

#pragma mark - ViewController lifecycle
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initTableView];
}
#pragma mark - initTableView
-(void)initTableView
{
    float height = 270*[UIScreen mainScreen].bounds.size.width/660 ;

    
    _dataArray = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < 5; i++)
    {
        NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:5];
        for (int j = 0 ; j < 5; j++)
        {
            NSString *str = [NSString stringWithFormat:@"%d--%d",i,j] ;
            [ary addObject:str];
        }
        [_dataArray addObject:ary];
    }
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self ;
    _tableView.dataSource = self ;
    [self.view insertSubview:_tableView atIndex:1] ;
    
//    UIView *fakeHeader = [[UIView alloc] init] ;
//    CGRect fakeRect = self.view.bounds ;
//    fakeRect.size.height = height +50 ;
//    fakeHeader.frame = fakeRect ;//CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, height) ;
//    fakeHeader.backgroundColor = [UIColor orangeColor];
//    fakeHeader.alpha = 1 ;
//    _tableView.tableHeaderView = fakeHeader ;
//    
//    _headerImage = [[UIImageView alloc] init];
//    _headerImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height) ;
//    _headerImage.image = [UIImage imageNamed:@"header.jpg"];
//    [self.view insertSubview:_headerImage atIndex:0]  ;
}
#pragma mark --- scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    if (scrollView == self.tableView )
//    {
//        if (_tableView.contentOffset.y < 0)
//        {
//            _headerImage.frame = CGRectMake(0+_tableView.contentOffset.y, 64+_tableView.contentOffset.y, self.view.frame.size.width-_tableView.contentOffset.y*2, self.view.frame.size.width/2-64-_tableView.contentOffset.y) ;
//        }
//    }
    
//    if (_tableView.contentOffset.y<0) {
//        _imageView.frame=CGRectMake(0+_tableView.contentOffset.y, 64(没导航栏为0)+_tableView.contentOffset.y, self.view.frame.size.width（图片的宽度）-_tableView.contentOffset.y*2（*2是往2边变大）, self.view.frame.size.width/3（图片的高度）-64（没导航为0）-_tableView.contentOffset.y);
//    }
    
}

#pragma mark - TableView datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *ary = _dataArray[section] ;
    return ary.count ;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count ;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"000" ;
    }else if (section == 1){
        return @"111";
    }
    else if (section == 2){
        return @"222";
    }
    else if (section == 3){
        return @"333";
    }
    else if (section == 4){
        return @"444";
    }else
        return @"" ;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSMutableArray *ary = _dataArray[indexPath.section] ;
    cell.textLabel.text = ary[indexPath.row];
    return cell ;
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
