//
//  ZJHCycleViewCell.h
//  礼物说
//
//  Created by Apple on 2017/6/2.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJHCycleView.h"
@class ZJHCycleViewCell;

@protocol ZJHCycleViewCellDelegate <NSObject>

- (void)ZJHCycleViewCellDelegateTapsNumber:(NSInteger)tapCount withZJHCycleViewCell:(ZJHCycleViewCell *)cycleViewCell andTapGesture:(UIGestureRecognizer *)tapGesture;
@end

@interface ZJHCycleViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imagesView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic ,weak) id<ZJHCycleViewCellDelegate> delegate;

@end
