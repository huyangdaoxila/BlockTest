//
//  GCDViewController.h
//  BlockTest
//
//  Created by huyang on 15/3/9.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface GCDViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)UIActivityIndicatorView *indicator ;
@property(strong,nonatomic)UITableView *tableView ;
@property(strong,nonatomic)NSMutableArray *dataArray ;


@end
