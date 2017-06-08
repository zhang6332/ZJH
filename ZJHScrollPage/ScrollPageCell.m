//
//  ScrollPageCell.m
//  BHBaiXiang
//
//  Created by apple on 16/12/5.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import "ScrollPageCell.h"

@implementation ScrollPageCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.backgroundColor = [UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = [UIColor colorWithRed:0.20f green:0.20f blue:0.20f alpha:1.00f];
    self.lineView.backgroundColor = [UIColor clearColor];

}

@end
