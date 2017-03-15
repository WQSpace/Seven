//
//  UITextField+HDExtension.m
//  PortableTreasure
//
//  Created by HeDong on 14/12/1.
//  Copyright © 2014年 hedong. All rights reserved.
//

#import "UITextField+HDExtension.h"
#import <objc/runtime.h>

@implementation UITextField (HDExtension)

NSString * const HBTextFieldDidDeleteBackwardNotification = @"HBTextFieldDidDeleteBackwardNotification";

+ (void)load {
    Method originalSelector = class_getInstanceMethod([self class], NSSelectorFromString(@"deleteBackward"));
    Method swizzledSelector = class_getInstanceMethod([self class], @selector(hd_deleteBackward));
    method_exchangeImplementations(originalSelector, swizzledSelector);
}

- (void)hd_deleteBackward {
    if (self.hd_deleteBackwardBlock) {
        if (self.hd_deleteBackwardBlock(self)) {
            [self hd_deleteBackward];
            return;
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(textFieldDidDeleteBackward:)]) {
        id <HDTextFieldDelegate> delegate  = (id<HDTextFieldDelegate>)self.delegate;
        [delegate textFieldDidDeleteBackward:self];
    }
    [HDNotificationCenter postNotificationName:HBTextFieldDidDeleteBackwardNotification object:self];
    
    [self hd_deleteBackward];
}


#pragma mark - 光标
- (NSRange)hd_selectedRange {
    UITextPosition *beginning = self.beginningOfDocument;
    
    UITextRange *selectedRange = self.selectedTextRange;
    UITextPosition *selectionStart = selectedRange.start;
    UITextPosition *selectionEnd = selectedRange.end;
    
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}

- (instancetype)hd_setSelectedRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;
    
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    
    [self setSelectedTextRange:selectionRange];
    
    return self;
}

- (instancetype)hd_addLeftViewWithImage:(nonnull NSString *)image {
    UIImageView *lockIv = [[UIImageView alloc] init];
    
    CGRect imageBound = self.bounds;
    
    imageBound.size.width = imageBound.size.height;
    lockIv.bounds = imageBound;
    lockIv.image = [UIImage imageNamed:image];
    lockIv.contentMode = UIViewContentModeCenter;
    
    self.leftView = lockIv;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    return self;
}


#pragma mark - shake
- (instancetype)hd_shake {
    [self hd_shake:10 withDelta:5 completion:nil];
    
    return self;
}

- (instancetype)hd_shake:(NSUInteger)times withDelta:(CGFloat)delta {
    [self hd_shake:times withDelta:delta completion:nil];
    
    return self;
}

- (instancetype)hd_shake:(NSUInteger)times withDelta:(CGFloat)delta completion:(nullable void (^)(void))handler {
    [self hd_shake:times direction:1 currentTimes:0 withDelta:delta speed:0.03 shakeDirection:HDShakeDirectionHorizontal completion:handler];
    
    return self;
}

- (instancetype)hd_shake:(NSUInteger)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval {
    [self hd_shake:times withDelta:delta speed:interval completion:nil];
    
    return self;
}

- (instancetype)hd_shake:(NSUInteger)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval completion:(nullable void (^)(void))handler {
    [self hd_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:HDShakeDirectionHorizontal completion:handler];
    
    return self;
}

- (instancetype)hd_shake:(NSUInteger)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(HDShakeDirection)shakeDirection {
    [self hd_shake:times withDelta:delta speed:interval shakeDirection:shakeDirection completion:nil];
    
    return self;
}

- (instancetype)hd_shake:(NSUInteger)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(HDShakeDirection)shakeDirection completion:(nullable void (^)(void))handler {
    [self hd_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:handler];
    
    return self;
}

- (void)hd_shake:(NSUInteger)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(HDShakeDirection)shakeDirection completion:(nullable void (^)())handler {
    [UIView animateWithDuration:interval animations:^{
        self.transform = (shakeDirection == HDShakeDirectionHorizontal) ? CGAffineTransformMakeTranslation(delta * direction, 0) : CGAffineTransformMakeTranslation(0, delta * direction);
    } completion:^(BOOL finished) {
        if(current >= times) {
            [UIView animateWithDuration:interval animations:^{
                self.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (handler) {
                    handler();
                }
            }];
            return;
        }
        [self hd_shake:(times - 1) direction:direction * -1 currentTimes:current + 1 withDelta:delta speed:interval shakeDirection:shakeDirection completion:handler];
    }];
}


#pragma mark - 重写UITextFieldDelegate
static const void *UITextFieldDelegateKey                           = &UITextFieldDelegateKey;
static const void *UITextFieldShouldBeginEditingKey                 = &UITextFieldShouldBeginEditingKey;
static const void *UITextFieldShouldEndEditingKey                   = &UITextFieldShouldEndEditingKey;
static const void *UITextFieldDidBeginEditingKey                    = &UITextFieldDidBeginEditingKey;
static const void *UITextFieldDidEndEditingKey                      = &UITextFieldDidEndEditingKey;
static const void *UITextFieldShouldChangeCharactersInRangeKey      = &UITextFieldShouldChangeCharactersInRangeKey;
static const void *UITextFieldShouldClearKey                        = &UITextFieldShouldClearKey;
static const void *UITextFieldShouldReturnKey                       = &UITextFieldShouldReturnKey;
static const void *UITextFieldDeleteBackwardBlockKey                = &UITextFieldDeleteBackwardBlockKey;


+ (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.hd_shouldBegindEditingBlock) {
        return textField.hd_shouldBegindEditingBlock(textField);
    }
    
    id delegate = objc_getAssociatedObject(self, UITextFieldDelegateKey);
    
    if ([delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [delegate textFieldShouldBeginEditing:textField];
    }
    // 返回默认值
    return YES;
}

