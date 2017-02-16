//
//  MBProgressHUD+HD.h
//  PortableTreasure
//
//  Created by HeDong on 15/12/1.
//  Copyright © 2015年 hedong. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (HD)

/**
 *  显示成功 1.5秒之后再消失
 *  默认加在HDFirstWindow上
 *  @param success 提醒成功文字
 */
+ (void)hd_showSuccess:(NSString *)success;

/**
 *  显示错误 1.5秒之后再消失
 *  默认加在HDFirstWindow上
 *  @param error 提醒错误文字
 */
+ (void)hd_showError:(NSString *)error;

/**
 *  显示成功 1.5秒之后再消失
 *
 *  @param success 提醒成功文字
 *  @param view    加在哪个view上为nil,默认加在HDFirstWindow
 */
+ (void)hd_showSuccess:(NSString *)success toView:(UIView *)view;

/**
 *  显示成功 1.5秒之后再消失
 *
 *  @param error 提醒错误文字
 *  @param view  加在哪个view上为nil,默认加在HDFirstWindow
 */
+ (void)hd_showError:(NSString *)error toView:(UIView *)view;

/**
 *  增加一个消息提醒挡板
 *
 *  @param message 提醒文字
 *  @param view    加在哪个view上为nil,默认加在HDFirstWindow
 *
 *  @return 返回一个挡板
 */
+ (MBProgressHUD *)hd_showMessage:(NSString *)message toView:(UIView *)view;

/**
 *  增加一个消息提醒挡板(默认添加到HDFirstWindow视图上)
 *
 *  @param message 提醒文字
 *
 *  @return 返回一个挡板
 */
+ (MBProgressHUD *)hd_showMessage:(NSString *)message;

/**
 *  隐藏挡板
 *
 *  @param view 从哪个view隐藏
 */
+ (void)hd_hideHUDForView:(UIView *)view;

/**
 *  隐藏挡板(默认从HDFirstWindow视图隐藏)
 */
+ (void)hd_hideHUD;

@end
