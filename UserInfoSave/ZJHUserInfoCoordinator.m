//
//  ZJHUserInfoCoordinator.m
//  ancientMap
//
//  Created by Apple on 2017/3/16.
//  Copyright © 2017年 张家浩. All rights reserved.
//

#import "ZJHUserInfoCoordinator.h"
@implementation ZJHUserInfoCoordinator


//存储用户的基本信息

+ (void)saveUserInfo:(id)userInfo withName:(NSString *)name {

    if (name == nil) {
        [NSKeyedArchiver archiveRootObject:userInfo toFile:userInfoPath];
    }else {
         NSString * nickPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archive",name]];
        [NSKeyedArchiver archiveRootObject:userInfo toFile:nickPath];
    }
    
}

//获取用户的基本信息

+ (id)obtainUserInfoWithName:(NSString *)name {
    if (name == nil) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:userInfoPath];
    }else {
        NSString * nickPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archive",name]];
        return [NSKeyedUnarchiver unarchiveObjectWithFile:nickPath];
    }
}

//删除用户信息
+ (void)deleteUserInfoWithName:(NSString *)name {
    NSError * error;
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if (name == nil) {
        [fileManager removeItemAtPath:userInfoPath error:&error];
        if (error) {
            [MBProgressHUD showError:error.localizedDescription];
        }
    }else {
        NSString * nickPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archive",name]];
        [fileManager removeItemAtPath:nickPath error:&error];
        if (error) {
            [MBProgressHUD showError:error.localizedDescription];
        }
    }
    
}


@end
