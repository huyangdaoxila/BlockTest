//
//  CityLocationVC.h
//  BlockTest
//
//  Created by huyang on 15/4/13.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

/*
 *  需要自己手动添加 MapKit,CoreLocation 这两个frameWork
 */


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface CityLocationVC : UIViewController<CLLocationManagerDelegate>

@property(strong,nonatomic)CLLocationManager *manager ;

@end
