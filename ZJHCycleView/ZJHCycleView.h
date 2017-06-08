//
//  ZJHCycleView.h
//  ZJH
//
//  Created by Apple on 2017/6/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJHCycleView;
@protocol ZJHCycleViewDelegate <NSObject>
@optional
//选中
- (void)ZJHCycleViewDelegateCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
//当前滚动的页面
- (void)ZJHCycleViewDelegateCollectionView:(UICollectionView *)collectionView didScrollItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ZJHCycleView : UIView

/** collectionView */
@property (nonatomic ,strong) UICollectionView * collectionView;
/** 代理 */
@property (nonatomic ,weak) id<ZJHCycleViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate imageUrlArray:(NSArray *) imageUrls placeholderImageName:(UIImage *)image orLocalImageNameArray:(NSArray *)imageNames andImageTitles:(NSArray *)imageTitles autoScroll:(BOOL)autoScroll;

//网络图片地址
- (void)setImageUrlArray:(NSArray<NSString *> * )imageUrls;

//本地图片名字
- (void)setLocalImageNameArray:(NSArray<NSString *> * )imageNames;

//图片描述
- (void)setImageTitlesArray:(NSArray<NSString *> * )imageTitles;

//是否循环滚动
- (void)setCycleViewReapeatAlways:(BOOL)reapeat;



@end
