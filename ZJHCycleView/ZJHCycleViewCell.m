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
    singleTap.numberOfTouchesRequired = 1;
    singleTap.numberOfTapsRequired = 1;

    [self addGestureRecognizer:singleTap];
    //添加双击隐藏标题事件
    UITapGestureRecognizer * doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelReviewTitle:)];
    doubleTap.numberOfTouchesRequired = 1;
    doubleTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTap];
    //创建捏合手势放大缩小事件
    UIPinchGestureRecognizer * pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(zoomInOrOut:)];
    [self addGestureRecognizer:pinch];
    //创建旋转手势
    UIRotationGestureRecognizer * tota = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(ratoGestureRecognize:)];
    [self addGestureRecognizer:tota];
    //约束单击和双击不能同时生效
    [singleTap requireGestureRecognizerToFail:doubleTap];
    //平移
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [panGesture setMinimumNumberOfTouches:2];
    [panGesture setMaximumNumberOfTouches:2];
    [self addGestureRecognizer:panGesture];
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
- (void)cancelReviewTitle:(UITapGestureRecognizer *)doubleTap {
    if ([self.delegate respondsToSelector:@selector(ZJHCycleViewCellDelegateTapsNumber:withZJHCycleViewCell:andTapGesture:)]) {
        [self.delegate ZJHCycleViewCellDelegateTapsNumber:2 withZJHCycleViewCell:self andTapGesture:doubleTap];
    }
}

//添加放大缩小事件
- (void)zoomInOrOut:(UIPinchGestureRecognizer *)PinchGesture {
    if ([self.delegate respondsToSelector:@selector(ZJHCycleViewCellDelegateTapsNumber:withZJHCycleViewCell:andTapGesture:)]) {
        [self.delegate ZJHCycleViewCellDelegateTapsNumber:4 withZJHCycleViewCell:self andTapGesture:PinchGesture];
    }
}

//添加旋转事件
- (void)ratoGestureRecognize:(UIRotationGestureRecognizer *)RotationGesture {
    if ([self.delegate respondsToSelector:@selector(ZJHCycleViewCellDelegateTapsNumber:withZJHCycleViewCell:andTapGesture:)]) {
        [self.delegate ZJHCycleViewCellDelegateTapsNumber:3 withZJHCycleViewCell:self andTapGesture:RotationGesture];
    }
}



// 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer {
    if ([self.delegate respondsToSelector:@selector(ZJHCycleViewCellDelegateTapsNumber:withZJHCycleViewCell:andTapGesture:)]) {
        [self.delegate ZJHCycleViewCellDelegateTapsNumber:5 withZJHCycleViewCell:self andTapGesture:panGestureRecognizer];
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
