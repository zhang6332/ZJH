//
//  ZJHAfnManager.h
//  ancientMap
//
//  Created by Apple on 2017/3/1.
//  Copyright © 2017年 张家浩. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "ZJHModelResponse.h"

@interface ZJHAfnManager : AFHTTPSessionManager

//单例
+ (instancetype)sharedManager;
//创建请求
+ (ZJHAfnManager *)creatManager;
//创建token单例
+ (instancetype)sharedTokenManager;
//创建token请求
+ (ZJHAfnManager *)creatTokenManager;

/**
 封装的GET请求
 
 @param path 路径
 @param parameters 参数
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestGETWithPath:(NSString *)path parameters:(id)parameters submittingToken:(BOOL)booltoken showHUDToView:(UIView *)HUDView success:(void(^)(ZJHModelResponse * response))success error:(void(^)(NSError * error))failure;

/**
 封装的POST请求
 
 @param path 路径
 @param parameters 参数
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestPOSTWithPath:(NSString *)path parameters:(id)parameters submittingToken:(BOOL)booltoken showHUDToView:(UIView *)HUDView success:(void(^)(ZJHModelResponse * response))success error:(void(^)(NSError * error))failure;
//原生postapplication/x-www-form-urlencoded请求
- (void)requestOrginPOSTWithPath:(NSString *)path parameters:(id)parameters submittingToken:(BOOL)booltoken showHUDToView:(UIView *)HUDView success:(void(^)(ZJHModelResponse *response))success error:(void(^)(NSError *error))failure;
/**
 封装的PUT请求
 
 @param path 路径
 @param parameters 参数
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)requestPUTWithPath:(NSString *)path parameters:(id)parameters submittingToken:(BOOL)booltoken showHUDToView:(UIView *)HUDView formData:(NSString *)data success:(void(^)(ZJHModelResponse * response))success error:(void(^)(NSError * error))failure;

//上传文件
- (void)uploadImagesWithPath:(NSString *)path parameters:(id)parameters submittingToken:(BOOL)booltoken showHUDToView:(UIView *)HUDView images:(NSArray *)file imageNames:(NSArray *)names success:(void(^)(ZJHModelResponse *response))success error:(void(^)(NSError * error))failure;


- (void)uploadImagesAFWithPath:(NSString *)path parameters:(id)parameters submittingToken:(BOOL)booltoken showHUDToView:(UIView *)HUDView images:(NSArray *)file imageNames:(NSArray *)names progress:(void(^)(NSProgress * progress))progress success:(void(^)(ZJHModelResponse *response))success error:(void(^)(NSError * error))failure;


//下载文件
- (void)downloadFileAFNUseGET:(BOOL)getBool WithPath:(NSString *)path parameters:(id)parameters submittingToken:(BOOL)booltoken showHUDToView:(UIView *)HUDView fileName:(NSString *)fileName progress:(void(^)(NSProgress * progress))progress success:(void(^)(ZJHModelResponse *response))success error:(void(^)(NSError * error))failure;
@end
