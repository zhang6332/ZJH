//
//  ZJHAfnManager.m
//  ancientMap
//
//  Created by Apple on 2017/3/1.
//  Copyright © 2017年 张家浩. All rights reserved.
//

#import "ZJHAfnManager.h"
#import "AppDelegate.h"

#define Token_key @"token"
#define Token_value token

@implementation ZJHAfnManager

//单例
+ (instancetype)sharedManager {
    static ZJHAfnManager * sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [self creatManager];
    });
    return sharedManager;
}

//创建token单例
+ (instancetype)sharedTokenManager {
    ZJHAfnManager * sharedManager = [[ZJHAfnManager alloc] init];
    sharedManager = [self sharedManager];
    //header中验证token
    if ([self verifyToken]) {
        [sharedManager.requestSerializer setValue:[self verifyToken] forHTTPHeaderField:Token_key];
    }else {
        return nil;
    }
    return sharedManager;
}

//创建token请求
+ (ZJHAfnManager *)creatTokenManager {
    ZJHAfnManager * sharedManager = [[ZJHAfnManager alloc] init];
    sharedManager = [self creatManager];
    //header中验证token
    if ([self verifyToken]) {
        [sharedManager.requestSerializer setValue:[self verifyToken] forHTTPHeaderField:Token_key];
    }else {
        return nil;
    }
    return sharedManager;
}

//创建请求
+ (ZJHAfnManager *)creatManager {

    ZJHAfnManager * sharedManager = [[ZJHAfnManager alloc] init];
    //重要
    sharedManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    sharedManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //sharedManager.requestSerializer = [AFJSONRequestSerializer serializer];
    //sharedManager.responseSerializer = [AFJSONResponseSerializer serializer];
    sharedManager.requestSerializer.timeoutInterval = 15;
    sharedManager.operationQueue.maxConcurrentOperationCount = 10;
    sharedManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"application/xml",@"text/javascript",@"text/html",@"text/plain", nil];
    //设置后台解析方式
//    [sharedManager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [sharedManager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Accept"];
    
    //HTTPS
    sharedManager.securityPolicy = [self verfyHttps];
    //监控网络
    [self netNotice];
    return sharedManager;
}

//https
+ (id)verfyHttps {
    AFSecurityPolicy * securityPolicy = [AFSecurityPolicy defaultPolicy];
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    //validatesDomainName 是否需要验证域名，默认为YES；
    securityPolicy.validatesDomainName = NO;
    return securityPolicy;
}

//token判断
+ (id)verifyToken {
    if (![[ZJHUserInfoCoordinator obtainUserInfoWithName:nil] Token_value]) {
        [ZJHAfnManager jumpLoginVC];
        return nil;
    }
    return [[ZJHUserInfoCoordinator obtainUserInfoWithName:nil] Token_value];
}

//跳转登录页
+ (void)jumpLoginVC {
    UIViewController * currenVC = [CALayer getCurrentController];
    if (![currenVC isKindOfClass:[ZJHSignInController class]]) {
        ZJHSignInController * signInVC = [[ZJHSignInController alloc]init];
        signInVC.hidesBottomBarWhenPushed = YES;
        if (currenVC.navigationController) {
            [currenVC.navigationController pushViewController:signInVC animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"验证错误请重新登录!"];
            });
        }else {
            [currenVC presentViewController:signInVC animated:YES completion:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBProgressHUD showError:@"验证错误请重新登录!"];
                });
            }];
        }
    }
}

//网络检测
+ (void)netNotice {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
       static NSTimer * timer;
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [timer invalidate];
                timer = nil;
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [MBProgressHUD showSuccess:@"正在使用数据网络"];
//                });
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [timer invalidate];
                timer = nil;
//                dispatch_async(dispatch_get_main_queue(), ^{
//                     [MBProgressHUD showSuccess:@"正在使用WiFi网络"];
//                });
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showError:@"网络信号中断，请检查后重试"];
                });
                timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(showTipsForNetwork) userInfo:nil repeats:YES];
            }
                break;
            default:
                [timer invalidate];
                timer = nil;
                break;
        }
    }];
    //开始启用网络检测
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}
//定时监控网络
+ (void)showTipsForNetwork {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showError:@"网络信号中断，请检查后重试"];
    });
}


