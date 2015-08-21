//
//  CityLocationVC.m
//  BlockTest
//
//  Created by huyang on 15/4/13.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "CityLocationVC.h"


#define KFullWidth  [UIScreen mainScreen].bounds.size.width
#define KFullHeight [UIScreen mainScreen].bounds.size.height
@interface CityLocationVC ()

@property(strong,nonatomic)UILabel *cityResult ;      // 城市名称
@property(strong,nonatomic)UILabel *longitudeLabel ;  // 显示经度的label
@property(strong,nonatomic)UILabel *latiduteLabel  ;  // 显示纬度的label
@property(strong,nonatomic)UILabel *addressDetail  ;  // 地址详情
@property(strong,nonatomic)UILabel *altitudeLabel  ;  // 海拔高度

@end

@implementation CityLocationVC

#pragma mark ===  ViewController lifecycle
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.manager = [[CLLocationManager alloc] init];            // 初始化
    self.manager.delegate = self ;                              // 设置代理
    self.manager.desiredAccuracy = kCLLocationAccuracyBest ;    // 设置精度
    self.manager.distanceFilter = 10.f ;                        // 更新限制距离,超过这个距离会再次开启定位功能
    if ([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [self.manager requestWhenInUseAuthorization];
    }
    [self.manager startUpdatingLocation];                       // 开始定位
    
    [self initLabels];
}

#pragma mark ---- CLLocationManager Delegate methods

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    float longitude = newLocation.coordinate.longitude ;
    float latitude = newLocation.coordinate.latitude ;
    _longitudeLabel.text = [NSString stringWithFormat:@"经度: 东经%.5f",longitude] ;
    _latiduteLabel.text = [NSString stringWithFormat:@"纬度: 北纬%.5f",latitude] ;
    
//    __weak CityLocationVC *weakself = self ;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error){
        /*
         @property (nonatomic, readonly, copy) NSString *name; // eg. Apple Inc.
         @property (nonatomic, readonly, copy) NSString *thoroughfare; // street address, eg. 1 Infinite Loop
         @property (nonatomic, readonly, copy) NSString *subThoroughfare; // eg. 1
         @property (nonatomic, readonly, copy) NSString *locality; // city, eg. Cupertino
         @property (nonatomic, readonly, copy) NSString *subLocality; // neighborhood, common name, eg. Mission District
         @property (nonatomic, readonly, copy) NSString *administrativeArea; // state, eg. CA
         @property (nonatomic, readonly, copy) NSString *subAdministrativeArea; // county, eg. Santa Clara
         @property (nonatomic, readonly, copy) NSString *postalCode; // zip code, eg. 95014
         @property (nonatomic, readonly, copy) NSString *ISOcountryCode; // eg. US
         @property (nonatomic, readonly, copy) NSString *country; // eg. United States
         @property (nonatomic, readonly, copy) NSString *inlandWater; // eg. Lake Tahoe
         @property (nonatomic, readonly, copy) NSString *ocean; // eg. Pacific Ocean
         @property (nonatomic, readonly, copy) NSArray *areasOfInterest; // eg. Golden Gate Park
         */
            for (CLPlacemark *place in placemarks)
            {
                NSDictionary *addressDic = place.addressDictionary ;
                NSString *conutry = [addressDic objectForKey:@"ISOcountryCode"];
                NSString *state = [addressDic objectForKey:@"administrativeArea"];
                NSString *city = [addressDic objectForKey:@"locality"];
                NSString *street = [addressDic objectForKey:@"thoroughfare"];
                
                NSLog(@" state = %@\n,country = %@\n,city = %@\n,street = %@",state,conutry,city,street);
            }
        
    }];
    
    [self.manager stopUpdatingLocation];
}

