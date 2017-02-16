//
//  NSMutableAttributedString+HDExtension.m
//  Seven
//
//  Created by HeDong on 2017/2/16.
//  Copyright © 2017年 hedong. All rights reserved.
//

#import "NSMutableAttributedString+HDExtension.h"

@implementation NSMutableAttributedString (HDExtension)

- (void)addStyleWithRange:(NSRange)range color:(UIColor *)color font:(UIFont *)font {
    if (color == nil || font == nil || range.location > self.length || range.length > self.length) {
        return;
    }
    
    NSDictionary *attributes1 = @{NSForegroundColorAttributeName:color,
                                  NSFontAttributeName:font};
    
    [self addAttributes:attributes1 range:NSMakeRange(range.location, range.length)];
}

@end