- (void)requestGETWithPath:(NSString *)path parameters:(id)parameters submittingToken:(BOOL)booltoken showHUDToView:(UIView *)HUDView success:(void(^)(ZJHModelResponse *response))success error:(void(^)(NSError *error))failure {
    if (!parameters) {
        parameters = [NSMutableDictionary dictionary];
    }
    if (booltoken) {
        //token校验
        if ([ZJHAfnManager verifyToken]) {
            [parameters setObject:[ZJHAfnManager verifyToken] forKey:Token_key];
        }
    }
    //显示加载
    if (HUDView) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:HUDView animated:YES];
        });
    }
    [self GET:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
                
        ZJHModelResponse *response = [ZJHModelResponse mj_objectWithKeyValues:responseObject];
        
            if (success) {
                //结束加载
                if (HUDView) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideAllHUDsForView:HUDView animated:YES];
                    });
                }
                success(response);
            }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            //结束加载
            if (HUDView) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideAllHUDsForView:HUDView animated:YES];
                    });
                }
            dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showError:error.localizedDescription];
                });
            NSLog(@"%@",error.description);//打印错误原因
            failure(error);
        }
    }];
}

- (void)requestPOSTWithPath:(NSString *)path parameters:(id)parameters submittingToken:(BOOL)booltoken showHUDToView:(UIView *)HUDView success:(void(^)(ZJHModelResponse *response))success error:(void(^)(NSError *error))failure {
    if (!parameters) {
        parameters = [NSMutableDictionary dictionary];
    }
    if (booltoken) {
        //token校验
        if ([ZJHAfnManager verifyToken]) {
            [parameters setObject:[ZJHAfnManager verifyToken] forKey:Token_key];
        }
    }
    //显示加载
    if (HUDView) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:HUDView animated:YES];
        });
    }
    [self POST:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        ZJHModelResponse *response = [ZJHModelResponse mj_objectWithKeyValues:responseObject];
            if (success) {
                //结束加载
                if (HUDView) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideAllHUDsForView:HUDView animated:YES];
                    });
                }
                success(response);
            }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        if (failure) {
            //结束加载
            if (HUDView) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideAllHUDsForView:HUDView animated:YES];
                    });
                }
            dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showError:error.localizedDescription];
                });
            NSLog(@"%@",error.description);//打印错误原因
            failure(error);
        }
        
    }];
}
//原生postapplication/x-www-form-urlencoded请求
- (void)requestOrginPOSTWithPath:(NSString *)path parameters:(id)parameters submittingToken:(BOOL)booltoken showHUDToView:(UIView *)HUDView success:(void(^)(ZJHModelResponse *response))success error:(void(^)(NSError *error))failure {
    if (!parameters) {
        parameters = [NSMutableDictionary dictionary];
    }
    //显示加载
    if (HUDView) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:HUDView animated:YES];
        });
    }
    if (booltoken) {
        //token校验
        if ([ZJHAfnManager verifyToken]) {
            [parameters setObject:[ZJHAfnManager verifyToken] forKey:Token_key];
        }
    }
    NSArray * keys = [parameters allKeys];
    NSMutableString * string = [[NSMutableString alloc]init];
    for (id object in keys) {
        if ([object isEqual:[keys lastObject]]) {
            [string appendString:[NSString stringWithFormat:@"%@=%@",object,[parameters objectForKey:object]]];
        }else {
            [string appendString:[NSString stringWithFormat:@"%@=%@&",object,[parameters objectForKey:object]]];
        }
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:25];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:self.requestSerializer.HTTPRequestHeaders];
    request.HTTPBody = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            if (failure) {
                //结束加载
                if (HUDView) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideAllHUDsForView:HUDView animated:YES];
                    });
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showError:error.localizedDescription];
                });
                NSLog(@"%@",error.description);//打印错误原因
                failure(error);
            }
        } else {
            if (success) {
                ZJHModelResponse * response = [ZJHModelResponse mj_objectWithKeyValues:data];
                //结束加载
                if (HUDView) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideAllHUDsForView:HUDView animated:YES];
                    });
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(response);;
                });
            }
        }
    }];
    [dataTask resume];
}

- (void)requestPUTWithPath:(NSString *)path parameters:(id)parameters submittingToken:(BOOL)booltoken showHUDToView:(UIView *)HUDView formData:(NSString *)data success:(void(^)(ZJHModelResponse *response))success error:(void(^)(NSError *error))failure {
    if (!parameters) {
        parameters = [NSMutableDictionary dictionary];
    }
    if (booltoken) {
        //token校验
        if ([ZJHAfnManager verifyToken]) {
            [parameters setObject:[ZJHAfnManager verifyToken] forKey:Token_key];
        }
    }
    //显示加载
    if (HUDView) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:HUDView animated:YES];
        });
    }
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = self.responseSerializer;
    manager.securityPolicy  = self.securityPolicy;
    ///////
    NSMutableURLRequest * request = [self.requestSerializer requestWithMethod:@"PUT" URLString:path parameters:parameters error:nil];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            ZJHModelResponse *response1 = [ZJHModelResponse mj_objectWithKeyValues:responseObject];
                if (success) {
                    //结束加载
                    if (HUDView) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideAllHUDsForView:HUDView animated:YES];
                    });
                    }
                    success(response1);
                }
        } else {
            if (failure) {
                //结束加载
                if (HUDView) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideAllHUDsForView:HUDView animated:YES];
                    });
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showError:error.localizedDescription];
                });
                NSLog(@"%@",error.description);//打印错误原因
                failure(error);
            }
        }
    }] resume];
}

