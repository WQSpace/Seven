//
//  MBProgressHUD+HD.m
//  PortableTreasure
//
//  Created by HeDong on 15/12/1.
//  Copyright © 2015年 hedong. All rights reserved.
//

#import "MBProgressHUD+HD.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation MBProgressHUD (HD)

#pragma mark - 显示信息
+ (void)hd_show:(NSString *)text icon:(NSString *)icon view:(UIView *)view {
    if (view == nil) view = HDFirstWindow;

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    hud.label.font = [UIFont systemFontOfSize:12];

    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];

    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hideAnimated:YES afterDelay:1.5];
}

#pragma mark - 显示错误信息
+ (void)hd_showError:(NSString *)error toView:(UIView *)view {
    [self hd_show:error icon:@"error.png" view:view];
}

+ (void)hd_showSuccess:(NSString *)success toView:(UIView *)view {
    [self hd_show:success icon:@"success.png" view:view];
}

#pragma mark - 显示一些信息
+ (MBProgressHUD *)hd_showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = HDFirstWindow;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.removeFromSuperViewOnHide = YES;
    
//    hud.dimBackground = YES; // YES代表需要蒙版效果
    
    return hud;
}

+ (void)hd_showSuccess:(NSString *)success {
    [self hd_showSuccess:success toView:nil];
}

+ (void)hd_showError:(NSString *)error {
    [self hd_showError:error toView:nil];
}

+ (MBProgressHUD *)hd_showMessage:(NSString *)message {
    return [self hd_showMessage:message toView:nil];
}

+ (void)hd_hideHUDForView:(UIView *)view {
    [self hideHUDForView:view animated:YES];
}

+ (void)hd_hideHUD {
    [self hd_hideHUDForView:HDFirstWindow];
}

@end
