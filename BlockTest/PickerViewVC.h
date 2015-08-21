//
//  PickerViewVC.h
//  BlockTest
//
//  Created by huyang on 15/3/16.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerViewVC : UIViewController
<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSInteger _currentIndex01 ;
    NSInteger _currentIndex02 ;
    NSInteger _currentIndex03 ;
    NSInteger _currentIndex04 ;
    
    NSString *_selectedYear ;
    NSString *_selectedMonth ;
    NSString *_selectedDay ;
    NSString *_selectedHour ;
}


@property(strong,nonatomic)UIPickerView *picker ;

@end
