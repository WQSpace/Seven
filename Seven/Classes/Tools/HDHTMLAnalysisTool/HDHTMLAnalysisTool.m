//
//  HDHTMLAnalysisTool.m
//  Seven
//
//  Created by HeDong on 2017/1/10.
//  Copyright © 2017年 hedong. All rights reserved.
//

#import "HDHTMLAnalysisTool.h"
#import "NSDate+HDExtension.h"

@implementation HDHTMLAnalysisTool

+ (NSString *)getHTMLStringWithURL:(NSURL *)URL {
    if (URL == nil) {
        return nil;
    }
    
    NSData *data = [NSData dataWithContentsOfURL:URL];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


+ (NSArray *)getHTMLContentWithURL:(NSURL *)URL regular:(NSString *)regular {
    return [self getHTMLContentWithHTMLString:[self getHTMLStringWithURL:URL] regular:regular];
}


+ (NSArray *)getHTMLContentWithHTMLString:(NSString *)HTMLString regular:(NSString *)regular {
    if (HDStringIsEmpty(HTMLString) || HDStringIsEmpty(regular)) {
        return nil;
    }
    
    NSRange range = [HTMLString rangeOfString:regular options:NSRegularExpressionSearch];
    NSMutableArray *arr = [NSMutableArray array];
    
    if (range.length != NSNotFound && range.length != 0) {
        while (range.length != NSNotFound && range.length != 0) {
            NSString *substr = [HTMLString substringWithRange:range];
            
            [arr addObject:substr];
            NSRange startr = NSMakeRange(range.location + range.length, HTMLString.length - range.location - range.length);
            
            range = [HTMLString rangeOfString:regular options:NSRegularExpressionSearch range:startr];
        }
    }
    
    return arr;
}


+ (NSURL *)getImageURLWithHTMLString:(NSString *)HTMLString {
    if (HDStringIsEmpty(HTMLString)) {
        return nil;
    }
    
    // 单独对微信的https://mp.weixin.qq.com/的链接作处理!
    NSArray *weixinImagesURL = [self getHTMLContentWithHTMLString:HTMLString regular:@"(?<=var msg_cdn_url = \\\").*(?=\";)"];
    if (weixinImagesURL.count > 0) {
        NSURL *imageURL = [NSURL URLWithString:weixinImagesURL.firstObject];
        if (imageURL) {
            return imageURL;
        }
    }
    
    NSArray *imagesURL = [self getHTMLContentWithHTMLString:HTMLString regular:@"[a-zA-z]+://[^\\s]*(.JPEG|.jpeg|.JPG|.jpg|.PNG|.png)"]; // 基本图片格式资源
    
    //    NSArray *imagesURL = [self getHTMLContentWithHTMLString:HTMLString regular:@"[a-zA-z]+://[^\\s]*(.JPEG|.jpeg|.JPG|.jpg|.GIF|.gif|.BMP|.bmp|.PNG|.png)"]; // 基本所有格式资源
    
    if (imagesURL.count > 0) {
        NSURL *imageURL = [NSURL URLWithString:imagesURL.firstObject];
        if (imageURL) {
            return imageURL;
        }
    }
    
    return nil;
}


+ (NSArray<NSURL *> *)getImagesURLWithHTMLString:(NSString *)HTMLString {
    if (HDStringIsEmpty(HTMLString)) {
        return nil;
    }
    
    NSArray *imagesURL = [self getHTMLContentWithHTMLString:HTMLString regular:@"[a-zA-z]+://[^\\s]*(.JPEG|.jpeg|.JPG|.jpg|.PNG|.png)"]; // 基本图片格式资源
    
    // 基本所有格式资源
    //    NSArray *imagesURL = [self getHTMLContentWithHTMLString:HTMLString regular:@"[a-zA-z]+://[^\\s]*(.JPEG|.jpeg|.JPG|.jpg|.GIF|.gif|.BMP|.bmp|.PNG|.png)"];
    
    NSMutableArray *tempArr = [NSMutableArray array];
    
    for (NSString *str in imagesURL) {
        NSURL *imageURL = [NSURL URLWithString:str];
        [tempArr addObject:imageURL];
    }
    
    if (HDArrayIsEmpty(tempArr)) {
        return nil;
    }
    
    return tempArr;
}


+ (NSString *)getTitleWithHTMLString:(NSString *)HTMLString {
    if (HDStringIsEmpty(HTMLString)) {
        return nil;
    }
    
    //    NSArray *titles = [self getHTMLContentWithHTMLString:HTMLString regular:@"(?<=title\\>).*(?=</title)"]; // 有些HTML存在很多标题, 匹配一次有些会匹配不到!
    
    NSArray *titles = [self getHTMLContentWithHTMLString:HTMLString regular:@"(title>).*?(?=</title)"];
    
    for (NSString *title in titles) {
        NSString *tempStr = [title substringFromIndex:6];
        if (tempStr.length > 0) {
            return [tempStr limitLength:30];
        }
    }
    
    return nil;
}


+ (NSString *)getDescriptionWithHTMLString:(NSString *)HTMLString {
    if (HDStringIsEmpty(HTMLString)) {
        return nil;
    }
    
    // 单独对微信的https://mp.weixin.qq.com/的链接作处理!
    NSArray *weixinDescriptions = [self getHTMLContentWithHTMLString:HTMLString regular:@"(?<=var msg_desc = \\\").*(?=\";)"];
    
    if (weixinDescriptions.count > 0) {
        NSString *weixinDescription = weixinDescriptions.firstObject;
        return [weixinDescription limitLength:80];
    }
    
    NSArray *descriptions = [self getHTMLContentWithHTMLString:HTMLString regular:@"(?<=<meta name=\"description\"(| itemprop=\"description\") content=\\\").*(?=\")"];
    
    if (descriptions.count > 0) {
        NSString *description = descriptions.firstObject;
        return [description limitLength:80];
    }
    
    return nil;
}

@end