// iOS 8 系统调用这个方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    __weak CityLocationVC *weakself = self ;
    CLLocation *location = [locations lastObject] ;
    float longitude = location.coordinate.longitude ;
    float latitude = location.coordinate.latitude ;
    float altitude = location.altitude ;
    _longitudeLabel.text = [NSString stringWithFormat:@"经度: 东经%.5f",longitude] ;
    _latiduteLabel.text = [NSString stringWithFormat:@"纬度: 北纬%.5f",latitude] ;
    _altitudeLabel.text = [NSString stringWithFormat:@"海拔高度: %.1f米",altitude] ;

     /*
     @property(readonly, nonatomic) CLLocationCoordinate2D coordinate;          // 经纬度坐标
     @property(readonly, nonatomic) CLLocationDistance altitude;                // 海拔高度
     @property(readonly, nonatomic) CLLocationDirection course                  // 方向
     @property(readonly, nonatomic) CLLocationSpeed speed                       // 当前速度
     @property(readonly, nonatomic, copy) NSDate *timestamp                     // 此时时刻的日期
     @property (nonatomic, readonly, copy) NSString *description                // 描述
     */
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error){
        
//        NSLog(@"placemarks = %@",placemarks);
        /*
         @property (nonatomic, readonly, copy) NSString *name;            // 当前位置的详细信息 例如:中国上海市杨浦区五角场街道五角场邯郸路
         @property (nonatomic, readonly, copy) NSString *thoroughfare;    // 街道地址 例如: 邯郸路
         @property (nonatomic, readonly, copy) NSString *locality;        // 城市名称  返回格式为:上海市市辖区
         @property (nonatomic, readonly, copy) NSString *subLocality;     // 地区名称 例如 :杨浦区
         @property (nonatomic, readonly, copy) NSString *ISOcountryCode;  // 国家名称缩写 例如:中国 -> CN
         @property (nonatomic, readonly, copy) NSString *country;         // 国家名称 例如:中国
         */
        CLPlacemark *place = [placemarks lastObject];
        NSLog(@"name = %@",place.name) ;
        NSLog(@"street = %@",place.thoroughfare) ;
        NSLog(@"city = %@",place.locality) ;
        NSLog(@"country = %@",place.country) ;
        NSLog(@"subLocality = %@",place.subLocality) ;
        if (place.locality)
        {
            NSString *city = place.locality ;
            NSRange  range = [city rangeOfString:@"市"];
            city = [city substringToIndex:range.location];
            weakself.cityResult.text = city ;
        }
        if(place.name){
            weakself.addressDetail.text = place.name ;
        }
        
    }];
    [self.manager stopUpdatingLocation];
}

#pragma mark  === initLabels
-(void)initLabels
{
    _cityResult = [[UILabel alloc] init] ;
    _cityResult.frame = CGRectMake(0, 64, KFullWidth, 50) ;
    _cityResult.textColor = [UIColor redColor] ;
    _cityResult.font = [UIFont systemFontOfSize:24];
    _cityResult.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:_cityResult];
    
    _longitudeLabel = [[UILabel alloc] init] ;
    _longitudeLabel.frame = CGRectMake(0, 120, KFullWidth, 40) ;
    _longitudeLabel.textColor = [UIColor greenColor];
    _longitudeLabel.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:_longitudeLabel];
    
    _latiduteLabel = [[UILabel alloc] init] ;
    _latiduteLabel.frame = CGRectMake(0, 180, KFullWidth, 40) ;
    _latiduteLabel.textColor = [UIColor orangeColor];
    _latiduteLabel.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:_latiduteLabel];
    
    _addressDetail = [[UILabel alloc] init] ;
    _addressDetail.frame = CGRectMake(0, 240, KFullWidth, 40) ;
    _addressDetail.textColor = [UIColor blueColor];
    _addressDetail.numberOfLines = 0 ;
    _addressDetail.font = [UIFont systemFontOfSize:16] ;
//    [_addressDetail sizeToFit] ;
//    _addressDetail.lineBreakMode = NSLineBreakByWordWrapping ;
    [self.view addSubview:_addressDetail];
    
    _altitudeLabel = [[UILabel alloc] init] ;
    _altitudeLabel.frame = CGRectMake(0, 300, KFullWidth, 40) ;
    _altitudeLabel.textColor = [UIColor purpleColor];
    _altitudeLabel.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:_altitudeLabel];
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
