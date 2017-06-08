//
//  ShowPictureController.m
//  ZJHCustomCamera
//
//  Created by wangruihao on 16/12/4.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ShowPictureController.h"

@interface ShowPictureController ()

@end

@implementation ShowPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self addImageViewAndButton];

}

- (void)addImageViewAndButton {
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 60)];
    imageView.image = self.image;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(30, self.view.frame.size.height - 50, 100, 40)];
    [button setTitle:@"重新拍照" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton * button1 = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 130, button.frame.origin.y, button.frame.size.width, button.frame.size.height)];
    [button1 setTitle:@"使用照片" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(usePicture:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
}

- (void)takePhoto:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)usePicture:(UIButton *)button {
    [self dismissViewControllerAnimated:NO completion:^{
        self.backImage(self.image,@"usePicture");
    }];

}

- (void)addItem:(void(^)(UIImage * image,NSString * backString))backImage {
    self.backImage = backImage;
}

@end





