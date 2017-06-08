//
//  BHProductCell.h
//  BHBaiXiang
//
//  Created by apple on 16/11/30.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BHProductCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descripLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

@end
