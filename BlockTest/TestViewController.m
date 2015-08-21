//
//  TestViewController.m
//  BlockTest
//
//  Created by huyang on 15/3/3.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "TestViewController.h"
#import "TestTableViewCell.h"
#import <MBProgressHUD.h>
#import <unistd.h>
#import <UIColor+Expanded.h>

///   林建利公积金账号: 134192199205

@interface TestViewController ()<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDelegate,MBProgressHUDDelegate>

@property(strong,nonatomic)MBProgressHUD *hud ;

@end

@implementation TestViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom] ;
    btn.frame = CGRectMake(10, 20, 60, 40);
    [btn setTitle:@"back" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self  action:@selector(pressToBack) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:btn] ;
    
    _dataArray = [[NSMutableArray alloc] initWithObjects:@"风火轮",@"风火轮+文字",@"风火轮+文字+详情文字",@"饼状图",@"圆环",@"block",@"对号显示",@"只有文字显示",@"使用URL",@"横向进度条", nil];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
    _tableView.delegate = self ;
    _tableView.dataSource = self ;
    [self.view addSubview:_tableView];
}
#pragma mark - all kinds of button actions
-(void)pressToBack
{
    [self dismissViewControllerAnimated:YES completion:nil] ;
}

#pragma mark - HUD tasks
- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    sleep(3);
}
- (void)myProgressTask {
    // This just increases the progress indicator in a loop
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.01f;
        _hud.progress = progress;
        usleep(50000);
    }
}
#pragma mark - tableView dataSource methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CellIdentifier" ;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.textColor = [UIColor purpleColor];
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    return cell ;
    
/*  TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TestTableViewCell" owner:cell options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;    */
    
}
#pragma mark - tableView delegate method
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0: //风火轮--默认的 可设定颜色
            {
                _hud = [[MBProgressHUD alloc] initWithView:self.view];
                //_hud.color = [UIColor colorWithHexString:@"#FaFbQd"];
                _hud.color = [UIColor randomColor] ;
                [self.view addSubview:_hud];
                _hud.delegate = self ;
                [_hud showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
            }
            break;
        case 1: //风火轮+文字
            {
                _hud = [[MBProgressHUD alloc] initWithView:self.view];
                [self.view addSubview:_hud];
                _hud.delegate = self ;
                _hud.labelText = @"正在加载";
                [_hud showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
            }
            break;
        case 2: //风火轮+文字+详情文字
            {
                _hud = [[MBProgressHUD alloc] initWithView:self.view];
                [self.view addSubview:_hud];
                _hud.delegate = self ;
                _hud.labelText = @"正在加载";
                _hud.detailsLabelText = @"这是详情文字" ;
                [_hud showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
            }
            break;
        case 3: //饼状图
            {
                _hud = [[MBProgressHUD alloc] initWithView:self.view];
                [self.view addSubview:_hud];
                _hud.mode = MBProgressHUDModeDeterminate ;
                _hud.delegate = self ;
                _hud.labelText = @"正在加载";
                [_hud showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
            }
            break;
        case 4: //圆环图
            {
                _hud = [[MBProgressHUD alloc] initWithView:self.view];
                [self.view addSubview:_hud];
                _hud.mode = MBProgressHUDModeAnnularDeterminate ;
                _hud.delegate = self ;
                _hud.labelText = @"正在加载";
                [_hud showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
            }
            break;
        case 5: //block
            {
                __weak typeof(self) weakSelf = self ;
                MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
                [self.view addSubview:hud];
                hud.labelText = @"With a block";
                [hud showAnimated:YES whileExecutingBlock:^{
                    [weakSelf myTask];
                } completionBlock:^{
                    [hud removeFromSuperview];
                }];
            }
            break;
        case 6: //对号
            {
                _hud = [[MBProgressHUD alloc] initWithView:self.view];
                [self.view addSubview:_hud];
                _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
                _hud.mode = MBProgressHUDModeCustomView ;
                _hud.delegate = self ;
                _hud.labelText = @"完成" ;
                [_hud show:YES] ;
                [_hud hide:YES afterDelay:3] ;//三秒后隐藏
            }
            break;
        case 7: //只有文字
            {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                
                // Configure for text only and offset down
                hud.mode = MBProgressHUDModeText;
                hud.labelFont = [UIFont systemFontOfSize:12] ;
                hud.labelText = @"只显示文字,只显示文字,只显示文字,只显示文字,只显示文字,只显示文字,只显示文字";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:3];
            }
            break;
        case 8: //使用URL
            {
                NSURL *URL = [NSURL URLWithString:@"http://a1408.g.akamai.net/5/1408/1388/2005110403/1a1a1ad948be278cff2d96046ad90768d848b41947aa1986/sample_iPod.m4v.zip"] ;
                NSURLRequest *request = [NSURLRequest requestWithURL:URL];
                NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
                [connection start] ;
                
                _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES] ;
                [self.view addSubview:_hud];
                _hud.delegate = self ;
                _hud.mode = MBProgressHUDModeDeterminate;
            }
            break;
        case 9: //横向进度条
            {
                _hud = [[MBProgressHUD alloc] initWithView:self.view];
                [self.view addSubview:_hud];
                _hud.mode = MBProgressHUDModeDeterminateHorizontalBar ;
                _hud.delegate = self ;
                _hud.labelText = @"正在加载";
                [_hud showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
            }
            break;
            
        default:
            break;
    }
    
}
#pragma mark - NSURLConnectionDelegete

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _totalLength = MAX([response expectedContentLength], 1);
    _currentLength = 0;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    _currentLength += [data length];
    _hud.progress = _currentLength / (float)_totalLength;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [_hud hide:YES afterDelay:0];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [_hud hide:YES];
}

@end
