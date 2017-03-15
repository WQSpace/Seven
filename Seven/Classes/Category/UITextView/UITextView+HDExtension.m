//
//  UITextView+HDExtension.m
//  Seven
//
//  Created by HeDong on 2017/3/15.
//  Copyright © 2017年 hedong. All rights reserved.
//

#import "UITextView+HDExtension.h"
#import <objc/runtime.h>

static const void *UITextViewDeleteBackwardBlockKey = &UITextViewDeleteBackwardBlockKey;
NSString * const HDTextViewDidDeleteBackwardNotification = @"HDTextViewDidDeleteBackwardNotification";


@implementation UITextView (HDExtension)

+ (void)load {
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"deleteBackward"));
    Method method2 = class_getInstanceMethod([self class], @selector(hd_deleteBackward));
    method_exchangeImplementations(method1, method2);
    
    // 下面这个交换主要解决大于等于8.0小于8.3系统不调用deleteBackward的问题
    Method method3 = class_getInstanceMethod([self class], NSSelectorFromString(@"keyboardInputShouldDelete:"));
    Method method4 = class_getInstanceMethod([self class], @selector(hd_keyboardInputShouldDelete:));
    method_exchangeImplementations(method3, method4);
}

- (instancetype)hd_setDeleteBackwardBlock:(BOOL (^)(UITextView *textView))deleteBackwardBlock {
    objc_setAssociatedObject(self, UITextViewDeleteBackwardBlockKey, deleteBackwardBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return self;
}

- (BOOL(^)(UITextView *textView))hd_deleteBackwardBlock {
    return objc_getAssociatedObject(self, UITextViewDeleteBackwardBlockKey);
}

- (void)hd_deleteBackward {
    if (self.hd_deleteBackwardBlock) {
        if (self.hd_deleteBackwardBlock(self)) {
            [self hd_deleteBackward];
            return;
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(textViewDidDeleteBackward:)]) {
        id <HDTextViewDelegate> delegate  = (id<HDTextViewDelegate>)self.delegate;
        [delegate textViewDidDeleteBackward:self];
    }
    
    [HDNotificationCenter postNotificationName:HDTextViewDidDeleteBackwardNotification object:self];
    
    [self hd_deleteBackward];
}

- (BOOL)hd_keyboardInputShouldDelete:(UITextField *)textField {
    BOOL shouldDelete = [self hd_keyboardInputShouldDelete:textField];

    BOOL isMoreThanIos8_0 = ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f);    
    BOOL isLessThanIos8_4 = ([[[UIDevice currentDevice] systemVersion] floatValue] <= 8.4f);
    
    if (textField.text.length && isMoreThanIos8_0 && isLessThanIos8_4) {
        [self deleteBackward];
        return NO;
    }
    
    return shouldDelete;
}

@end
