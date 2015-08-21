//
//  WaterViewController.m
//  BlockTest
//
//  Created by huyang on 15/3/19.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "WaterViewController.h"
#import "ZBFlowView.h"
#import "ZBWaterView.h"
@interface WaterViewController ()<ZBWaterViewDatasource,ZBWaterViewDelegate>

@property(strong,nonatomic)ZBWaterView *waterView ;

@end

@implementation WaterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _waterView = [[ZBWaterView alloc] initWithFrame:self.view.bounds] ;
    _waterView.waterDataSource = self ;
    _waterView.waterDelegate = self ;
    _waterView.isDataEnd = NO ;
    [self.view addSubview:_waterView] ;
    [_waterView reloadData] ;
}
-(NSInteger)numberOfFlowViewInWaterView:(ZBWaterView *)waterView
{
    return 20 ;
}
-(CustomWaterInfo*)infoOfWaterView:(ZBWaterView *)waterView
{
    CustomWaterInfo *info = [[CustomWaterInfo alloc] init];
    info.topMargin = 15;
    info.leftMargin = 15;
    info.bottomMargin = 10;
    info.rightMargin = 15;
    info.horizonPadding = 10;
    info.veticalPadding = 10;
    info.numOfColumn = 2;
    return info;
}
-(ZBFlowView*)waterView:(ZBWaterView *)waterView flowViewAtIndex:(NSInteger)index
{
    float width = ([UIScreen mainScreen].bounds.size.width-40)/2 ;
    CGRect rect = CGRectZero ;
    if (index%3 == 0)
    {
         rect = CGRectMake(0, 0, width, 70) ;
    }
    else if (index%3 == 1)
    {
         rect = CGRectMake(0, 0, width, 100) ;
    }
    else{
         rect = CGRectMake(0, 0, width, 130) ;
    }
    ZBFlowView *flowView = [waterView dequeueReusableCellWithIdentifier:@"cell"];
    if (flowView == nil) {
        flowView = [[ZBFlowView alloc] initWithFrame:rect];
        flowView.reuseIdentifier = @"cell";
    }
    flowView.index = index;
    //flowView.backgroundColor = [UIColor yellowColor];
    
    return flowView;
}
-(CGFloat)waterView:(ZBWaterView *)waterView heightOfFlowViewAtIndex:(NSInteger)index
{
    int num = index%3 ;
    switch (num) {
        case 0:
            return 70 ;
            break;
        case 1:
            return 100 ;
            break;
        case 2:
            return 120 ;
            break;
        default:
            break;
    }
    return 10 ;
}

- (void)waterView:(ZBWaterView *)waterView didSelectAtIndex:(NSInteger)index
{
    NSLog(@"didSelectAtIndex%d",(int)index);
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
