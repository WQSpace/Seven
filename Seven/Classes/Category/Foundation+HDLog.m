//
//  PortableTreasure
//  Created by HeDong on 15/10/15.
//  Copyright © 2015年 hedong. All rights reserved.
//

#import <Foundation/Foundation.h>

@implementation NSDictionary (HDLog)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [str appendFormat:@"\t%@ = %@,\n", key, obj];
    }];
    
    [str appendString:@"}"];
    
    // 查出最后一个的范围
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    
    if (range.length != 0) {
        [str deleteCharactersInRange:range]; // 删掉最后一个
    }
    
    return str;
}

@end

@implementation NSArray (HDLog)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"[\n"];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendFormat:@"%@,\n", obj];
    }];
    
    [str appendString:@"]"];
    
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    
    if (range.length != 0) {
        [str deleteCharactersInRange:range];
    }
    
    return str;
}

@end
