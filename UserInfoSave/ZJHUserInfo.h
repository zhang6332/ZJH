//
//  ZJHUserInfo.h
//  ancientMap
//
//  Created by Apple on 2017/3/16.
//  Copyright © 2017年 张家浩. All rights reserved.
//

#import "ZJHNSCodingModel.h"

@interface ZJHUserInfo : ZJHNSCodingModel

@property (nonatomic ,copy) NSString * checkCode;
@property (nonatomic ,copy) NSString * identityNumber;
@property (nonatomic ,copy) NSString * mailbox;
@property (nonatomic ,copy) NSString * nickname;
@property (nonatomic ,copy) NSString * password;
@property (nonatomic ,copy) NSString * phone;
@property (nonatomic ,copy) NSString * portrait;
@property (nonatomic ,copy) NSString * realname;
@property (nonatomic ,copy) NSString * remark;
@property (nonatomic ,copy) NSString * token;
@property (nonatomic ,copy) NSString * type;
@property (nonatomic ,copy) NSString * userId;

@end
