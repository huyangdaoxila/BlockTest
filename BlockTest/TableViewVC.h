//
//  TableViewVC.h
//  BlockTest
//
//  Created by huyang on 15/4/15.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)UITableView    *tableView ;
@property(strong,nonatomic)NSMutableArray *dataArray ;

@end
