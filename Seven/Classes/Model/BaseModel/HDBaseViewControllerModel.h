//
//  HDBaseViewControllerModel.h
//  Seven
//
//  Created by HeDong on 16/8/7.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDBaseViewControllerModel : NSObject

/**
 *  需要呈现的控制器
 */
@property (nonatomic, assign) Class controllerClass;

/** 控制器title */
@property (nonatomic, copy) NSString *title;

/**
 *  快速创建模型
 *
 *  @param title           标题名
 *  @param controllerClass 控制器
 */
+ (__kindof HDBaseViewControllerModel *)baseViewControllerModelWithTitle:(NSString *)title controllerClass:(Class)controllerClass;

@end
