//
//  TakePhotosController.h
//  ZJHCustomCamera
//
//  Created by wangruihao on 16/12/4.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TakePhotosController : UIViewController
@property (nonatomic,strong) UIImage * image;
@property (nonatomic,copy) void(^backImage)(UIImage * image);
- (void)addItem:(void(^)(UIImage * image))backImage;
@end
