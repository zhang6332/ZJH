//
//  ZJHRequestURL.h
//  ancientMap
//
//  Created by Apple on 2017/5/2.
//  Copyright © 2017年 张家浩. All rights reserved.
//

#ifndef ZJHRequestURL_h
#define ZJHRequestURL_h


//后台服务
#define ANCIENTMAP_SERVER @"http://218.241.213.230:8080"
//上传照片
#define UPLOAD_IMAGE @"/Outlet/drain/add.do"
//登录
#define LOGIN_URL @"/Outlet/user/login.do"
//注册
#define REGISTER_URL @"/Outlet/user/regist.do"
//验证用户名
#define VERTIFY_NAME @"/AMapServer/user/findUserByNickname.do"
//验证邮箱
#define VERTIFY_EMAIL @"/AMapServer/user/findUserByEmail.do"
//获取个人上传列表
#define PERSONUPLOAD_LIST @"/Outlet/drain/findMyOutlets.do"
//获取标记id查询属性信息及其照片信息
#define GETUSER_URL @"/Outlet/drain/findOutletAndPicByOId.do"
//所有排污口位置信息
#define ALLMARK_URL @"/Outlet/drain/findAllLocInfo.do"
//自己排污口位置
#define MYMARK_URL @"/Outlet/drain/findMyLocInfo.do"




#endif /* ZJHRequestURL_h */