+ (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (textField.hd_shouldEndEditingBlock) {
        return textField.hd_shouldEndEditingBlock(textField);
    }
    
    id delegate = objc_getAssociatedObject(self, UITextFieldDelegateKey);
    
    if ([delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [delegate textFieldShouldEndEditing:textField];
    }
    // 返回默认值
    return YES;
}

+ (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.hd_didBeginEditingBlock) {
        textField.hd_didBeginEditingBlock(textField);
    }
    
    id delegate = objc_getAssociatedObject(self, UITextFieldDelegateKey);
    
    if ([delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [delegate textFieldDidBeginEditing:textField];
    }
}

+ (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.hd_didEndEditingBlock) {
        textField.hd_didEndEditingBlock(textField);
    }
    
    id delegate = objc_getAssociatedObject(self, UITextFieldDelegateKey);
    
    if ([delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [delegate textFieldDidEndEditing:textField];
    }
}

+ (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.hd_shouldChangeCharactersInRangeBlock) {
        return textField.hd_shouldChangeCharactersInRangeBlock(textField,range,string);
    }
    
    id delegate = objc_getAssociatedObject(self, UITextFieldDelegateKey);
    
    if ([delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    
    return YES;
}

+ (BOOL)textFieldShouldClear:(UITextField *)textField {
    if (textField.hd_shouldClearBlock) {
        return textField.hd_shouldClearBlock(textField);
    }
    
    id delegate = objc_getAssociatedObject(self, UITextFieldDelegateKey);
    
    if ([delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [delegate textFieldShouldClear:textField];
    }
    
    return YES;
}

+ (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.hd_shouldReturnBlock) {
        return textField.hd_shouldReturnBlock(textField);
    }
    
    id delegate = objc_getAssociatedObject(self, UITextFieldDelegateKey);
    
    if ([delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [delegate textFieldShouldReturn:textField];
    }
    
    return YES;
}


#pragma mark - UITextFieldDelegateBlock
- (BOOL (^)(UITextField *textField))hd_shouldBegindEditingBlock {
    return objc_getAssociatedObject(self, UITextFieldShouldBeginEditingKey);
}

- (instancetype)hd_shouldBegindEditingBlock:(BOOL (^)(UITextField *textField))shouldBegindEditingBlock {
    [self hd_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextFieldShouldBeginEditingKey, shouldBegindEditingBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return self;
}

- (BOOL (^)(UITextField *textField))hd_shouldEndEditingBlock {
    return objc_getAssociatedObject(self, UITextFieldShouldEndEditingKey);
}

- (instancetype)hd_shouldEndEditingBlock:(BOOL (^)(UITextField *textField))shouldEndEditingBlock {
    [self hd_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextFieldShouldEndEditingKey, shouldEndEditingBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return self;
}

- (void (^)(UITextField *textField))hd_didBeginEditingBlock {
    return objc_getAssociatedObject(self, UITextFieldDidBeginEditingKey);
}

- (instancetype)hd_didBeginEditingBlock:(void (^)(UITextField *textField))didBeginEditingBlock {
    [self hd_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextFieldDidBeginEditingKey, didBeginEditingBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return self;
}

- (void (^)(UITextField *textField))hd_didEndEditingBlock {
    return objc_getAssociatedObject(self, UITextFieldDidEndEditingKey);
}

- (instancetype)hd_didEndEditingBlock:(void (^)(UITextField *textField))didEndEditingBlock {
    [self hd_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextFieldDidEndEditingKey, didEndEditingBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return self;
}

- (BOOL (^)(UITextField *textField, NSRange range, NSString *string))hd_shouldChangeCharactersInRangeBlock {
    return objc_getAssociatedObject(self, UITextFieldShouldChangeCharactersInRangeKey);
}

- (instancetype)hd_shouldChangeCharactersInRangeBlock:(BOOL (^)(UITextField *textField, NSRange range, NSString *string))shouldChangeCharactersInRangeBlock {
    [self hd_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextFieldShouldChangeCharactersInRangeKey, shouldChangeCharactersInRangeBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return self;
}

- (BOOL (^)(UITextField *textField))hd_shouldReturnBlock {
    return objc_getAssociatedObject(self, UITextFieldShouldReturnKey);
}

- (instancetype)hd_shouldReturnBlock:(BOOL (^)(UITextField *textField))shouldReturnBlock {
    [self hd_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextFieldShouldReturnKey, shouldReturnBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return self;
}

- (BOOL (^)(UITextField *textField))hd_shouldClearBlock {
    return objc_getAssociatedObject(self, UITextFieldShouldClearKey);
}

- (instancetype)hd_shouldClearBlock:(BOOL (^)(UITextField *textField))shouldClearBlock {
    [self hd_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextFieldShouldClearKey, shouldClearBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return self;
}

- (BOOL (^)(UITextField *textField))hd_deleteBackwardBlock {
    return objc_getAssociatedObject(self, UITextFieldDeleteBackwardBlockKey);
}

- (instancetype)hd_setDeleteBackwardBlock:(BOOL (^)(UITextField *textField))deleteBackwardBlock {
    [self hd_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, UITextFieldDeleteBackwardBlockKey, deleteBackwardBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return self;
}

/**
 *  避免使用UITextField-block而没有设置delegate将自己设置为delegate
 */
- (void)hd_setDelegateIfNoDelegateSet {
    if (self.delegate != (id<UITextFieldDelegate>)[self class]) {
        objc_setAssociatedObject(self, UITextFieldDelegateKey, self.delegate, OBJC_ASSOCIATION_ASSIGN);
        self.delegate = (id<UITextFieldDelegate>)[self class];
    }
}

@end
