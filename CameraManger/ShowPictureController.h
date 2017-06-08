//
//  ShowPictureController.h
//  ZJHCustomCamera
//
//  Created by wangruihao on 16/12/4.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowPictureController : UIViewController
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,copy) void(^backImage)(UIImage * image,NSString * backString);

- (void)addItem:(void(^)(UIImage * image,NSString * backString))backImage;


@end
