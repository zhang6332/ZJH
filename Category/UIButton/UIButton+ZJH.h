//
//  UIButton+ZJH.h
//  Tiantian
//
//  Created by Apple on 2017/6/7.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, ZJHButtonEdgeInsetsStyle) {
    ZJHButtonEdgeInsetsStyleTop, // image在上，label在下
    ZJHButtonEdgeInsetsStyleLeft, // image在左，label在右
    ZJHButtonEdgeInsetsStyleBottom, // image在下，label在上
    ZJHButtonEdgeInsetsStyleRight // image在右，label在左
};
@interface UIButton (ZJH)
/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param distance titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(ZJHButtonEdgeInsetsStyle)style imageTitleSpace:(NSNumber *)distance;
@end
