//
//  BHProductFavoriteCell.m
//  BHBaiXiang
//
//  Created by apple on 16/11/30.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import "BHProductFavoriteCell.h"
#import "UIImageView+WebCache.h"

@implementation BHProductFavoriteCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)addImageForCellWithUrlString:(NSString *)urlString {
    [self.favoImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:nil];
}



@end
