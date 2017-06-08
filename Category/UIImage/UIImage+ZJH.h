//
//  UIImage+ZJH.h
//  AppleDevelop
//
//  Created by Apple on 2017/5/26.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZJH)
/** 字符串 */
@property (nonatomic ,copy) NSMutableString * parameterStr;
//id参数
@property (nonatomic ,strong) id parameterId;

//根据图片名返回一张相应比例的图片
+ (UIImage *)resizedImage:(NSString *)name withWidth:(NSNumber *)widthScale andHeight:(NSNumber *)heightScale;

//图片旋转
- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees;


@end
