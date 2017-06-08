//
//  UIImage+ZJH.m
//  AppleDevelop
//
//  Created by Apple on 2017/5/26.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "UIImage+ZJH.h"

@implementation UIImage (ZJH)


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

+ (UIImage *)resizedImage:(NSString *)name withWidth:(NSNumber *)widthScale andHeight:(NSNumber *)heightScale {
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * widthScale.floatValue topCapHeight:image.size.height * heightScale.floatValue];
}

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees {
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    CGSize rotatedSize;
    rotatedSize.width = width;
    rotatedSize.height = height;
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(bitmap, rotatedSize.width / 2, rotatedSize.height / 2);
    CGContextRotateCTM(bitmap, degrees * M_PI / 180);
    CGContextRotateCTM(bitmap, M_PI);
    CGContextScaleCTM(bitmap, - 1.0, 1.0);
    CGContextDrawImage(bitmap, CGRectMake(- rotatedSize.width / 2, - rotatedSize.height / 2, rotatedSize.width, rotatedSize.height), self.CGImage);
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



@end
