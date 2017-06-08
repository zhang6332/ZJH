//
//  BHProductFavoriteCell.h
//  BHBaiXiang
//
//  Created by apple on 16/11/30.
//  Copyright © 2016年 sunny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BHProductFavoriteCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *favoImageView;
- (void)addImageForCellWithUrlString:(NSString *)urlString;
@end
