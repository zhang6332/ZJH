//
//  ZJHBaseController.h
//  ancientMap
//
//  Created by Apple on 2017/5/2.
//  Copyright © 2017年 张家浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJHBaseController : UIViewController
@property (nonatomic ,strong) UIImageView * imageViewBar;
//返回上级控制器
- (void)back;
//跳转登录页
- (void)jumpLoginVC;

@end
