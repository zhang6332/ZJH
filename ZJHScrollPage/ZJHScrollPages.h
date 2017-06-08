//
//  ADScrollPages.h
//  Day13-ScrollPages
//
//  Created by Naibin on 16/4/7.
//  Copyright © 2016年 Naibin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJHScrollPages : UIView

/** 滚动视图 */
@property (nonatomic, strong) UIView * addView;
@property (nonatomic, copy) void (^callBack)(UIView *, NSInteger);

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles andCallBack:(void (^)(UIView * addView, NSInteger index))callBack;

- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath;


@end





