//
//  CameraPushedVC.m
//  BlockTest
//
//  Created by huyang on 15/4/8.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "CameraPushedVC.h"
#import "PhotoViewController.h"

#define Screen_width [UIScreen mainScreen].bounds.size.width
#define Screen_height [UIScreen mainScreen].bounds.size.height
@interface CameraPushedVC ()

@property(strong,nonatomic)UIButton *takeAgain ;
@property(strong,nonatomic)UIButton *usePhoto  ;
@property(strong,nonatomic)UIImageView *mainImageView ;

@end

@implementation CameraPushedVC

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor] ;
    
    _takeAgain = [UIButton buttonWithType:UIButtonTypeCustom];
    [_takeAgain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _takeAgain.frame = CGRectMake(10.f, Screen_height-50, 80, 50);
    [_takeAgain setTitle:@"重拍" forState:UIControlStateNormal];
    [_takeAgain addTarget:self action:@selector(backToCamera) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_takeAgain];
    
    _usePhoto = [UIButton buttonWithType:UIButtonTypeCustom];
    [_usePhoto setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _usePhoto.frame = CGRectMake(Screen_width-90.f, Screen_height-50, 80, 50);
    [_usePhoto setTitle:@"使用照片" forState:UIControlStateNormal];
    [_usePhoto addTarget:self action:@selector(usePhotoAsAvator) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_usePhoto];
    
    _mainImageView = [[UIImageView alloc] init];
    _mainImageView.backgroundColor = [UIColor orangeColor];
    _mainImageView.frame = CGRectMake(0, 0, Screen_width, Screen_height-50) ;
    _mainImageView.image = _gotImage ;
    [self.view addSubview:_mainImageView];
}
-(void)backToCamera
{
    [self dismissViewControllerAnimated:YES completion:nil] ;
}
-(void)usePhotoAsAvator
{
    /*
    biz = "\U851a\U84dd\U6d77\U5cb8\U5a5a\U7eb1\U6444\U5f71";
    "biz_id" = 33;
    "biz_url" = "/HunShaSheYing/WeiLanHaiAn-Info";
    cover = "http://iq.dxlfile.com/mall/840x1000/2015-03/1a9956ecdc78203d31682385de383bd6.jpg?";
    hasLiked = 0;
    id = 207;
    "img_url" = "2015-03/1a9956ecdc78203d31682385de383bd6.jpg";
    liked = 179;
    name = "\U77ed\U53d1\U7f8e\U65b0\U5a18";
    "photo_count" = 10;
    url = "/HunShaSheYing/WeiLanHaiAn-Picture-207";
    viewed = 244;
    
    --------------------------------------------------------------------------------------------
    /// 官照  可以显示的
    biz = "\U851a\U84dd\U6d77\U5cb8\U5a5a\U7eb1\U6444\U5f71";
    "biz_id" = 33;
    "biz_url" = "/HunShaSheYing/WeiLanHaiAn-Info";
    cover = "http://iq.dxlfile.com/mall/840x1000/2014-11/20141126114414925.jpg?";
    hasLiked = 1;
    id = 2279;
    "img_url" = "2014-11/20141126114414925.jpg";
    liked = 484;
    name = "\U590f\U5a01\U5937\U7247\U573a";
    "photo_count" = 117;
    url = "/HunShaSheYing/WeiLanHaiAn-Photo-2279";
    viewed = 3229;          */
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
