//
//  HDA2DynamicUITextFieldDelegateBugfix.m
//  Seven
//
//  Created by HeDong on 2017/2/2.
//  Copyright © 2017年 hedong. All rights reserved.
//

#import "HDA2DynamicUITextFieldDelegateBugfix.h"
#import <objc/runtime.h>

@implementation HDA2DynamicUITextFieldDelegateBugfix

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    BOOL ret = YES;
    id realDelegate = self.realDelegate;
    
    if (realDelegate && [realDelegate isKindOfClass:NSClassFromString(@"UIEditUserWordController")]) {
        return ret;
    }
    
    if (realDelegate && [realDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
        ret = [realDelegate textFieldShouldBeginEditing:textField];
    BOOL (^block)(UITextField *) = [self blockImplementationForMethod:_cmd];
    if (block)
        ret &= block(textField);
    return ret;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    id realDelegate = self.realDelegate;
    
    if (realDelegate && [realDelegate isKindOfClass:NSClassFromString(@"UIEditUserWordController")]) {
        return;
    }
    
    if (realDelegate && [realDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)])
        [realDelegate textFieldDidBeginEditing:textField];
    void (^block)(UITextField *) = [self blockImplementationForMethod:_cmd];
    if (block)
        block(textField);
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    BOOL ret = YES;
    id realDelegate = self.realDelegate;
    
    if (realDelegate && [realDelegate isKindOfClass:NSClassFromString(@"UIEditUserWordController")]) {
        return ret;
    }
    
    if (realDelegate && [realDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)])
        ret = [realDelegate textFieldShouldEndEditing:textField];
    BOOL (^block)(UITextField *) = [self blockImplementationForMethod:_cmd];
    if (block)
        ret &= block(textField);
    return ret;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    id realDelegate = self.realDelegate;
    
    if (realDelegate && [realDelegate isKindOfClass:NSClassFromString(@"UIEditUserWordController")]) {
        return;
    }
    
    if (realDelegate && [realDelegate respondsToSelector:@selector(textFieldDidEndEditing:)])
        [realDelegate textFieldDidEndEditing:textField];
    void (^block)(UITextField *) = [self blockImplementationForMethod:_cmd];
    if (block)
        block(textField);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL ret = YES;
    id realDelegate = self.realDelegate;
    
    if (realDelegate && [realDelegate isKindOfClass:NSClassFromString(@"UIEditUserWordController")]) {
        return ret;
    }
    
    if (realDelegate && [realDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
        ret = [realDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    BOOL (^block)(UITextField *, NSRange, NSString *) = [self blockImplementationForMethod:_cmd];
    if (block)
        ret &= block(textField, range, string);
    return ret;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    BOOL ret = YES;
    id realDelegate = self.realDelegate;
    
    if (realDelegate && [realDelegate isKindOfClass:NSClassFromString(@"UIEditUserWordController")]) {
        return ret;
    }
    
    if (realDelegate && [realDelegate respondsToSelector:@selector(textFieldShouldClear:)])
        ret = [realDelegate textFieldShouldClear:textField];
    BOOL (^block)(UITextField *) = [self blockImplementationForMethod:_cmd];
    if (block)
        ret &= block(textField);
    return ret;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL ret = YES;
    id realDelegate = self.realDelegate;
    
    if (realDelegate && [realDelegate isKindOfClass:NSClassFromString(@"UIEditUserWordController")]) {
        return ret;
    }
    
    if (realDelegate && [realDelegate respondsToSelector:@selector(textFieldShouldReturn:)])
        ret = [realDelegate textFieldShouldReturn:textField];
    BOOL (^block)(UITextField *) = [self blockImplementationForMethod:_cmd];
    if (block)
        ret &= block(textField);
    return ret;
}

#pragma mark - exchangeImplementations
+ (void)bugfix {
    NSDictionary *methods = @{@"textFieldShouldBeginEditing:": @"textFieldShouldBeginEditing:",
                              @"textFieldDidBeginEditing:": @"textFieldDidBeginEditing:",
                              @"textFieldShouldEndEditing:": @"textFieldShouldEndEditing:",
                              @"textFieldDidEndEditing:" : @"textFieldDidEndEditing:",
                              @"textField:shouldChangeCharactersInRange:replacementString:" : @"textField:shouldChangeCharactersInRange:replacementString:",
                              @"textFieldShouldClear:" : @"textFieldShouldClear:",
                              @"textFieldShouldReturn:" : @"textFieldShouldReturn:"};
    
    [methods enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull originalM, NSString * _Nonnull exchangeM, BOOL * _Nonnull stop) {
        SEL originalSelector = NSSelectorFromString(originalM);
        SEL exchangeSelector = NSSelectorFromString(exchangeM);
        
        [self exchangeImplementationsWithOriginalClassName:NSClassFromString(@"A2DynamicUITextFieldDelegate") originalSelector:originalSelector exchangeClassName:self exchangeSelector:exchangeSelector];
    }];
}

+ (void)exchangeImplementationsWithOriginalClassName:(Class)originalClassName originalSelector:(SEL)originalSelector exchangeClassName:(Class)exchangeClassName exchangeSelector:(SEL)exchangeSelector {
    Method originalM = class_getInstanceMethod(originalClassName, originalSelector);
    Method exchangeM = class_getInstanceMethod(exchangeClassName, exchangeSelector);
    
    if (originalM && exchangeM) {
        method_exchangeImplementations(originalM, exchangeM);
    }
}

@end
