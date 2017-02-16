//
//  NSMutableAttributedString+HDExtension.h
//  Seven
//
//  Created by HeDong on 2017/2/16.
//  Copyright © 2017年 hedong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (HDExtension)

/**
 添加富文本样式
 
 @param range 需要改变的范围
 @param color 需要改变的颜色
 @param font 需要改变的字体
 */
- (void)addStyleWithRange:(NSRange)range color:(UIColor *)color font:(UIFont *)font;

@end
