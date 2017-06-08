//
//  BHMySecondCell.m
//  BHBaiXiang
//
//  Created by apple on 16/12/9.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import "BHMySecondCell.h"

@implementation BHMySecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.textColor = colorWithSix(@"#333333");
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    
    
    self.messageLabel.textColor = colorWithSix(@"#FFFFFF");

    self.messageLabel.font = [UIFont systemFontOfSize:12];
    self.messageLabel.backgroundColor = colorWithSix(@"#FF7220");
    self.messageLabel.clipsToBounds = YES;
    self.messageLabel.layer.cornerRadius = self.messageLabel.width / 2;
    self.lineView.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
