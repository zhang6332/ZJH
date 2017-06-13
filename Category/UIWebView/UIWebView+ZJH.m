//
//  UIWebView+ZJH.m
//  Tiantian
//
//  Created by Apple on 2017/6/12.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "UIWebView+ZJH.h"

#define HTML_STRING_NIL_TO_NONE_IF(x) [UIWebView STRING_NIL_TO_NONE:x]

@implementation UIWebView (ZJH)

+ (NSString *)STRING_NIL_TO_NONE:(NSString *)x;{
    if (x == nil || ([x isKindOfClass:[NSNull class]]) || ([x isKindOfClass:[NSString class]]&&x.length<=0) || [x isEqual:NULL]){
        return @"";
    } else {
        return [NSString stringWithFormat:@"%@",x];
    }
}

//获取某个标签的结点个数
- (int)nodeCountOfTag:(NSString *)tag {
    NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('%@').length", tag];
    int len = [[self stringByEvaluatingJavaScriptFromString:jsString] intValue];
    return len;
}

//获取当前页面URL
- (NSString *)getCurrentURL {
    return HTML_STRING_NIL_TO_NONE_IF([self stringByEvaluatingJavaScriptFromString:@"document.location.href"]);
}

//获取标题
- (NSString *)getTitle {
    return HTML_STRING_NIL_TO_NONE_IF([self stringByEvaluatingJavaScriptFromString:@"document.title"]);
}

//获取文章内容
- (NSString *)getContent{
    NSString *result = [self stringByEvaluatingJavaScriptFromString:@"document.documentElement.innerText"];
    if (!result) {
        result = [self stringByEvaluatingJavaScriptFromString:@"document.body.innerText"];
    }
    result = HTML_STRING_NIL_TO_NONE_IF(result);
    return result;
}

//获取所有图片链接
- (NSMutableArray *)getImgs {
    NSMutableArray *arrImgURL = [[NSMutableArray alloc] init];
    int node = [self nodeCountOfTag:@"img"];
    for (int i = 0; i < node; i++) {
        NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('img')[%d].src", i];
        NSString *img = [self stringByEvaluatingJavaScriptFromString:jsString];
        [arrImgURL addObject:img];
    }
    return arrImgURL;
}

//获取当前页面所有点击链接
- (NSArray *)getOnClicks {
    NSMutableArray *arrOnClicks = [[NSMutableArray alloc] init];
    int node = [self nodeCountOfTag:@"a"];
    for (int i = 0; i < node; i++) {
        NSString *jsString = [NSString stringWithFormat:@"document.getElementsByTagName('a')[%d].getAttribute('onclick')", i];
        NSString *clickString = [self stringByEvaluatingJavaScriptFromString:jsString];
        [arrOnClicks addObject:clickString];
    }
    return arrOnClicks;
}

//改变背景颜色
- (void)setBackgroundColor:(UIColor *)color {
    NSString * jsString = [NSString stringWithFormat:@"document.body.style.backgroundColor = '%@'",[color webColorString]];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

//为所有图片添加点击事件(网页中有些图片添加无效)
- (void)addClickEventOnImg {
    int node = [self nodeCountOfTag:@"img"];
    for (int i = 0; i < node; i++) {
        //利用重定向获取img.src，为区分，给url添加'img:'前缀
        NSString *jsString = [NSString stringWithFormat:
                              @"document.getElementsByTagName('img')[%d].onclick = \
                              function() { document.location.href = 'img:' + this.src; }",i];
        [self stringByEvaluatingJavaScriptFromString:jsString];
    }
}

//改变指定标签的字体颜色
- (void)setFontColor:(UIColor *)color withTag:(NSString *)tagName {
    NSString *jsString = [NSString stringWithFormat:
                          @"var nodes = document.getElementsByTagName('%@'); \
                          for(var i=0;i<nodes.length;i++){\
                          nodes[i].style.color = '%@';}", tagName, [color webColorString]];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

//改变指定标签的字体大小
- (void)setFontSize:(int)size withTag:(NSString *)tagName {
    NSString *jsString = [NSString stringWithFormat:
                          @"var nodes = document.getElementsByTagName('%@'); \
                          for(var i=0;i<nodes.length;i++){\
                          nodes[i].style.fontSize = '%dpx';}", tagName, size];
    [self stringByEvaluatingJavaScriptFromString:jsString];
}

//设置网页没有拷贝粘贴
- (void)disableTouchCallout{
    [self stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [self stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
}

@end
