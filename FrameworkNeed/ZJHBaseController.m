//
//  ZJHBaseController.m
//  ancientMap
//
//  Created by Apple on 2017/5/2.
//  Copyright © 2017年 张家浩. All rights reserved.
//

#import "ZJHBaseController.h"
#import "ZJHSignInController.h"
#define BACKIMAGE @"back"
@interface ZJHBaseController ()


@end

@implementation ZJHBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    //返回键
    [self setBackItem];
    //导航栏透明设置
    [self setNaVationBar];
}

- (void)setBackItem {
    
    switch ([[CALayer controllerIsPushedBySuper:self] intValue]) {
        case 0:
        {
            UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 30, 30)];
            [button setImage:[UIImage imageNamed:BACKIMAGE] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
            //所有主线程任务执行完执行
            NSBlockOperation * back = [NSBlockOperation blockOperationWithBlock:^{
                dispatch_async(dispatch_queue_create("backThread", DISPATCH_QUEUE_SERIAL), ^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.view addSubview:button];
                    });
                });
            }];
            [[NSOperationQueue mainQueue] addOperation:back];
        }
            break;
        case 1:
        {
            UIBarButtonItem * left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:BACKIMAGE] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
            self.navigationItem.leftBarButtonItem = left;
        }
            break;
            
        default:
            break;
    }
}
- (void)back {
    if (!self.navigationController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setNaVationBar {
    self.view.backgroundColor = [UIColor whiteColor];
    //透明导航条
    self.imageViewBar = self.navigationController.navigationBar.subviews.firstObject;
    //self.imageViewBar.alpha = 0;
}

- (void)viewWillAppear:(BOOL)animated {
    //不隐藏导航条
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [super viewWillAppear:animated];
}

//跳转登录页
- (void)jumpLoginVC {
    ZJHSignInController * signInVC = [[ZJHSignInController alloc]init];
    signInVC.hidesBottomBarWhenPushed = YES;
    if (self.navigationController) {
        [self.navigationController pushViewController:signInVC animated:YES];
    }else {
        [self presentViewController:signInVC animated:YES completion:nil];
    }
}

@end
