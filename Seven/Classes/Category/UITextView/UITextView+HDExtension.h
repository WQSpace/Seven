//
//  UITextView+HDExtension.h
//  Seven
//
//  Created by HeDong on 2017/3/15.
//  Copyright © 2017年 hedong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HDTextViewDelegate <UITextViewDelegate>

@optional

/**
 删除事件通知, 代理, block实现其一就行
 */
- (void)textViewDidDeleteBackward:(UITextView *)textView;

@end


@interface UITextView (HDExtension)

@property (nonatomic, weak) id<HDTextViewDelegate> delegate;

- (instancetype)hd_setDeleteBackwardBlock:(BOOL (^)(UITextView *textView))deleteBackwardBlock;

@end

HD_EXTERN NSString * const HDTextViewDidDeleteBackwardNotification;
