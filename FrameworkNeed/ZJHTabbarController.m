//
//  ZJHTabbarController.m
//  ancientMap
//
//  Created by Apple on 2017/5/2.
//  Copyright © 2017年 张家浩. All rights reserved.
//

#import "ZJHTabbarController.h"
#import "ZJHNavigationController.h"
@interface ZJHTabbarController ()
/** 名字 */
@property (nonatomic ,strong) NSMutableArray * titleArray;

@end

@implementation ZJHTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加子视图控制器
    [self setupViewControllers];
    // 定制tabbar items
    [self setupTabbarItems];
}

- (void)setupViewControllers {
    
    NSMutableArray * viewControllers = [[NSMutableArray alloc]init];
    NSArray * controllerNames = @[@"ZCFirstController",@"ZCSecondController",@"ZCThirdController"];
    
    for (int i = 0;i < self.titleArray.count;i++) {
        if (i == 0) {
            UIStoryboard * mainStroyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController * vc = [mainStroyBoard instantiateInitialViewController];
            //vc.title = self.titleArray[i];
            ZJHNavigationController * nav = [[ZJHNavigationController alloc]initWithRootViewController:vc];
            [viewControllers addObject:nav];
        }else {
            Class class = NSClassFromString(controllerNames[i]);
            UIViewController * vc = [[class alloc]init];
            //vc.title = self.titleArray[i];
            ZJHNavigationController * nav = [[ZJHNavigationController alloc]initWithRootViewController:vc];
            [viewControllers addObject:nav];
        }
    }
    self.viewControllers = viewControllers;
}

- (void)setupTabbarItems {
    NSArray * normalImages = @[@"tuceng", @"xiangji", @"wode"];
    NSArray * selectImages = @[@"tuceng2", @"xiangji2", @"wode2"];
    NSArray * viewControllers = self.viewControllers;
    for (int i = 0; i < self.titleArray.count; i++) {
        UITabBarItem * item = [[UITabBarItem alloc]initWithTitle:self.titleArray[i] image:[[UIImage imageNamed:normalImages[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectImages[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        //调整字体
//        [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:13]} forState:UIControlStateNormal];
//        [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.96f green:0.81f blue:0.33f alpha:1.00f],NSFontAttributeName:[UIFont boldSystemFontOfSize:13]} forState:UIControlStateSelected];
        [viewControllers[i] setTabBarItem:item];
    }
}

/**懒加载*/
- (NSMutableArray *)titleArray {

    if (_titleArray == nil) {
        _titleArray = [[NSMutableArray alloc]initWithArray:@[@"图层", @"拍照", @"我的"]];
    }
    return _titleArray;
}


@end
