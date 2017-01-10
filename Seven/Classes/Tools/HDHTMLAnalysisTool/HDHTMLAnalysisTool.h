//
//  HDHTMLAnalysisTool.h
//  Seven
//
//  Created by HeDong on 2017/1/10.
//  Copyright © 2017年 hedong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDHTMLAnalysisTool : NSObject


/**
 通过一个URL获取一个HTML页面源代码字符串
 
 @param URL 网址
 @return    返回HTML页面源代码字符串
 */
+ (NSString *)getHTMLStringWithURL:(NSURL *)URL;


/**
 通过一个网址URL获取网页内容
 
 @param url     网址
 @param regular 需要匹配的正则表达式
 
 @return        结果数组
 */
+ (NSArray *)getHTMLContentWithURL:(NSURL *)URL regular:(NSString *)regular;


/**
 通过一个网页源码字符串获取内容
 
 @param HTMLString  网页源码字符串
 @param regular     需要匹配的正则表达式
 @return            结果数组
 */
+ (NSArray *)getHTMLContentWithHTMLString:(NSString *)HTMLString regular:(NSString *)regular;


/**
 通过一个网页源码字符串获取一张图片链接
 
 @param HTMLString  网页源码字符串
 @return            返回一张图片
 */
+ (NSURL *)getImageURLWithHTMLString:(NSString *)HTMLString;


/**
 通过一个网页源码字符串获取多张图片链接
 
 @param HTMLString  网页源码字符串
 @return            返回多张图片
 */
+ (NSArray<NSURL *> *)getImagesURLWithHTMLString:(NSString *)HTMLString;


/**
 通过一个网页源码字符串获取标题
 
 @param HTMLString  网页源码字符串
 @return            返回标题
 */
+ (NSString *)getTitleWithHTMLString:(NSString *)HTMLString;


/**
 通过一个网页源码字符串获取描述
 
 @param HTMLString  网页源码字符串
 @return            返回描述(建议如果返回nil请拿URL当作描述)
 */
+ (NSString *)getDescriptionWithHTMLString:(NSString *)HTMLString;

@end
