//
//  NSDateFormatter+HDExtension.m
//  Test
//
//  Created by HeDong on 16/7/29.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import "NSDateFormatter+HDExtension.h"

@implementation NSDateFormatter (HDExtension)

+ (instancetype)hd_dateFormatter {
    return [[self alloc] init];
}

+ (instancetype)hd_dateFormatterWithFormat:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [[self alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}

+ (instancetype)hd_defaultDateFormatter {
    return [self hd_dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

@end
