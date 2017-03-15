//
//  UITextField+HDExtension.h
//  PortableTreasure
//
//  Created by HeDong on 14/12/1.
//  Copyright © 2014年 hedong. All rights reserved.
//  避免Block循环引用!!!
//  __weak typeof(self) weakSelf = self;
//  __strong typeof(weakSelf) strongSelf = weakSelf;


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HDTextFieldDelegate <UITextFieldDelegate>

@optional
- (void)textFieldDidDeleteBackward:(UITextField *)textField;

@end


/**
 * 摇动方向
 * 枚举指定的方向摇动
 */
typedef NS_ENUM(NSInteger, HDShakeDirection) {
    /** 水平左右摇动 */
    HDShakeDirectionHorizontal,
    /** 垂直上下摇动 */
    HDShakeDirectionVertical
};

@interface UITextField (HDExtension)

/**
 代理
 */
@property (nonatomic, weak) id<HDTextFieldDelegate> delegate;

/**
 *  添加TextFiled的左边视图(图片)
 */
- (instancetype)hd_addLeftViewWithImage:(nonnull NSString *)image;


#pragma mark - 光标
/**
 *  获取选中光标位置
 *
 *  @return 返回NSRange
 */
- (NSRange)hd_selectedRange;

/**
 *  设置光标位置
 */
- (instancetype)hd_setSelectedRange:(NSRange)range;


#pragma mark - shake
/**
 *  默认摇动
 */
- (instancetype)hd_shake;

/**
 *  根据摇动次数和设定的宽度
 *
 *  @param times 次数
 *  @param delta 动摇的宽度
 */
- (instancetype)hd_shake:(NSUInteger)times withDelta:(CGFloat)delta;

/**
 *  根据摇动次数和设定的宽度
 *
 *  @param times   次数
 *  @param delta   动摇的宽度
 *  @param handler 完成后的回调
 */
- (instancetype)hd_shake:(NSUInteger)times withDelta:(CGFloat)delta completion:(nullable void (^)(void))handler;

/**
 *  根据摇动次数,设定宽度和速度
 *
 *  @param times    次数
 *  @param delta    动摇的宽度
 *  @param interval 间隔一个震动的持续时间
 */
- (instancetype)hd_shake:(NSUInteger)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval;

/**
 *  根据摇动次数,设定宽度和速度
 *
 *  @param times    次数
 *  @param delta    动摇的宽度
 *  @param interval 间隔一个震动的持续时间
 *  @param handler  完成后的回调
 */
- (instancetype)hd_shake:(NSUInteger)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval completion:(nullable void (^)(void))handler;

/**
 *  根据摇动次数,设定宽度,速度和摇动的方向
 *
 *  @param times          次数
 *  @param delta          动摇的宽度
 *  @param interval       间隔一个震动的持续时间
 *  @param shakeDirection 摇动的方向
 */
- (instancetype)hd_shake:(NSUInteger)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(HDShakeDirection)shakeDirection;

/**
 *  根据摇动次数,设定宽度,速度和摇动的方向
 *
 *  @param times          次数
 *  @param delta          动摇的宽度
 *  @param interval       间隔一个震动的持续时间
 *  @param shakeDirection 摇动的方向
 *  @param handler        完成后的回调
 */
- (instancetype)hd_shake:(NSUInteger)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(HDShakeDirection)shakeDirection completion:(nullable void (^)(void))handler;


#pragma mark - UITextFieldDelegateBlcok
// @optional
- (instancetype)hd_shouldBegindEditingBlock:(BOOL (^)(UITextField *textField))shouldBegindEditingBlock;
- (instancetype)hd_shouldEndEditingBlock:(BOOL (^)(UITextField *textField))shouldEndEditingBlock;
- (instancetype)hd_didBeginEditingBlock:(void (^)(UITextField *textField))didBeginEditingBlock;
- (instancetype)hd_didEndEditingBlock:(void (^)(UITextField *textField))didEndEditingBlock;
- (instancetype)hd_shouldChangeCharactersInRangeBlock:(BOOL (^)(UITextField *textField, NSRange range, NSString *string))shouldChangeCharactersInRangeBlock;
- (instancetype)hd_shouldReturnBlock:(BOOL (^)(UITextField *textField))shouldReturnBlock;
- (instancetype)hd_shouldClearBlock:(BOOL (^)(UITextField *textField))shouldClearBlock;
- (instancetype)hd_setDeleteBackwardBlock:(BOOL (^)(UITextField *textField))deleteBackwardBlock;

@end


HD_EXTERN NSString * const HBTextFieldDidDeleteBackwardNotification;

NS_ASSUME_NONNULL_END