- (void)uploadImagesWithPath:(NSString *)path parameters:(id)parameters submittingToken:(BOOL)booltoken showHUDToView:(UIView *)HUDView images:(NSArray *)file imageNames:(NSArray *)names success:(void(^)(ZJHModelResponse *response))success error:(void(^)(NSError *error))failure {
    if (!parameters) {
        parameters = [NSMutableDictionary dictionary];
    }
    if (booltoken) {
        //token校验
        if ([ZJHAfnManager verifyToken]) {
            [parameters setObject:[ZJHAfnManager verifyToken] forKey:Token_key];
        }
    }
    //显示加载
    if (HUDView) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:HUDView animated:YES];
        });
    }
    //分界线的标识符
    NSString * TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    //分界线 --AaB03x
    NSString * MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 --AaB03x--
    NSString * endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    NSMutableString * body=[[NSMutableString alloc]init];
    //数据格式
    NSString * content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    NSArray * keys= [parameters allKeys];
    for(int i=0;i<[keys count];i++) {
        NSString * key = [keys objectAtIndex:i];
        [body appendFormat:@"%@\r\n",MPboundary];
        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
        [body appendFormat:@"%@\r\n",[parameters objectForKey:key]];
    }
    NSMutableData * myRequestData=[NSMutableData data];
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    for (int i = 0;i < file.count;i++) {
        UIImage * image = file[i];
        NSData * data = UIImageJPEGRepresentation(image, 0.5);
        NSMutableString * imgbody = [[NSMutableString alloc] init];
        [imgbody appendFormat:@"%@\r\n",MPboundary];
        if (names) {
            [imgbody appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",names[i],[NSString  stringWithFormat:@"%@.jpg",[NSString obtainCurrentTimestamp]]];
        }else {
            [imgbody appendFormat:@"Content-Disposition: form-data; name=\"\"; filename=\"%@\"\r\n",[NSString  stringWithFormat:@"%@.jpg",[NSString obtainCurrentTimestamp]]];
        }
        //数据类型(冒号前不能有空格)
        [imgbody appendFormat:@"Content-Type:audio/x-caf; charset=utf-8\r\n\r\n"];
        [myRequestData appendData:[imgbody dataUsingEncoding:NSUTF8StringEncoding]];
        [myRequestData appendData:data];
        [myRequestData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    //声明结束符：--AaB03x--
    NSString * end = [[NSString alloc]initWithFormat:@"%@\r\n",endMPboundary];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    //创建请求
    NSURL * url = [NSURL URLWithString:path];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request setAllHTTPHeaderFields:self.requestSerializer.HTTPRequestHeaders];
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    //创建会话
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionUploadTask * task = [session uploadTaskWithRequest:request fromData:myRequestData completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        if (error) {
            if (failure) {
                //结束加载
                if (HUDView) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideAllHUDsForView:HUDView animated:YES];
                    });
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showError:error.localizedDescription];
                });
                NSLog(@"%@",error.description);//打印错误原因
                failure(error);
            }
        }else {
            if (success) {
                //结束加载
                ZJHModelResponse * response = [ZJHModelResponse mj_objectWithKeyValues:data];
                if (HUDView) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideAllHUDsForView:HUDView animated:YES];
                    });
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(response);
                });
            }
        }
    }];
    [task resume];
}

