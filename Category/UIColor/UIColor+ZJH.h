//
//  UIColor+ZJH.h
//  ancientMap
//
//  Created by Apple on 2017/3/21.
//  Copyright © 2017年 张家浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZJH)

//十六进制颜色转换成可用颜色
+ (UIColor *)stringTOColor:(NSString *)str;

//根据颜色生成图片
+ (UIImage *)imageWithColor:(UIColor *)color;

//获取canvas用的颜色字符串
- (NSString *)canvasColorString;

//获取网页颜色字串
- (NSString *)webColorString;

//获取RGB值
- (CGFloat *)getRGB;

//让颜色更亮
- (UIColor *)lighten;

//让颜色更暗
- (UIColor *)darken;

//取两个颜色的中间
- (UIColor *)mix: (UIColor *) color;

@end
