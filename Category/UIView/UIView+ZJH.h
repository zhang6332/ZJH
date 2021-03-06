//
//  UIView+ZJH.h
//  ancientMap
//
//  Created by Apple on 2017/3/21.
//  Copyright © 2017年 张家浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZJH)

/**
 *  1.间隔X值
 */
@property (nonatomic, assign) CGFloat x;

/**
 *  2.间隔Y值
 */
@property (nonatomic, assign) CGFloat y;

/**
 *  3.宽度
 */
@property (nonatomic, assign) CGFloat width;

/**
 *  4.高度
 */
@property (nonatomic, assign) CGFloat height;

/**
 *  5.中心点X值
 */
@property (nonatomic, assign) CGFloat centerX;

/**
 *  6.中心点Y值
 */
@property (nonatomic, assign) CGFloat centerY;

/**
 *  7.尺寸大小
 */
@property (nonatomic, assign) CGSize size;

/**
 *  8.起始点
 */
@property (nonatomic, assign) CGPoint origin;

/**
 *  9.上 < Shortcut for frame.origin.y
 */
@property (nonatomic) CGFloat top;

/**
 *  10.下 < Shortcut for frame.origin.y + frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 *  11.左 < Shortcut for frame.origin.x.
 */
@property (nonatomic) CGFloat left;

/**12.右 < Shortcut for frame.origin.x + frame.size.width*/
@property (nonatomic) CGFloat right;

/**
 *  1.添加边框
 *  @param color color description
 */
- (void)addBorderColor:(UIColor *)color;

/**
 *  2.UIView 的点击事件
 *  @param target   目标
 *  @param action   事件
 */
- (void)addTarget:(id)target action:(SEL)action;

/**
 快速创建AlertController：包括Alert 和 ActionSheet
 @param title       标题文字
 @param message     消息体文字
 @param actions     可选择点击的按钮（不包括取消）
 @param cancelTitle 取消按钮（可自定义按钮文字）
 @param style       类型：Alert 或者 ActionSheet
 @param completion  完成点击按钮之后的回调（不包括取消）
 */
+ (void)showAlertWithTitle: (NSString *)title message: (NSString *)message actionTitles: (NSArray<NSString *> *)actions cancelTitle: (NSString *)cancelTitle style: (UIAlertControllerStyle)style completion: (void(^)(NSInteger index))completion;

#pragma mark - 圆角
- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGSize)size;

#pragma mark - 以递归的方式遍历(查找)subview
- (UIView*)findViewRecursively:(BOOL(^)(UIView* subview, BOOL* stop))recurse;

/**
 寻找当前view所在的主视图控制器
 @return 返回当前主视图控制器
 */
- (UIViewController *)viewController;

/** 字符串 */
@property (nonatomic ,copy) NSMutableString * parameterStr;
//id参数
@property (nonatomic ,strong) id parameterId;

@end
