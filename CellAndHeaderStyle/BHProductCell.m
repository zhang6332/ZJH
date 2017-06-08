//
//  BHProductCell.m
//  BHBaiXiang
//
//  Created by apple on 16/11/30.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import "BHProductCell.h"

@implementation BHProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.descripLabel.font = [UIFont systemFontOfSize:13];
    self.titleLabel.textColor = [UIColor colorWithRed:0.20f green:0.20f blue:0.20f alpha:1.00f];
    self.descripLabel.textColor = [UIColor colorWithRed:0.60f green:0.60f blue:0.60f alpha:1.00f];
    self.rightImageView.image = [UIImage imageNamed:@"arrow_right"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
