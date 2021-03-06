//
//  UIView+ZJH.m
//  ancientMap
//
//  Created by Apple on 2017/3/21.
//  Copyright © 2017年 张家浩. All rights reserved.
//

#import "UIView+ZJH.h"
#import <objc/runtime.h>
@implementation UIView (ZJH)

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (UIView * (^)(CGFloat x))setX {
    return ^(CGFloat x) {
        self.x = x;
        return self;
    };
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


- (UIView *(^)(UIColor *color))setColor {
    return ^ (UIColor *color) {
        self.backgroundColor = color;
        return self;
    };
}

- (UIView *(^)(CGRect frame))setFrame {
    return ^ (CGRect frame) {
        self.frame = frame;
        return self;
    };
}

- (UIView *(^)(CGSize size))setSize {
    return ^ (CGSize size) {
        self.bounds = CGRectMake(0, 0, size.width, size.height);
        return self;
    };
}

- (UIView *(^)(CGPoint point))setCenter {
    return ^ (CGPoint point) {
        self.center = point;
        return self;
    };
}

- (UIView *(^)(NSInteger tag))setTag {
    return ^ (NSInteger tag) {
        self.tag = tag;
        return self;
    };
}

- (void)addTarget:(id)target action:(SEL)action {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

+ (void)showAlertWithTitle: (NSString *)title message: (NSString *)message actionTitles: (NSArray<NSString *> *)actions cancelTitle: (NSString *)cancelTitle style: (UIAlertControllerStyle)style completion: (void(^)(NSInteger index))completion {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    for (NSInteger index = 0; index < actions.count; index++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:actions[index] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            !completion ?  : completion(index);
        }];
        [alert addAction:action];
    }
    if (cancelTitle.length) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancel];
    }
    UIViewController *vc = [CALayer getCurrentController];
    [vc presentViewController:alert animated:YES completion:nil];
}

- (void)addBorderColor:(UIColor *)color {
    [self.layer setBorderColor:color.CGColor];
    [self.layer setBorderWidth:0.5];
    [self.layer setCornerRadius:4];
}


#pragma mark - 圆角
- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGSize)size {
    UIBezierPath* maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:size];
    CAShapeLayer* maskLayer = [CAShapeLayer new];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

#pragma mark - 以递归的方式遍历(查找)subview
- (UIView*)findViewRecursively:(BOOL(^)(UIView* subview, BOOL* stop))recurse {
    for( UIView* subview in self.subviews ) {
        BOOL stop = NO;
        if(recurse(subview, &stop)) {
            return [subview findViewRecursively:recurse];
        } else if( stop ) {
            return subview;
        }
    }
    return nil;
}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

//添加属性
static char parameter = 'a';
- (NSMutableString *)parameterStr {
    return objc_getAssociatedObject(self, &parameter);
}
- (void)setParameterStr:(NSMutableString *)parameterStr {
    objc_setAssociatedObject(self, &parameter, parameterStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

static char idPar = 'a';
- (id)parameterId {
    return objc_getAssociatedObject(self, &idPar);
}
- (void)setParameterId:(id)idParameter {
    objc_setAssociatedObject(self, &idPar, idParameter, OBJC_ASSOCIATION_COPY_NONATOMIC);
}










@end
