//
//  ZJHModelResponse.h
//  ancientMap
//
//  Created by Apple on 2017/3/1.
//  Copyright © 2017年 张家浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJHModelResponse : NSObject

/**
 *  文字说明
 */
@property (nonatomic,copy) NSString *reason;

/**
 *  返回数据集合
 */
@property (nonatomic,strong) id result;

/**
 *  返回状态码
 */
@property (nonatomic,copy) NSString * code;


@end
