//
//  ZJHMarginCell.m
//  ancientMap
//
//  Created by Apple on 2017/5/15.
//  Copyright © 2017年 张家浩. All rights reserved.
//

#import "ZJHMarginCell.h"

@implementation ZJHMarginCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lineView.backgroundColor = colorWithSix(@"#F5F4DC");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
