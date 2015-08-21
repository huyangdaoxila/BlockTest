//
//  PickerViewVC.m
//  BlockTest
//
//  Created by huyang on 15/3/16.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "PickerViewVC.h"

#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
@interface PickerViewVC ()

{
    NSMutableArray *_yearArray  ;
    NSMutableArray *_monthArray ;
    NSMutableArray *_dayArray   ;
    NSMutableArray *_hourArray  ;
    NSMutableArray *_dataArray  ;
}

@end

@implementation PickerViewVC

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *back = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    back.frame = CGRectMake(10, 20, 60, 40);
    [back setTitle:@"Back" forState:UIControlStateNormal];
    [back addTarget:self action:@selector(pressBack) forControlEvents:UIControlEventTouchUpInside] ;
    [self.view addSubview:back] ;
    
    [self setupUI] ;
    [self setupPickerView] ;
}
#pragma mark - back action
-(void)pressBack
{
    [self dismissViewControllerAnimated:YES completion:nil] ;
}
-(void)setupUI
{
    UIView *pickerHeader = [[UIView alloc] init] ;
    pickerHeader.frame = CGRectMake(0, Screen_Height-250, Screen_Width, 70) ;
    pickerHeader.backgroundColor = [UIColor orangeColor] ;
    [self.view addSubview:pickerHeader] ;
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
    cancel.frame = CGRectMake(0, 0, 60, 40) ;
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    cancel.enabled = NO ;
    [pickerHeader addSubview:cancel ] ;
    
    UIButton *confirm = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
    confirm.frame = CGRectMake(Screen_Width-60, 0, 60, 40) ;
    [confirm setTitle:@"确定" forState:UIControlStateNormal] ;
    [confirm addTarget:self action:@selector(getWeddingDate) forControlEvents:UIControlEventTouchUpInside] ;
    [pickerHeader addSubview:confirm] ;
    
    NSArray *timeTitles = [NSArray arrayWithObjects:@"年",@"月",@"日",@"时", nil];
    for (int i = 0 ; i < 4; i++)
    {
        UILabel *time = [[UILabel alloc] init];
        time.backgroundColor = [UIColor whiteColor] ;
        time.textAlignment = NSTextAlignmentCenter ;
        time.frame = CGRectMake(i*Screen_Width/4, 40, Screen_Width/4, 30) ;
        time.text = timeTitles[i] ;
        [pickerHeader addSubview:time] ;
    }
}
-(void)getWeddingDate
{
    if (_selectedYear != nil && _selectedMonth != nil && _selectedDay != nil && _selectedHour != nil)
    {
        NSString *finalDate = [NSString stringWithFormat:@"%@年%@月%@号 %@:00",_selectedYear,_selectedMonth,_selectedDay,_selectedHour] ;
        NSLog(@"wedding Date = %@",finalDate) ;
    }
}
#pragma mark - setupPickerView
-(void)setupPickerView
{
    _yearArray = [[NSMutableArray alloc] init] ;
    for (int i = 2000 ; i < 2051 ; i++)
    {
        NSString *year = [NSString stringWithFormat:@"%d",i] ;
        [_yearArray addObject:year ] ;
    }
    
    _monthArray = [[NSMutableArray alloc] init ] ;
    for (int i = 1 ; i <=12 ; i++)
    {
        NSString *month =  [NSString stringWithFormat:@"%d",i] ;
        [_monthArray addObject:month ] ;
    }
    
    _dayArray = [[NSMutableArray alloc] init ] ;
    for (int i = 1 ; i < 32 ; i++)
    {
        NSString *day = [NSString stringWithFormat:@"%d",i] ;
        [_dayArray addObject:day] ;
    }
    
    _hourArray = [[NSMutableArray alloc] init] ;
    for (int i = 0 ; i < 24 ; i++)
    {
        NSString *hour = [NSString stringWithFormat:@"%d",i] ;
        [_hourArray addObject:hour] ;
    }
    
    _dataArray = [[NSMutableArray alloc] initWithObjects:_yearArray,_monthArray,_dayArray,_hourArray, nil] ;
    
    _picker = [[UIPickerView alloc] init] ;
    //_picker.backgroundColor = [UIColor lightGrayColor] ;
    _picker.showsSelectionIndicator = YES ;
    _picker.frame = CGRectMake(0, Screen_Height-180, Screen_Width, 180) ;
    _picker.delegate = self ;
    _picker.dataSource = self ;
    [self.view addSubview:_picker] ;
    
    [_picker reloadAllComponents] ;
}
#pragma mark - pickerView datasource & delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return _dataArray.count ;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_dataArray[component] count] ;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_dataArray[component] objectAtIndex:row] ;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
    {
        _currentIndex01 = row ;
        _selectedYear = [_dataArray[component] objectAtIndex:_currentIndex01] ;
    }
    else if (component == 1)
    {
        _selectedMonth = [_dataArray[component] objectAtIndex:row] ;
    }
    else if (component == 2)
    {
        _selectedDay = [_dataArray[component] objectAtIndex:row] ;
    }
    else if (component == 3)
    {
        _selectedHour = [_dataArray[component] objectAtIndex:row] ;
    }
    
    if (_selectedYear != nil && _selectedMonth != nil && _selectedDay != nil && _selectedHour != nil)
    {
        NSString *finalDate = [NSString stringWithFormat:@"%@年%@月%@号:%@时",_selectedYear,_selectedMonth,_selectedDay,_selectedHour] ;
        NSLog(@"wedding Date = %@",finalDate) ;
    }
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 60. ;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return Screen_Width/4 ;
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
