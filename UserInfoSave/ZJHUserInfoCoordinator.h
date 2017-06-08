//
//  ZJHUserInfoCoordinator.h
//  ancientMap
//
//  Created by Apple on 2017/3/16.
//  Copyright © 2017年 张家浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJHUserInfo.h"
// 用户信息的存储路径
#define userInfoPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"user.archive"]

@interface ZJHUserInfoCoordinator : NSObject

//存储用户的基本信息

+ (void)saveUserInfo:(id)userInfo withName:(NSString *)name;

//获取用户的基本信息

+ (id)obtainUserInfoWithName:(NSString *)name;

//删除用户信息
+ (void)deleteUserInfoWithName:(NSString *)name;

@end