- (void)uploadImagesAFWithPath:(NSString *)path parameters:(id)parameters submittingToken:(BOOL)booltoken showHUDToView:(UIView *)HUDView images:(NSArray *)file imageNames:(NSArray *)names progress:(void(^)(NSProgress * progress))progress success:(void(^)(ZJHModelResponse *response))success error:(void(^)(NSError * error))failure {
    if (!parameters) {
        parameters = [NSMutableDictionary dictionary];
    }
    if (booltoken) {
        //token校验
        if ([ZJHAfnManager verifyToken]) {
            [parameters setObject:[ZJHAfnManager verifyToken] forKey:Token_key];
        }
    }
    //显示加载
    if (HUDView) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:HUDView animated:YES];
        });
    }
    [self POST:path parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i < file.count; i++) {
            UIImage *image = file[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            /*
             *该方法的参数
             1. appendPartWithFileData：要上传的照片[二进制流]
             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
             3. fileName：要保存在服务器上的文件名
             4. mimeType：上传的文件的类型
             */
            if (names) {
                [formData appendPartWithFileData:imageData name:names[i] fileName:[NSString  stringWithFormat:@"%@.jpg",[NSString obtainCurrentTimestamp]] mimeType:@"audio/x-caf; charset=utf-8"];
            }else {
                [formData appendPartWithFileData:imageData name:@"" fileName:[NSString  stringWithFormat:@"%@.jpg",[NSString obtainCurrentTimestamp]] mimeType:@"audio/x-caf; charset=utf-8"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        if (success) {
            //结束加载
            ZJHModelResponse * response = [ZJHModelResponse mj_objectWithKeyValues:responseObject];
            if (HUDView) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideAllHUDsForView:HUDView animated:YES];
                });
            }
            success(response);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            //结束加载
            if (HUDView) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideAllHUDsForView:HUDView animated:YES];
                });
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:error.localizedDescription];
            });
            NSLog(@"%@",error.description);//打印错误原因
            failure(error);
        }
    }];
}

//下载文件
- (void)downloadFileAFNUseGET:(BOOL)getBool WithPath:(NSString *)path parameters:(id)parameters submittingToken:(BOOL)booltoken showHUDToView:(UIView *)HUDView fileName:(NSString *)fileName progress:(void(^)(NSProgress * progress))progress success:(void(^)(ZJHModelResponse *response))success error:(void(^)(NSError * error))failure {
    if (!parameters) {
        parameters = [NSMutableDictionary dictionary];
    }
    if (booltoken) {
        //token校验
        if ([ZJHAfnManager verifyToken]) {
            [parameters setObject:[ZJHAfnManager verifyToken] forKey:Token_key];
        }
    }
    //显示加载
    if (HUDView) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:HUDView animated:YES];
        });
    }
    NSArray * keys = [parameters allKeys];
    NSMutableString * parameter = [[NSMutableString alloc]init];
    for (id object in keys) {
        if ([object isEqual:[keys lastObject]]) {
            [parameter appendString:[NSString stringWithFormat:@"%@=%@",object,[parameters objectForKey:object]]];
        }else {
            [parameter appendString:[NSString stringWithFormat:@"%@=%@&",object,[parameters objectForKey:object]]];
        }
    }
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]init];
    if (getBool) {
        NSMutableString * string = [[NSMutableString alloc]init];
        [string appendString:@"?"];
        [string appendString:parameter];
        NSMutableString * pathString = [NSMutableString stringWithFormat:@"%@%@",path,string];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:pathString]];
        
    }else {
        request.HTTPMethod = @"POST";
        request.HTTPBody = [parameter dataUsingEncoding:NSUTF8StringEncoding];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
    }
    [request setAllHTTPHeaderFields:self.requestSerializer.HTTPRequestHeaders];
    NSURLSessionDownloadTask * download = [self downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress);
        }
        //监听下载进度
        //completedUnitCount 已经下载的数据大小
        //totalUnitCount     文件数据的中大小
        //NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 设定文件存储路径
        NSString * filePath = nil;
        if (fileName) {
            filePath = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(),fileName];
        }else {
            filePath = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(),response.suggestedFilename];
        }
        NSURL * fileURL = [NSURL fileURLWithPath:filePath];
        // 移动到持久化存储的地方
        NSFileManager * manager = [NSFileManager defaultManager];
        NSError * fmerror = nil;
        [manager moveItemAtURL:targetPath toURL:fileURL error:&fmerror];
        if (fmerror) {
            NSLog(@"文件移动出错: %@", fmerror);
        }else {
            NSLog(@"文件下载成功");
        }
        return fileURL;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            if (failure) {
                //结束加载
                if (HUDView) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideAllHUDsForView:HUDView animated:YES];
                    });
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showError:error.localizedDescription];
                });
                NSLog(@"%@",error.description);//打印错误原因
                failure(error);
            }
        }else {
            if (success) {
                //结束加载
                if (HUDView) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideAllHUDsForView:HUDView animated:YES];
                    });
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    ZJHModelResponse * response = [[ZJHModelResponse alloc]init];
                    response.result = filePath;
                    success(response);
                });
            }
        }
    }];
    //3.执行Task
    [download resume];
}


@end
