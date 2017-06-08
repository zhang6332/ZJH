
#import <QuartzCore/QuartzCore.h>

@interface CALayer (Anim)

//摇动
-(void)shake;

//获取当前视图控制器
+ (UIViewController *)getCurrentController;

//判断当前控制器是否是被push来的还是present来的或者是根控制器
+ (NSNumber *)controllerIsPushedBySuper:(UIViewController *)controller;


@end
