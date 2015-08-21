//
//  EditImageVC.m
//  BlockTest
//
//  Created by huyang on 15/4/9.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "EditImageVC.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface EditImageVC ()<UIGestureRecognizerDelegate,
                          UIImagePickerControllerDelegate,
                          UINavigationControllerDelegate>

@property(strong,nonatomic)UIImageView *originalImage ;
@property(strong,nonatomic)UIImageView *cropImage     ;
@property(strong,nonatomic)UIImageView *topLine       ;
@property(strong,nonatomic)UIImageView *bottomLine    ;
@property(strong,nonatomic)UIImageView *leftLine      ;
@property(strong,nonatomic)UIImageView *rightLine     ;
@end

@implementation EditImageVC

#pragma mark -----  viewController lifecycle
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"图片裁剪" ;
    
    UIBarButtonItem *crop = [[UIBarButtonItem alloc] initWithTitle:@"裁剪" style:UIBarButtonItemStylePlain target:self action:@selector(editImage)];
    
    UIBarButtonItem *choose = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(chooseImage)];
    NSArray *array = @[crop,choose];
    self.navigationItem.rightBarButtonItems = array ;
    
    [self initOriginalImage];
//    [self initCropRect];
    
    [self chooseImage];
}

#pragma mark  === init subview UI
-(void)initCropRect
{
    _topLine = [[UIImageView alloc] init];
    _topLine.frame = CGRectMake(0, (ScreenHeight-ScreenWidth)/2.f, ScreenWidth, 1.f);
    _topLine.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _topLine.layer.borderWidth = 0.5f;
    [self.view addSubview:_topLine];
    _bottomLine = [[UIImageView alloc] init];
    _bottomLine.frame = CGRectMake(0, (ScreenHeight-ScreenWidth)/2.f+ScreenWidth, ScreenWidth, 1.f);
    _bottomLine.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _bottomLine.layer.borderWidth = 0.5f;
    [self.view addSubview:_bottomLine];
    _leftLine = [[UIImageView alloc] init];
    _leftLine.frame = CGRectMake(0, (ScreenHeight-ScreenWidth)/2.f, 1.f, ScreenWidth);
    _leftLine.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _leftLine.layer.borderWidth = 0.5f;
    [self.view addSubview:_leftLine];
    _rightLine = [[UIImageView alloc] init];
    _rightLine.frame = CGRectMake(ScreenWidth-1.f, (ScreenHeight-ScreenWidth)/2.f, 1.f, ScreenWidth);
    _rightLine.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _rightLine.layer.borderWidth = 0.5f;
    [self.view addSubview:_rightLine];
}
-(void)initOriginalImage
{
    _originalImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    _originalImage.image = [UIImage imageNamed:@"16.JPG"];
    _originalImage.userInteractionEnabled = YES;
    UIPanGestureRecognizer* panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panGestureRecognizer.delegate = self;
    [_originalImage addGestureRecognizer:panGestureRecognizer];
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    pinchGesture.delegate = self;
    [_originalImage addGestureRecognizer:pinchGesture];
//    UIRotationGestureRecognizer* rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
//    rotationGestureRecognizer.delegate = self;     
//    [_originalImage addGestureRecognizer:rotationGestureRecognizer];
    
    [self.view addSubview:_originalImage];
}

#pragma mark -----  navigationItem methods
-(void)editImage
{
    CGRect rect = CGRectMake(1, (ScreenHeight-ScreenWidth)/2.f+1.f, ScreenWidth-2.f, ScreenWidth-2.f);
    UIImage *img = [self shotsInRect:rect];
    _cropImage = [[UIImageView alloc] init];
    _cropImage.frame = CGRectMake((ScreenWidth-200)/2.f, 200, 200, 200);
    _cropImage.image = img ;
    [self.view addSubview:_cropImage];
    
    _originalImage.hidden = YES ;
    _topLine.hidden = YES ;
    _bottomLine.hidden = YES ;
    _leftLine.hidden = YES ;
    _rightLine.hidden = YES ;

}

-(void)chooseImage
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum ;
        ipc.delegate = self ;
        ipc.allowsEditing = YES ;
        [self presentViewController:ipc animated:YES completion:nil] ;
    }
}
#pragma mark - UIImagePickerController delegate method
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (picker.sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum) //从相册选取图片
    {
        // 原图
        //        UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
        // 编辑过的图片
        UIImage *edit = [info objectForKey:UIImagePickerControllerEditedImage];
        _originalImage.image = edit ;
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        [self initCropRect];
    }
}
#pragma mark - Geature Action Method
-(void)handlePan:(UIPanGestureRecognizer*)gestureRecognizer
{
    CGAffineTransform transform = _originalImage.transform;
    CGPoint point = [gestureRecognizer translationInView:_originalImage];
    transform = CGAffineTransformTranslate(transform, point.x, point.y);
    _originalImage.transform = transform;
    [gestureRecognizer setTranslation:CGPointZero inView:gestureRecognizer.view];
}

-(void)handlePinch:(UIPinchGestureRecognizer*)gestureRecognizer
{
    _originalImage.transform = CGAffineTransformScale(_originalImage.transform, gestureRecognizer.scale, gestureRecognizer.scale);
    gestureRecognizer.scale = 1;
}

-(void)handleRotation:(UIRotationGestureRecognizer*)gestureRecognizer
{
    CGFloat rotation = gestureRecognizer.rotation;
    CGAffineTransform transform = CGAffineTransformRotate(_originalImage.transform, rotation);
    _originalImage.transform = transform;
    gestureRecognizer.rotation = 0.0f;
}



#pragma mark -----  截取图片

//全屏截取图片
- (UIImage *)shotsFull
{
    UIGraphicsBeginImageContext(self.view.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
//根据矩形框截取图片
- (UIImage *)shotsInRect:(CGRect)rect
{
    UIImage *newImage = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([self shotsFull].CGImage, rect)];
    return newImage;
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
