//
//  HDTableViewPushModel.m
//  PortableTreasure
//
//  Created by HeDong on 15/3/17.
//  Copyright © 2015年 hedong. All rights reserved.
//

#import "HDTableViewPushModel.h"

@implementation HDTableViewPushModel

+ (__kindof HDTableViewPushModel *)tableViewPushModelWithIconName:(NSString *)iconName labelText:(NSString *)labelText detailedText:(NSString *)detailedText controllerClass:(Class)controllerClass {
    HDTableViewPushModel *tableViewPushModel = [super tableViewBaseModelWithIconName:iconName labelText:labelText detailedText:detailedText option:nil];
    
    tableViewPushModel.controllerClass = controllerClass;
    
    return tableViewPushModel;
}

@end
