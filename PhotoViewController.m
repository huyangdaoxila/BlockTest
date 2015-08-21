//
//  PhotoViewController.m
//  BlockTest
//
//  Created by huyang on 15/4/2.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "PhotoViewController.h"
#import "CustomImagePicker.h"
#import <Masonry.h>
#import "CameraPushedVC.h"
#import <MBProgressHUD.h>
#import "EditImageVC.h"

@interface PhotoViewController ()<UIActionSheetDelegate,UIGestureRecognizerDelegate>

@property(strong,nonatomic)UIActionSheet *actionSheet ;
@property(strong,nonatomic)UIImageView   *showImage   ; // 从相册选取的图片
@property(strong,nonatomic)UIImageView   *cameraAvatar; // 相机拍的照片
@property(strong,nonatomic)MBProgressHUD *hud ;

@end

@implementation PhotoViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"IPC" ;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showAction)];
//    self.navigationItem.rightBarButtonItem = right ;
    UIBarButtonItem *picture = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(pressEditVC)];
    NSArray *arr = @[right,picture];
    self.navigationItem.rightBarButtonItems = arr ;
    
    _showImage = [[UIImageView alloc] init];
    _showImage.backgroundColor = [UIColor orangeColor];
    _showImage.frame = CGRectMake(60, 80, 200, 200);
    _showImage.layer.masksToBounds = YES ;
    _showImage.layer.cornerRadius = 100.f ;
    _showImage.userInteractionEnabled = YES ;
    _showImage.contentMode = UIViewContentModeScaleAspectFit ;
    [self.view addSubview:_showImage];
//    UIPanGestureRecognizer* panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
//    panGestureRecognizer.delegate = self;
//    [_showImage addGestureRecognizer:panGestureRecognizer];
//    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
//    pinchGesture.delegate = self;
//    [_showImage addGestureRecognizer:pinchGesture];
//    UIRotationGestureRecognizer* rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
//    rotationGestureRecognizer.delegate = self;
//    [_showImage addGestureRecognizer:rotationGestureRecognizer];
//


    _cameraAvatar = [[UIImageView alloc] init];
    _cameraAvatar.backgroundColor = [UIColor orangeColor];
    _cameraAvatar.frame = CGRectMake(60, 300, 200, 200);
    _cameraAvatar.layer.masksToBounds = YES ;
    _cameraAvatar.layer.cornerRadius = 100.f ;
    _cameraAvatar.userInteractionEnabled = YES ;
    _cameraAvatar.contentMode = UIViewContentModeScaleAspectFit ;
    [self.view addSubview:_cameraAvatar];
}
#pragma mark --- showAction method

-(void)pressEditVC
{
    EditImageVC *edit = [[EditImageVC alloc] init] ;
    [self.navigationController pushViewController:edit animated:YES] ;
}
-(void)showAction
{
    _actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍  照",@"从相册中选择", nil] ;
    _actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic ;
    [_actionSheet showInView:self.view] ;
}
#pragma mark --- actionSheet delegate method
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    _ipc = [[UIImagePickerController alloc] init];
    if(buttonIndex == 0)        // 拍照
    {
        _ipc.sourceType = UIImagePickerControllerSourceTypeCamera ;
        [_ipc setVideoQuality:UIImagePickerControllerQualityTypeHigh] ;
        _ipc.delegate = self ;
        _ipc.allowsEditing = YES ;
        _ipc.showsCameraControls = YES ;
//        UIToolbar* tool = [[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-55, self.view.frame.size.width, 55)];
//        tool.barStyle = UIBarStyleBlackTranslucent;
//        UIBarButtonItem* cancel = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelCamera)];
//        UIBarButtonItem* flexable = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//        UIBarButtonItem* select = [[UIBarButtonItem alloc]initWithTitle:@"选取" style:UIBarButtonItemStylePlain target:self action:@selector(savePhoto)];
//        UIBarButtonItem* takePhoto = [[UIBarButtonItem alloc]initWithTitle:@"拍照" style:UIBarButtonItemStylePlain target:self action:@selector(takePhoto)];
//        [tool setItems:[NSArray arrayWithObjects:cancel,flexable,takePhoto,flexable,select, nil]];
//        //把自定义的view设置到imagepickercontroller的overlay属性中
//        _ipc.cameraOverlayView = tool;
        [self presentViewController:_ipc animated:YES completion:nil] ;
    }
    else if(buttonIndex == 1)  // 从相册获取
    {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            _ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum ;
            _ipc.delegate = self ;
            _ipc.allowsEditing = YES ;
            [self presentViewController:_ipc animated:YES completion:nil] ;
        }
    }
}
-(void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    [actionSheet dismissWithClickedButtonIndex:2 animated:YES];
}
#pragma mark - custom method
-(void)cancelCamera
{
    [_ipc dismissViewControllerAnimated:YES completion:nil];
}
-(void)savePhoto
{
}
-(void)takePhoto
{
    [_ipc takePicture];
}

#pragma mark - UIImagePickerController delegate method
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"用户正在选取图片");
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) //拍摄的招片
    {
        //获取照片的原图
//        UIImage *original = [info objectForKey:UIImagePickerControllerOriginalImage] ;
        // 编辑过的图片
        UIImage *edit = [info objectForKey:UIImagePickerControllerEditedImage];
        _showImage.image = edit ;
        [_ipc dismissViewControllerAnimated:YES completion:nil] ;
        [self showHUDWithTitle:@"  修改头像成功  "];
    }
    else if (picker.sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum) //从相册选取图片
    {
        // 原图
//        UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
        // 编辑过的图片
        UIImage *edit = [info objectForKey:UIImagePickerControllerEditedImage];
        _cameraAvatar.image = edit ;
        [_ipc dismissViewControllerAnimated:YES completion:nil];
        [self showHUDWithTitle:@"  修改头像成功  "];
    }
}
#pragma mark --  showHUD method 
-(void)showHUDWithTitle:(NSString*)title
{
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.color = [UIColor cyanColor];
    _hud.mode = MBProgressHUDModeText;
    _hud.labelFont = [UIFont systemFontOfSize:18] ;
    _hud.labelText = title;
    _hud.labelColor = [UIColor purpleColor] ;
    _hud.margin = 5.f;
    _hud.removeFromSuperViewOnHide = YES;
    [_hud hide:YES afterDelay:1];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"用户取消选取图片操作");
    [_ipc dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Geature Action Method
-(void)handlePan:(UIPanGestureRecognizer*)gestureRecognizer
{
    CGAffineTransform transform = _showImage.transform;
    CGPoint point = [gestureRecognizer translationInView:_showImage];
    transform = CGAffineTransformTranslate(transform, point.x, point.y);
    _showImage.transform = transform;
    [gestureRecognizer setTranslation:CGPointZero inView:gestureRecognizer.view];
}

-(void)handlePinch:(UIPinchGestureRecognizer*)gestureRecognizer
{
    _showImage.transform = CGAffineTransformScale(_showImage.transform, gestureRecognizer.scale, gestureRecognizer.scale);
    gestureRecognizer.scale = 1;
}

-(void)handleRotation:(UIRotationGestureRecognizer*)gestureRecognizer
{
    CGFloat rotation = gestureRecognizer.rotation;
    CGAffineTransform transform = CGAffineTransformRotate(_showImage.transform, rotation);
    _showImage.transform = transform;
    gestureRecognizer.rotation = 0.0f;
}


@end
