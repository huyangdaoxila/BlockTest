//
//  ImageScanVC.m
//  BlockTest
//
//  Created by huyang on 15/4/3.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "ImageScanVC.h"
#import "ImageScanCell.h"
#import <MBProgressHUD.h>
#import <UIColor+Expanded.h>

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
static NSString *const identifier = @"collectionViewCell";
@interface ImageScanVC ()
//<UICollectionViewDataSource,UICollectionViewDelegate>

@property(strong,nonatomic)UILabel *numLabel ;
@property(strong,nonatomic)UILabel *quitLabel ;
@property(strong,nonatomic)UIImageView *mainView ;
@property(strong,nonatomic)UICollectionView *collectionView ;
@property(strong,nonatomic)MBProgressHUD *rightHUD ;
@property(strong,nonatomic)MBProgressHUD *leftHUD ;

@end

@implementation ImageScanVC

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor] ;
    [self initSubviewUI];
    
    _mainView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    NSString *imageUrl = _imagePaths[_currentIndex] ;
    [_mainView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"16.JPG"]];
    _mainView.userInteractionEnabled = YES ;
    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToRight)];
    left.direction = UISwipeGestureRecognizerDirectionLeft ;
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToLeft)];
    right.direction = UISwipeGestureRecognizerDirectionRight ;
    [_mainView addGestureRecognizer:left] ;
    [_mainView addGestureRecognizer:right] ;
    [self.view addSubview:_mainView];
}
#pragma mark  -----  Swipe Gesture Methods
-(void)swipeToLeft
{
    if (_currentIndex > 0) {
        _currentIndex-- ;
        _numLabel.text = [NSString stringWithFormat:@"%d/%d",(int)_currentIndex+1,(int)_imagePaths.count] ;
        NSString *imageUrl = _imagePaths[_currentIndex] ;
        [_mainView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"16.JPG"]];
    }
    else{
        _leftHUD = [MBProgressHUD showHUDAddedTo:_mainView animated:YES] ;
        _leftHUD.mode = MBProgressHUDModeText ;
        _leftHUD.labelFont = [UIFont systemFontOfSize:18] ;
        _leftHUD.labelText = @"不能继续向左滑动了!" ;
        _leftHUD.labelColor = [UIColor colorWithHexString:@"#ff608e"] ;
        _leftHUD.color = [UIColor whiteColor];
        _leftHUD.margin = 5.f ; // 设置label 圆角
        [_leftHUD hide:YES afterDelay:1];
    }
}
-(void)swipeToRight
{
    if (_currentIndex < _imagePaths.count - 1) {
        _currentIndex++ ;
        _numLabel.text = [NSString stringWithFormat:@"%d/%d",(int)_currentIndex+1,(int)_imagePaths.count] ;
        NSString *imageUrl = _imagePaths[_currentIndex] ;
        [_mainView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"16.JPG"]];
//        [UIView animateKeyframesWithDuration:1.2 delay:0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
//            [_mainView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"16.JPG"]];
//        } completion:nil] ;
        
    }
    else{
        _rightHUD = [MBProgressHUD showHUDAddedTo:_mainView animated:YES] ;
        _rightHUD.mode = MBProgressHUDModeText ;
        _rightHUD.labelFont = [UIFont systemFontOfSize:18] ;
        _rightHUD.labelText = @"不能继续向左滑动了!" ;
        _rightHUD.labelColor = [UIColor colorWithHexString:@"#ff608e"] ;
        _rightHUD.color = [UIColor whiteColor];
        _rightHUD.margin = 5.f ;
        [_rightHUD hide:YES afterDelay:1];
    }
}
#pragma mark  -----  初始化子视图UI
-(void)initSubviewUI
{
    _numLabel = [[UILabel alloc] init];
    _numLabel.frame = CGRectMake(0, 20, 50, 44) ;
    _numLabel.textColor = [UIColor whiteColor];
    _numLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.15] ;
    _numLabel.text = [NSString stringWithFormat:@"%d/%d",(int)_currentIndex+1,(int)_imagePaths.count] ;
    [self.view addSubview:_numLabel] ;
    
    _quitLabel = [[UILabel alloc] init] ;
    _quitLabel.frame = CGRectMake(ScreenWidth-40, 20, 40, 44) ;
    _quitLabel.textColor = [UIColor whiteColor];
    _quitLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.15] ;
    _quitLabel.text = @"取消" ;
    _quitLabel.userInteractionEnabled = YES ;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressToQuit)];
    [_quitLabel addGestureRecognizer:tap];
    [self.view addSubview:_quitLabel] ;
}
#pragma mark  -----  退出当前视图
-(void)pressToQuit
{
    [self dismissViewControllerAnimated:YES completion:nil] ;
}



@end
