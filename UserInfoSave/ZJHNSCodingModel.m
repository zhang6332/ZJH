//
//  ZJHNSCodingModel.m
//  ancientMap
//
//  Created by Apple on 2017/3/27.
//  Copyright © 2017年 张家浩. All rights reserved.
//

#import "ZJHNSCodingModel.h"
#import <objc/runtime.h>

@implementation ZJHNSCodingModel

- (NSArray *)properties {
    NSMutableArray *properties = [NSMutableArray array];
    unsigned int count = 0;
    
    Ivar *propertyArr = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar property = propertyArr[i];
        const char *propertyNameC = ivar_getName(property);
        NSString *propertyNameOC = [[NSString alloc] initWithCString:propertyNameC encoding:NSUTF8StringEncoding];
        [properties addObject:propertyNameOC];
    }
    free(propertyArr);
    
    return properties;
}
/**
 *  当一个对象要归档进沙盒中时，就会调用这个方法
 *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSArray *propertyArray = [self properties];
    for (NSString *property in propertyArray) {
        [aCoder encodeObject:[self valueForKey:property] forKey:property];
    }
}

/**
 *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
 *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）66666666
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        for (NSString *property in [self properties]) {
            [self setValue:[aDecoder decodeObjectForKey:property] forKey:property];
        }
    }
    return self;
}

- (NSString *)description {
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"%@=%p  ", self.class, &self]];
    for (NSString *property in [self properties]) {
        NSString *propertyValue = [NSString stringWithFormat:@"%@=%@  ", property, [self valueForKey:property]];
        [string appendString:propertyValue];
    }
    return string.copy;
}

@end
