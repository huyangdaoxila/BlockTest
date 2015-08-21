//
//  ViewController.m
//  BlockTest
//
//  Created by huyang on 15/2/27.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "GCDViewController.h"
#import "ToolsViewController.h"
#import "GoodButton.h"
#import "YOUNGUtils.h"


#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

typedef long (^BlkSum)(int,int) ;


@interface ViewController ()

@end

@implementation ViewController
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"主页";
    
    UIBarButtonItem *tool = [[UIBarButtonItem alloc] initWithTitle:@"工具" style:UIBarButtonItemStylePlain target:self action:@selector(showTools)];
    self.navigationItem.rightBarButtonItem = tool ;
    UIBarButtonItem *gcd = [[UIBarButtonItem alloc] initWithTitle:@"GCD" style:UIBarButtonItemStylePlain target:self action:@selector(pressGCDTest)];
    self.navigationItem.leftBarButtonItem = gcd ;
    
    [self labelTest];
    [self lldbPractice] ;
    [self floatTest];
    [self keyboardTest];
    [self blockTest] ;
    
//    UISegmentedControl *segment = [[UISegmentedControl alloc] init];
//    segment.frame = CGRectMake((SCREENWIDTH-100)/2.0, SCREENHEIGHT-100.0, 100.f, 30);
//    [segment insertSegmentWithTitle:@"消息" atIndex:0 animated:NO];
//    [segment insertSegmentWithTitle:@"通话" atIndex:1 animated:NO];
//    segment.tintColor = [UIColor orangeColor];
//    segment.layer.cornerRadius = 15.f;
//    segment.layer.masksToBounds = YES ;
//    segment.layer.borderColor = [UIColor orangeColor].CGColor;
//    segment.layer.borderWidth = 1.f ;
//    segment.selectedSegmentIndex = 0 ;
//    [self.view addSubview:segment];
//    
//    NSLog(@"class -- %@",[@20 class]) ;
    
    GoodButton *good = [[GoodButton alloc] initWithFrame:CGRectMake((SCREENWIDTH-100)/2.0, SCREENHEIGHT-100.0, 50.f, 35)];
    good.backgroundColor = [UIColor clearColor];
    [good addTarget:self action:@selector(pressGoodAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:good];
}
-(void)pressGoodAction
{
    NSLog(@"点赞成功");
}


-(void)showTools
{
    ToolsViewController *tool = [[ToolsViewController alloc] init];
    [self.navigationController pushViewController:tool animated:YES] ;
}
-(void)pressGCDTest
{
    GCDViewController *gcd = [[GCDViewController alloc] init] ;
    [self.navigationController pushViewController:gcd animated:YES] ;
    NSString *test = @"sdverv";
    CGSize size = [test sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:CGSizeMake(300, MAXFLOAT)];
}
-(void)labelTest
{
    UILabel *context = [[UILabel alloc] init];
    context.backgroundColor = [UIColor lightGrayColor];
    context.frame = CGRectMake(10, 100, 300, 0);
    context.font = [UIFont systemFontOfSize:14.0];
    context.numberOfLines = 0 ;
    context.text = @"更新内容:\n1. 新增喜帖功能,快来试试\n2. 背景音乐选择优化\n3. 认领/邀请流程优化\n4. 图片无法上传\n5. 解决幻灯片播放不流畅问题";
    
    //创建一个字体属性对象
    NSDictionary *dicAttribute = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName, nil] ;
    
    //获得字符串所占用空间的大小
    //参数一：设置指定的最大范围
    //参数二：绘图的指定设置,根据文字大小来计算,文字大小优先
    //NSStringDrawingUsesLineFragmentOrigin：保持原始数据从开始计算
    //NSStringDrawingTruncatesLastVisibleLine:显示到最后一行
    //参数三：字体属性
    //参数四：为扩展参数
    //返回值为占用矩形的大小
    CGRect textSize = [context.text boundingRectWithSize:CGSizeMake(300, 9999)
                                                 options:NSStringDrawingUsesFontLeading|
                       NSStringDrawingUsesLineFragmentOrigin|
                       NSStringDrawingTruncatesLastVisibleLine
                                              attributes:dicAttribute
                                                 context:nil];
    context.frame = CGRectMake(10, 100, 300, textSize.size.height) ;
    [self.view addSubview:context] ;
    
    UILabel *fit = [[UILabel alloc] initWithFrame:CGRectMake(10, 300, [UIScreen mainScreen].bounds.size.width-20, 20)];
    fit.backgroundColor = [UIColor yellowColor];
    fit.text = @"更新内容:\n1. 新增喜帖功能,快来试试\n2. 背景音乐选择优化\n3. 认领/邀请流程优化\n4. 图片无法上传\n5. 解决幻灯片播放不流畅问题";
    fit.font = [UIFont systemFontOfSize:20] ;
    fit.numberOfLines = 0 ;
    [fit sizeToFit] ;
    
    [self.view addSubview:fit] ;
    
    NSLog(@"Y = %.2f",fit.frame.origin.y+fit.frame.size.height) ;
    
    UILabel *testLabel = [[UILabel alloc] init];
    testLabel.text = @"88888" ;
    testLabel.textColor = [UIColor purpleColor];
    testLabel.backgroundColor = [UIColor clearColor];
    testLabel.font = [UIFont systemFontOfSize:9] ;
    testLabel.layer.cornerRadius = 3.f ;
    testLabel.textAlignment = NSTextAlignmentCenter ;
    testLabel.layer.borderWidth = 1.f ;
    testLabel.layer.borderColor = [UIColor purpleColor].CGColor;
    NSDictionary *testDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:9],NSFontAttributeName, nil] ;

    CGRect textRect = [testLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30)
                                                 options:NSStringDrawingTruncatesLastVisibleLine
                                              attributes:testDic
                                                 context:nil];
    testLabel.frame = CGRectMake(10, 480, 60.f, 20) ;
    [self.view addSubview:testLabel];
    NSLog(@"test width -- %.2f",textRect.size.width) ;
    NSLog(@"testLabel width -- %.2f",testLabel.bounds.size.width) ;
    
    int score = (int)(4.6/0.5)  ;
    NSLog(@"star*******  %d",score) ;
    NSLog(@"lowerCaseString == %@",[@"#FFFFFF" lowercaseString]) ;
    
    CGFloat TestWidth = [YOUNGUtils getTextWidthWithString:testLabel.text andFontSize:9.f] ;
    NSLog(@"______TestWidth_______ %.2f ",TestWidth);
}

