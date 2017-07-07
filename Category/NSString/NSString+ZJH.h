//
//  NSString+ZJH.h
//  ancientMap
//
//  Created by Apple on 2017/3/21.
//  Copyright © 2017年 张家浩. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>

@interface NSString (ZJH)

//按字体属性计算Labelframe
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)sizeWithFont:(UIFont *)font;

//md5加密
-(NSString *) md5HexDigest;
+ (NSString *)makemd5:(NSString *)str;

//sha256加密
+ (NSString *)sha256:(NSString *)input;

/**
 *  是否空字符串
 *
 *  @return 如果字符串为nil或者长度为0返回YES
 */
- (BOOL)isEmptyString;

/**
 *  清空字符串中的空白字符
 *
 *  @return 清空空白字符串之后的字符串
 */
- (NSString *)removeWhiteSpaceCharacter;

/**
 *  判断是否为数字
 *
 *  @param str 输入的内容
 *
 *  @return 返回是否为数字的BOOL
 */
+ (BOOL)checkIsNumber:(NSString *)str;

///**
// *  验证六位数字密码
// *
// *  @param NSString 输入的内容
// *
// *  @return 返回是否为数字的BOOL
// */
+ (BOOL)checkSixNum:(NSString *)str;

/**
 *  密码规则的正则表达式
 *
 *  @param password 要验证的密码
 *
 *  @return 返回是否符合规则
 */
+ (BOOL)checkPassWordIsCorrect:(NSString *)password;

#pragma mark - 数字转换成汉字
+ (NSString *)numberTranslateChinese:(NSString *)numString;

//判断手机号码格式是否正确
+ (BOOL)chackMobileFormat:(NSString *)mobile;

//时间戳格式化时间
+ (NSString *)changeTimeFormatString:(NSString *)string;
//获取当前系统时间
+ (NSString *)obtainCurrentZoneTime;
//获取当前时间戳
+ (NSString *)obtainCurrentTimestamp;
//时间转时间戳
+ (NSString *)getTimestampFromTime:(NSString *)data;

//截取字符串
+ (NSString *)jiequStringWithNum:(NSInteger)num string:(NSString *)string;
+ (NSString *)jiequdoubleWithNum:(NSInteger)num double:(double )doubleNum;

//邮箱地址的正则表达式
+ (BOOL)isValidateEmail:(NSString *)email;

//判断输入的是否是全为空格
+ (BOOL)isEmpty:(NSString *)str;

//经纬度转墨卡托
+ (CGPoint)lonLat2MercatorWithLongitudeX:(double)pointX andLatitudeY:(double)pointY;

//墨卡托转经纬度
+ (CGPoint)Mercator2lonLatWithAGSPointX:(double)pointX andAGSPointY:(double)pointY;

//json格式字符串转字典：
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//字典转json格式字符串：
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

//转化为可以识别的URLstring(有汉字是使用)
+ (NSString *)stringToAllowString:(NSString *)unallowedString;

/**
 判断该字符串是不是一个有效的URL
 @return YES：是一个有效的URL or NO
 */
- (BOOL)isValidUrl;

/** 根据图片名 判断是否是gif图 */
- (BOOL)isGifImage;

/** 根据图片data 判断是否是gif图 */
+ (BOOL)isGifWithImageData: (NSData *)data;

/**
 根据image的data 判断图片类型
 @param data 图片data
 @return 图片类型(png、jpg...)
 */
+ (NSString *)contentTypeWithImageData: (NSData *)data;



@end
