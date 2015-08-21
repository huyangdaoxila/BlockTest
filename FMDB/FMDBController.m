//
//  FMDBController.m
//  BlockTest
//
//  Created by huyang on 15/5/14.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "FMDBController.h"
#import "YoungMacrosHeader.h"
#import "LVFmdbTool.h"
#import "LVModal.h"
#import "FMDBCell.h"

static NSString * identifier = @"tableViewCell" ;
@interface FMDBController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property(strong,nonatomic)UITableView    *tableView ;
@property(strong,nonatomic)UISearchBar    *searchBar ;
@property(strong,nonatomic)NSMutableArray *dataArray ;

@property(strong,nonatomic)UITextField    *nameTF ;
@property(strong,nonatomic)UITextField    *ageTF ;
@property(strong,nonatomic)UITextField    *idTF ;

@end

@implementation FMDBController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initTextFields];
    [self initControls];
    [self initTableView];
}

#pragma mark --- initSubViews methods
-(void)initTextFields
{
    _nameTF = [[UITextField alloc] init] ;//WithFrame:
    _ageTF = [[UITextField alloc] init];
    _idTF = [[UITextField alloc] init];
    NSArray *textFields = @[_nameTF,_ageTF,_idTF];
    NSArray *placeholders = @[@"姓名",@"年龄",@"身份证号码"];
    for (int i = 0 ; i < 3 ; i++)
    {
        UITextField *tf = textFields[i] ;
        tf.frame = CGRectMake(10+((KFullWidth-40.f)/3+10)*i, 70, (KFullWidth-40.f)/3, 26.f);
        tf.placeholder = placeholders[i] ;
        tf.layer.cornerRadius = 3.f ;
        tf.layer.masksToBounds = YES ;
        tf.layer.borderWidth = 1.f ;
        tf.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.view addSubview:tf];
    }
}
-(void)initControls
{
    NSArray *titles = @[@"插入",@"修改",@"查询",@"删除"];
    for (int i = 0 ; i < 4 ; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.masksToBounds = YES ;
        btn.layer.cornerRadius = 5.f ;
        btn.tag = 100 + i ;
        btn.backgroundColor = [UIColor cyanColor];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(20+(KFullWidth-20.f)/4*i, 100, 60.f, 30.f);
        [btn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

-(void)initTableView
{
    self.dataArray = [NSMutableArray array] ;
    CGRect rect = CGRectMake(0, 140.f, KFullWidth, KFullHeight-110.f);
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
//    _tableView.backgroundColor = [UIColor grayColor];
    _tableView.delegate = self ;
    _tableView.dataSource = self ;
    [self.view addSubview:_tableView];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, KFullWidth, 40.f)];
    _searchBar.delegate = self ;
    _tableView.tableHeaderView = _searchBar ;
}

#pragma mark --- buttonClick action
-(void)buttonClick:(UIButton*)btn
{
    if (btn.tag == 100)          // 插入数据
    {
        if (_nameTF.text.length == 0 || _ageTF.text.length == 0 || _idTF.text.length == 0)
        {
            return ;
        }
        
        LVModal *model = [LVModal modalWith:_nameTF.text age:_ageTF.text.integerValue no:_idTF.text.intValue] ;
        BOOL isInsert = [LVFmdbTool insertModal:model] ;
        
        if (isInsert) {
            [self.dataArray addObject:model];
            [self.tableView reloadData];
        }else{
            NSLog(@"插入数据失败");
        }
    }
    else if (btn.tag == 101)     // 修改数据
    {
    
    }
    else if (btn.tag == 102)     // 查询数据
    {
        
    }
    else if (btn.tag == 103)     // 删除数据
    {
        NSString *deleteSql = @"DELETE FROM t_modals WHERE name = 'zhangsan'";
        [LVFmdbTool deleteData:deleteSql];
        
        
    }
}

#pragma mark --- searchBar delegate method
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{

}

#pragma mark --- tableView datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;//_dataArray.count ;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FMDBCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier] ;
    if (!cell) {
        cell = [[FMDBCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.nameLabel.text = @"lee" ;
    cell.ageLabel.text = @"12" ;
    cell.idLabel.text = @"54354645365";
    return cell ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.f ;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_nameTF resignFirstResponder];
    [_ageTF resignFirstResponder];
    [_idTF resignFirstResponder];
}

-(void)dealloc
{
    NSLog(@"----%s----",__FUNCTION__) ;
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
