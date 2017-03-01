//
//  UIButton+HDExtension.h
//  PortableTreasure
//
//  Created by HeDong on 14/12/1.
//  Copyright © 2014年 hedong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (HDExtension)

#pragma mark - 背景
/**
 * 设置普通状态与高亮状态的背景图片
 */
- (instancetype)hd_setN_BG:(NSString *)nbg H_BG:(NSString *)hbg;

/**
 * 设置普通状态与高亮状态的拉伸后背景图片
 */
- (instancetype)hd_setResizeN_BG:(NSString *)nbg H_BG:(NSString *)hbg;

/**
 * 设置普通状态与高亮状态的文字
 */
- (instancetype)hd_setNormalTitleColor:(UIColor *)nColor Higblighted:(UIColor *)hColor;


#pragma mark - 范围
/**
 添加扩展范围
 
 @param top 顶部
 @param left 左边
 @param bottom 底部
 @param right 右边
 */
- (void)hd_addEnlargeEdgeWithTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right;

/**
 清除扩展范围
 */
- (void)hd_clearEnlargeEdge;

/**
 获取扩展范围
 
 @return 返回扩展后的范围
 */
- (CGRect)hd_enlargedRect;

@end
