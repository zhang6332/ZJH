//
//  BHHomeSessionHeaderView.h
//  BHBaiXiang
//
//  Created by apple on 16/11/29.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BHHomeSessionHeaderView : UITableViewHeaderFooterView

/** imageView */
@property (nonatomic ,strong) UIImageView * leftImageView;

/** leftLabel */
@property (nonatomic ,strong) UILabel * leftLabel;
/** rightLabel */
@property (nonatomic ,strong) UILabel * rightLabel;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
@end
