//
//  BHHomeSessionHeaderView.m
//  BHBaiXiang
//
//  Created by apple on 16/11/29.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import "BHHomeSessionHeaderView.h"

@implementation BHHomeSessionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 20, 20)];
        self.leftImageView.center = CGPointMake(self.leftImageView.center.x, 25);
        self.leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.leftImageView.image = [UIImage imageNamed:@"jijinjingxuan"];
        self.leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftImageView.frame) + 10, 0, 150, 50)];
        self.leftLabel.center = CGPointMake(self.leftLabel.center.x, self.leftImageView.center.y);
        self.leftLabel.text = @"基金精选";
        self.leftLabel.textColor = [UIColor colorWithRed:0.20f green:0.20f blue:0.20f alpha:1.00f];
        self.leftLabel.font = [UIFont systemFontOfSize:15];
       
        self.rightLabel = [[UILabel alloc]initWithFrame:CGRectMake( [UIScreen mainScreen].bounds.size.width - self.leftLabel.width - 18 , self.leftLabel.y, self.leftLabel.width, self.leftLabel.height)];
        self.rightLabel.textAlignment = NSTextAlignmentRight;
        self.rightLabel.center = CGPointMake(self.rightLabel.center.x, self.leftImageView.center.y);
        self.rightLabel.textColor = [UIColor colorWithRed:0.60f green:0.60f blue:0.60f alpha:1.00f];
        self.rightLabel.text = @"现金管理 随时存取";
        self.rightLabel.font = [UIFont systemFontOfSize:13];
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49.5, [UIScreen mainScreen].bounds.size.width, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:lineView];
        [self addSubview:self.leftImageView];
        [self addSubview:self.leftLabel];
        [self addSubview:self.rightLabel];
    }
    
    return self;
}

@end
