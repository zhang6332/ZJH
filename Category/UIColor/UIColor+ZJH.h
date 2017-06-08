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


@end
