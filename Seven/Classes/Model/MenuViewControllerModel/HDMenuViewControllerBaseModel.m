//
//  HDMenuViewControllerBaseModel.m
//  Seven
//
//  Created by HeDong on 16/8/7.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import "HDMenuViewControllerBaseModel.h"

@implementation HDMenuViewControllerBaseModel

+ (__kindof HDMenuViewControllerBaseModel *)menuViewControllerBaseModelWithTitle:(NSString *)title controllerClass:(Class)controllerClass {
    HDMenuViewControllerBaseModel *menuVCBaseModel = [[self alloc] init];
    menuVCBaseModel.title = title;
    menuVCBaseModel.controllerClass = controllerClass;
    
    return menuVCBaseModel;
}

@end
