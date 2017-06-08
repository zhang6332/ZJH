//
//  ZJHModelResponse.m
//  ancientMap
//
//  Created by Apple on 2017/3/1.
//  Copyright © 2017年 张家浩. All rights reserved.
//

#import "ZJHModelResponse.h"

@implementation ZJHModelResponse

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{@"ID" : @"id"};
}

@end
