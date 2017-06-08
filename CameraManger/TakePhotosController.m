//
//  TakePhotosController.m
//  ZJHCustomCamera
//
//  Created by wangruihao on 16/12/4.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "TakePhotosController.h"
#import "ShowPictureController.h"
#import "CCCameraManger.h"
@interface TakePhotosController ()
@property (nonatomic,strong) UIView * preView;
@property (nonatomic,strong) UIButton * takePhotoBtn;
@property (nonatomic,strong) UIButton * cancleButton;
@property (nonatomic,strong) UIButton * transformBtn;

@property (nonatomic,strong) CCCameraManger * manager;
@end

@implementation TakePhotosController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self addItems];

}

- (void)viewWillAppear:(BOOL)animated {
    
    //iOS 判断应用是否有使用相机的权限
    
    NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        NSString *errorStr = @"应用相机权限受限,请在设置中启用";
        NSLog(@"%@",errorStr);
    }else {
        [self.manager startUp];
    }
}

- (void)addItems {
    self.preView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 - 100)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, self.preView.frame.size.width - 20, self.preView.frame.size.height - 40)];
    imageView.image = self.image;
    [self.preView addSubview:imageView];
    [self.view addSubview:self.preView];
    
    self.cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.preView.frame) + 30, 100, 55)];
    [self.cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.cancleButton addTarget:self action:@selector(cancleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancleButton];
    
    self.takePhotoBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.cancleButton.frame.origin.y, self.cancleButton.frame.size.width, 70)];
    self.takePhotoBtn.center = CGPointMake(self.view.center.x, self.takePhotoBtn.center.y);
    [self.takePhotoBtn setImage:[UIImage imageNamed:@"paizhaoanniu"] forState:UIControlStateNormal];
    [self.takePhotoBtn addTarget:self action:@selector(takePhotoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.takePhotoBtn];
    
    self.transformBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 120, self.cancleButton.frame.origin.y, self.cancleButton.frame.size.width, self.cancleButton.frame.size.height)];
    [self.transformBtn setImage:[UIImage imageNamed:@"jingtouzhuanhuan"] forState:UIControlStateNormal];
    [self.transformBtn addTarget:self action:@selector(transformBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.transformBtn];
    
    
    
}

- (void)cancleButtonClicked:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)takePhotoBtnClicked:(UIButton *)button {
    
    [self.manager takePhotoWithImageBlock:^(UIImage *originImage, UIImage *scaledImage, UIImage *croppedImage) {
        ShowPictureController * showVC = [[ShowPictureController alloc]init];
        showVC.image = croppedImage;
        [showVC addItem:^(UIImage *image, NSString *backString) {
            
            if ([backString isEqualToString:@"usePicture"]) {
                [self dismissViewControllerAnimated:NO completion:nil];
                self.backImage(image);
            }
        }];
         [self presentViewController:showVC animated:YES completion:nil];
    }];

}
- (void)transformBtnClicked:(UIButton *)button {
    self.transformBtn.selected = !self.transformBtn.selected;
    [self.manager changeCameraInputDeviceisFront:self.transformBtn.selected];
}

- (CCCameraManger *)manager {
    if (_manager == nil) {
        _manager = [[CCCameraManger alloc]initWithParentView:self.preView];
        _manager.faceRecognition = YES;
    }
    return _manager;
}

- (void)addItem:(void(^)(UIImage * image))backImage {
    self.backImage = backImage;
}

@end







