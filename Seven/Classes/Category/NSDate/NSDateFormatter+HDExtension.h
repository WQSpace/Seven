//
//  NSDateFormatter+HDExtension.h
//  Test
//
//  Created by HeDong on 16/7/29.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (HDExtension)

+ (instancetype)hd_dateFormatter;
+ (instancetype)hd_dateFormatterWithFormat:(NSString *)dateFormat;

/**
 *  快速创建一个yyyy-MM-dd HH:mm:ss时间格式
 */
+ (instancetype)hd_defaultDateFormatter;

@end
