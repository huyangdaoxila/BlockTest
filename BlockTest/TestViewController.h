//
//  TestViewController.h
//  BlockTest
//
//  Created by huyang on 15/3/3.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestViewController : UIViewController

@property(strong,nonatomic)UITableView *tableView ;
@property(strong,nonatomic)NSMutableArray *dataArray ;
@property(assign,nonatomic)float totalLength ;
@property(assign,nonatomic)float currentLength ;

@end
