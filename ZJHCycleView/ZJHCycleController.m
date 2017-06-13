//
//  ZJHCycleController.m
//  ancientMap
//
//  Created by Apple on 2017/6/6.
//  Copyright © 2017年 张家浩. All rights reserved.
//

#import "ZJHCycleController.h"
#import "ZJHCycleView.h"
#import "ZJHTabbarController.h"
#import "AppDelegate.h"

@interface ZJHCycleController ()<ZJHCycleViewDelegate>

@end

@implementation ZJHCycleController

//使用
//NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//if ([user objectForKey:@"UseTimes"] == nil) {
//    Class class = NSClassFromString(@"ZJHCycleController");
//    UIViewController * CycleVC = [[class alloc]init];
//    _window.rootViewController = CycleVC;
//    [user setObject:@"NotFirstUse" forKey:@"UseTimes"];
//}else {
//    
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    //添加子视图
    [self addSubViews];
}

- (void)addSubViews {
    ZJHCycleView * cycleView = [[ZJHCycleView alloc]initWithFrame:self.view.bounds delegate:self imageUrlArray:nil placeholderImageName:nil orLocalImageNameArray:@[@"welcome_frist.jpg",@"welcome_second.jpg",@"welcome_third.jpg"] andImageTitles:nil autoScroll:NO];
    [cycleView setCycleViewReapeatAlways:NO];
    [self.view addSubview:cycleView];
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.width - 65, 30, 60, 30)];
    [button setTitle:@"跳过" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(jumpButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)jumpButtonClicked:(UIButton *)button {
    // 最后一页，切换window根视图
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    ZJHTabbarController * tab = [[ZJHTabbarController alloc] init];
    delegate.window.rootViewController = tab;
    [delegate.window reloadInputViews];
}

- (void)ZJHCycleViewDelegateCollectionView:(UICollectionView *)collectionView didScrollItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self jumpButtonClicked:nil];
        });
    }
}



@end
