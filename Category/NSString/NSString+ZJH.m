//
//  NSString+ZJH.m
//  ancientMap
//
//  Created by Apple on 2017/3/21.
//  Copyright © 2017年 张家浩. All rights reserved.
//

#import "NSString+ZJH.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (ZJH)

- (NSString *) md5HexDigest {
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (unsigned)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}


+ (NSString *)makemd5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (unsigned)strlen(cStr), result); // This is the md5 call
    return [[NSString stringWithFormat:
             @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] uppercaseString];
}


//sha256加密方式,其他sha加密只需要改变256对应数字
+ (NSString *)sha256:(NSString *)input {
    //const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    //NSData *data = [NSData dataWithBytes:cstr length:input.length];
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(data.bytes, (unsigned int)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for(int i=0; i<CC_SHA256_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}


- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}


- (CGSize)sizeWithFont:(UIFont *)font {
    return [self sizeWithFont:font maxW:MAXFLOAT];
}


#pragma mark 清空字符串中的空白字符
- (NSString *)removeWhiteSpaceCharacter {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


#pragma mark 是否空字符串
- (BOOL)isEmptyString {
    return (self.length == 0);
}


//判断是否为数字
+ (BOOL)checkIsNumber:(NSString *)str {
    NSString * regex = @"^[0-9]+([.]{0}|[.]{1}[0-9]+)$";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}


+ (BOOL)checkPassWordIsCorrect:(NSString *)password {
    NSString * regex = @"(?!^[0-9]+$)(?!^[A-z]+$)(?!^[^A-z0-9]+$)^.{6,16}$";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}


/**
 验证六位数字的正则表达式
 @param str 输入内容
 @return YES 表示是六位数字 反之不是
 */
+ (BOOL)checkSixNum:(NSString *)str {
    NSString *regex = @"^[0-9]{6}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}


//数字转换成汉字
+ (NSString *)numberTranslateChinese:(NSString *)numString {
    NSString * str = numString;
    NSArray * arabic_numerals = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray * chinese_numerals = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray * digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary * dictionary = [NSDictionary dictionaryWithObjects:chinese_numerals forKeys:arabic_numerals];
    NSMutableArray * sums = [NSMutableArray array];
    for (int i = 0; i < str.length; i ++) {
        NSString * substr = [str substringWithRange:NSMakeRange(i, 1)];
        NSString * a = [dictionary objectForKey:substr];
        NSString * b = digits[str.length -i-1];
        NSString * sum = [a stringByAppendingString:b];
        if ([a isEqualToString:chinese_numerals[9]]) {
            if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]]) {
                sum = b;
                if ([[sums lastObject] isEqualToString:chinese_numerals[9]]) {
                    [sums removeLastObject];
                }
            }else {
                sum = chinese_numerals[9];
            }
            if ([[sums lastObject] isEqualToString:sum]) {
                continue;
            }
        }
        [sums addObject:sum];
    }
    NSString * sumStr = [sums  componentsJoinedByString:@""];
    NSString * chinese = [sumStr substringToIndex:sumStr.length-1];
    return chinese;
}


//判断手机号码格式是否正确
+ (BOOL)chackMobileFormat:(NSString *)mobile {
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11) {
        return NO;
    }else {
        /**
         * 移动号段正则表达式
         */
        NSString * CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString * CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString * CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate * pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate * pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate * pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}


//时间戳格式化时间
+ (NSString *)changeTimeFormatString:(NSString *)string {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    //毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[string doubleValue] / 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}
//获取当前系统时间
+ (NSString *)obtainCurrentZoneTime {
    NSDate *date1 = [NSDate date]; // 获得时间对象-格林尼治时间
    NSDateFormatter *forMatter = [[NSDateFormatter alloc] init];
    [forMatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *dateStr = [forMatter stringFromDate:date1];
    return dateStr;
}
//获取当前时间戳
+ (NSString *)obtainCurrentTimestamp {
    //*1000 是精确到毫秒13位，不乘就是精确到秒
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970] * 1000;
    //转为字符型
    NSString * timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}


#pragma mark - 截取字符串或者double小数点后几位
+ (NSString *)jiequStringWithNum:(NSInteger)num string:(NSString *)string {
    NSString * str ;
    if([string rangeOfString:@"."].location !=NSNotFound) {
        str = [string stringByAppendingString:@"00000000000000"];
        NSRange range;
        range = [str rangeOfString:@"."];
        if (num == 0) {
            return [str substringToIndex:range.location];
        }
        if (num > 0) {
            return [str substringToIndex:range.location + num + 1];
        }
    }
    else
    {
        switch (num) {
            case 0:
                str = [NSString stringWithFormat:@"%@",string];
                break;
            case 1:
                str = [NSString stringWithFormat:@"%@.0",string];
                break;
            case 2:
                str = [NSString stringWithFormat:@"%@.00",string];
                break;
            case 3:
                str = [NSString stringWithFormat:@"%@.000",string];
                break;
            case 4:
                str = [NSString stringWithFormat:@"%@.0000",string];
                break;
            case 5:
                str = [NSString stringWithFormat:@"%@.00000",string];
                break;
            case 6:
                str = [NSString stringWithFormat:@"%@.000000",string];
                break;
            case 7:
                str = [NSString stringWithFormat:@"%@.0000000",string];
                break;
            case 8:
                str = [NSString stringWithFormat:@"%@.00000000",string];
                break;
            case 9:
                str = [NSString stringWithFormat:@"%@.000000000",string];
                break;
            case 10:
                str = [NSString stringWithFormat:@"%@.0000000000",string];
                break;
            default:
                break;
        }
        return str;
    }
    return str;
}

+ (NSString *)jiequdoubleWithNum:(NSInteger)num double:(double)doubleNum {
    NSString * dataString = [NSString stringWithFormat:@"%f",doubleNum];
    return [self jiequStringWithNum:num string:dataString];
}


//邮箱地址的正则表达式
+ (BOOL)isValidateEmail:(NSString *)email {
    NSString * emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate * emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


/**
 判断输入的是否是全为空格
 @param str 字符
 @return str
 */
+ (BOOL)isEmpty:(NSString *)str {
    if (!str) {
        return true;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}

//经纬度转墨卡托
+ (CGPoint)lonLat2MercatorWithLongitudeX:(double)pointX andLatitudeY:(double)pointY {
    CGPoint  mercator;
    double x = pointX *20037508.34/180;
    double y = log(tan((90+pointY)*M_PI/360))/(M_PI/180);
    y = y *20037508.34/180;
    mercator.x = x;
    mercator.y = y;
    return mercator ;
}
//墨卡托转经纬度
+ (CGPoint)Mercator2lonLatWithAGSPointX:(double)pointX andAGSPointY:(double)pointY {
    CGPoint lonLat;
    double x = pointX/20037508.34*180;
    double y = pointY/20037508.34*180;
    y= 180/M_PI*(2*atan(exp(y*M_PI/180))-M_PI/2);
    lonLat.x = x;
    lonLat.y = y;
    return lonLat;
}

//json格式字符串转字典：
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


//id类型转json格式字符串：
//NSJSONWritingPrettyPrinted  是有换位符的。
//如果NSJSONWritingPrettyPrinted 是nil 的话 返回的数据是没有 换位符的
+ (NSString*)dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//转化为可以识别的URLstring(有汉字是使用)
+ (NSString *)stringToAllowString:(NSString *)unallowedString {
    unallowedString = [unallowedString stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLQueryAllowedCharacterSet]];
    return unallowedString;
}


@end