-(void)blockTest
{
    int base = 100 ;
    
    // BlkSum sum 在定义时copy局部变量base的值,也就是说在这个block中base是一个值为100的常量
    // 输出结果为 100+1+2 ---> 103 ;
    BlkSum sum = ^ long (int a,int b){
        return base + a + b ;
    } ;
    base = 0 ;
    
    NSLog(@"sum = %ld",sum(1,2)) ;
    //***************************************************************************
    // block 可以对全局变量或者静态变量进行读写,因为全局变量或静态变量在内存中的地址是固定的，Block在读取该变量值的时候是直接从其所在内存读出，获取到的是最新值，而不是在定义时copy的常量。
    static int baseStatic = 100 ;
    
    BlkSum sumStatic = ^ long (int a,int b){
        baseStatic ++ ;
        return baseStatic + a + b ;
    } ;
    baseStatic = 0 ;
    NSLog(@"baseStatic = %d",baseStatic); //--> 0
    
    NSLog(@"sumStatic = %ld",sumStatic(1,2)) ;//--> 4  这个block执行的时候先取到baseStatic最新的值,即更改后的0,然后自加一次,在进行和的运算,结果为: 4.
    
    NSLog(@"baseStatic = %d",baseStatic); //--> 1 block 可以对全局变量或者静态变量进行读写,自加后的baseStatic为: 1.
}


-(void)keyboardTest
{
    _tfTest = [[UITextField alloc] init];
    _tfTest.clearButtonMode = UITextFieldViewModeWhileEditing ;
    _tfTest.backgroundColor = [UIColor cyanColor];
    _tfTest.layer.cornerRadius = 5.f ;
    _tfTest.layer.masksToBounds = YES ;
    _tfTest.placeholder = @"Input someThing";
    _tfTest.frame = CGRectMake(10, 220, 300, 30);
    [self.view addSubview:_tfTest];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_tfTest resignFirstResponder];
}
-(void)floatTest
{
    float a = 0.1+0.3 ;
    float b = 0.2+0.2 ;
    if (a == b)
    {
        NSLog(@"a=b");
    }
    else
    {
        NSLog(@"a!= b");
    }
}
-(void)lldbPractice
{
    NSArray *array = @[@"1",@"2",@"3"];
    
    for (int i  = 0 ; i < 3 ; i++)
    {
        NSString *obj = array[i] ;
        NSLog(@"obj = %@",obj);
    }
}
@end




















