
#import "CALayer+Anim.h"

@implementation CALayer (Anim)


//摇动
-(void)shake{
    
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    
    CGFloat s = 5;
    
    kfa.values = @[@(-s),@(0),@(s),@(0),@(-s),@(0),@(s),@(0)];
    
    //时长
    kfa.duration = 0.3f;
    
    //重复
    kfa.repeatCount = 2;
    
    //移除
    kfa.removedOnCompletion = YES;
    
    [self addAnimation:kfa forKey:@"shake"];
}

//获取当前视图控制器
+ (UIViewController *)getCurrentController {
    
    UIViewController * result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    id nextResponder = nil;
    UIViewController * appRootVC = window.rootViewController;
    //如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else {
        UIView * frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    if ([nextResponder isKindOfClass:[UITabBarController class]]) {
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]) {
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else if ([nextResponder isKindOfClass:[UIWindow class]]) {
        //当软件从后台再次唤醒且退入后台时是在根视图控制器时响应者是window(多次获取时出现)
        result = [UIApplication sharedApplication].delegate.window.rootViewController;
    }else{
        result = nextResponder;
    }
    return result;
}

//判断当前控制器是否是被push来的还是present来的或者是根控制器
+ (NSNumber *)controllerIsPushedBySuper:(UIViewController *)controller {

    if (!controller.navigationController) {
        if ([controller isEqual:[UIApplication sharedApplication].delegate.window.rootViewController]) {
            //根控制器
            return @(-1);
        }else {
            //present来的
            return @0;
        }
    }else {
        if (controller.navigationController.viewControllers.count == 1) {
            //根控制器
            return @(-1);
        }else {
            //push来的
            return @1;
        }
    }
}

@end
