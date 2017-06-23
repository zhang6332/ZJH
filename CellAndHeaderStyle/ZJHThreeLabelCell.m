//
//  ZJHThreeLabelCell.m
//  ancientMap
//
//  Created by Apple on 2017/6/23.
//  Copyright © 2017年 张家浩. All rights reserved.
//

#import "ZJHThreeLabelCell.h"

@implementation ZJHThreeLabelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lineView.backgroundColor = [UIColor lightGrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
