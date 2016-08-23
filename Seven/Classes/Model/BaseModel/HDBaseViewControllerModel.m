//
//  HDBaseViewControllerModel.m
//  Seven
//
//  Created by HeDong on 16/8/7.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import "HDBaseViewControllerModel.h"

@implementation HDBaseViewControllerModel

+ (__kindof HDBaseViewControllerModel *)baseViewControllerModelWithTitle:(NSString *)title controllerClass:(Class)controllerClass {
    HDBaseViewControllerModel *baseModel = [[self alloc] init];
    baseModel.title = title;
    baseModel.controllerClass = controllerClass;
    
    return baseModel;
}

@end
