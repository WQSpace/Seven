//
//  UIButton+HDExtension.m
//  PortableTreasure
//
//  Created by HeDong on 14/12/1.
//  Copyright © 2014年 hedong. All rights reserved.
//

#import "UIButton+HDExtension.h"
#import <objc/runtime.h>

static const char kTopNameKey;
static const char kRightNameKey;
static const char kBottomNameKey;
static const char kLeftNameKey;

@implementation UIButton (HDExtension)

#pragma mark - 背景
- (instancetype)hd_setN_BG:(NSString *)nbg H_BG:(NSString *)hbg {
    [self setBackgroundImage:[UIImage imageNamed:nbg] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:hbg] forState:UIControlStateHighlighted];
    
    return self;
}

- (instancetype)hd_setNormalTitleColor:(UIColor *)nColor Higblighted:(UIColor *)hColor {
    [self setTitleColor:nColor forState:UIControlStateNormal];
    [self setTitleColor:hColor forState:UIControlStateHighlighted];
    
    return self;
}

- (instancetype)hd_setResizeN_BG:(NSString *)nbg H_BG:(NSString *)hbg {
    UIImage *normalImage = [UIImage imageNamed:nbg];
    int normalLeftCap = normalImage.size.width * 0.5;
    int normalTopCap = normalImage.size.height * 0.5;
    [self setBackgroundImage:[normalImage stretchableImageWithLeftCapWidth:normalLeftCap topCapHeight:normalTopCap] forState:UIControlStateNormal];
    
    UIImage *highlightedImage = [UIImage imageNamed:hbg];
    int highlightedImageLeftCap = normalImage.size.width * 0.5;
    int highlightedImageTopCap = normalImage.size.height * 0.5;
    [self setBackgroundImage:[highlightedImage stretchableImageWithLeftCapWidth:highlightedImageLeftCap topCapHeight:highlightedImageTopCap] forState:UIControlStateHighlighted];
    
    return self;
}


#pragma mark - 范围
- (void)hd_addEnlargeEdgeWithTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right {
    objc_setAssociatedObject(self, &kTopNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &kLeftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &kBottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &kRightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)hd_clearEnlargeEdge {
    [self hd_addEnlargeEdgeWithTop:0 left:0 bottom:0 right:0];
}

- (CGRect)hd_enlargedRect {
    NSNumber *topEdge = objc_getAssociatedObject(self, &kTopNameKey);
    NSNumber *leftEdge = objc_getAssociatedObject(self, &kLeftNameKey);
    NSNumber *bottomEdge = objc_getAssociatedObject(self, &kBottomNameKey);
    NSNumber *rightEdge = objc_getAssociatedObject(self, &kRightNameKey);
    
    if (topEdge && rightEdge && bottomEdge && leftEdge) {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    } else {
        return self.bounds;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect = [self hd_enlargedRect];
    
    if(CGRectEqualToRect(rect, self.bounds)) {
        return [super hitTest:point withEvent:event];
    }
    
    return CGRectContainsPoint(rect, point) ? self : nil;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect = [self hd_enlargedRect];
    
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super pointInside:point withEvent:event];
    }
    
    return CGRectContainsPoint(rect, point) ? YES : NO;
}

@end
