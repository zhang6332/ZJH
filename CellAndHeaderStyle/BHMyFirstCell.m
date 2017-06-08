//
//  BHMyFirstCell.m
//  BHBaiXiang
//
//  Created by apple on 16/12/9.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import "BHMyFirstCell.h"

@implementation BHMyFirstCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.textColor = colorWithSix(@"#333333");
    self.titleLabel.font = [UIFont systemFontOfSize:15];

    
    self.rightLabel.textColor = colorWithSix(@"#999999");
    self.rightLabel.font = [UIFont systemFontOfSize:13];
    self.lineView.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
