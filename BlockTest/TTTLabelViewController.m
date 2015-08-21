//
//  TTTLabelViewController.m
//  BlockTest
//
//  Created by huyang on 15/4/23.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "TTTLabelViewController.h"
#import "TTTAttributedLabel.h"

@interface TTTLabelViewController ()

@end

@implementation TTTLabelViewController

#pragma mark --- viewController lifecycle

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self TTTlabelTest];
}

-(void)TTTlabelTest
{
    TTTAttributedLabel *first01 = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(10, 70, 300, 40)];
    first01.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop ;
    first01.backgroundColor = [UIColor lightGrayColor];
    first01.numberOfLines = 0 ;
    NSMutableAttributedString *text01 = [[NSMutableAttributedString alloc] initWithString:@"使用不同颜色和不同字体的字符串http://192.168.2.22"];
    [text01 addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,3)];
    [text01 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3,text01.length-3)];
    [text01 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:20.0] range:NSMakeRange(0, 3)];
    [text01 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0] range:NSMakeRange(3, text01.length-3)];
    first01.attributedText = text01;
        
    [self.view addSubview:first01];
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
