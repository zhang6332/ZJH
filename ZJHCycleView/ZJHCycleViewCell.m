//
//  ZJHCycleViewCell.m
//  礼物说
//
//  Created by Apple on 2017/6/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ZJHCycleViewCell.h"

@implementation ZJHCycleViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //添加手势
    [self addSubGestures];
}

- (void)addSubGestures {
    //添加双击隐藏标题事件
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
    [self addGestureRecognizer:singleTap];
    //添加双击隐藏标题事件
    UITapGestureRecognizer * doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(CancelReviewTitle:)];
    doubleTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTap];
    //添加三击放大缩小事件
    UITapGestureRecognizer * threeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoomInOrOut:)];
    threeTap.numberOfTapsRequired = 3;
    [self addGestureRecognizer:threeTap];
    //约束单击和双击不能同时生效
    [singleTap requireGestureRecognizerToFail:doubleTap];
    [singleTap requireGestureRecognizerToFail:threeTap];
    [doubleTap requireGestureRecognizerToFail:threeTap];
    //添加长按保存图片事件
    UILongPressGestureRecognizer * pSaveImage = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(SaveImageToAlbum:)];
    [self addGestureRecognizer:pSaveImage];
}

- (void)singleTap:(UITapGestureRecognizer *)singleTap {
    if ([self.delegate respondsToSelector:@selector(ZJHCycleViewCellDelegateTapsNumber:withZJHCycleViewCell:andTapGesture:)]) {
        [self.delegate ZJHCycleViewCellDelegateTapsNumber:1 withZJHCycleViewCell:self andTapGesture:singleTap];
    }
}

//添加双击隐藏标题事件
- (void)CancelReviewTitle:(UITapGestureRecognizer *)doubleTap {
    if ([self.delegate respondsToSelector:@selector(ZJHCycleViewCellDelegateTapsNumber:withZJHCycleViewCell:andTapGesture:)]) {
        [self.delegate ZJHCycleViewCellDelegateTapsNumber:2 withZJHCycleViewCell:self andTapGesture:doubleTap];
    }
}

//添加三击放大缩小事件
- (void)zoomInOrOut:(UITapGestureRecognizer *)tapGesture {
    if ([self.delegate respondsToSelector:@selector(ZJHCycleViewCellDelegateTapsNumber:withZJHCycleViewCell:andTapGesture:)]) {
        [self.delegate ZJHCycleViewCellDelegateTapsNumber:3 withZJHCycleViewCell:self andTapGesture:tapGesture];
    }
}

#pragma mark -- long press gesture method
- (void)SaveImageToAlbum:(UIGestureRecognizer *)gesture {
   
    if (gesture.state == UIGestureRecognizerStateBegan) {
        if ([self.delegate respondsToSelector:@selector(ZJHCycleViewCellDelegateTapsNumber:withZJHCycleViewCell:andTapGesture:)]) {
            [self.delegate ZJHCycleViewCellDelegateTapsNumber:0 withZJHCycleViewCell:self andTapGesture:gesture];
        }
    }
}


@end
