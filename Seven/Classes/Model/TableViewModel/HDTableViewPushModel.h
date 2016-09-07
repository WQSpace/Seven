//
//  HDTableViewPushModel.h
//  PortableTreasure
//
//  Created by HeDong on 15/3/17.
//  Copyright © 2015年 hedong. All rights reserved.
//

#import "HDTableViewBaseModel.h"

@interface HDTableViewPushModel : HDTableViewBaseModel

/** 需要跳转的控制器 */
@property (nonatomic, assign) Class controllerClass;


/**
 *  快速创建HDTableViewPushModel对象
 *
 *  @param iconName     头像图片名字
 *  @param labelText    标签文本
 *  @param detailedText 详细文本
 *  @param controllerClass 需要跳转的控制器
 */
+ (__kindof HDTableViewPushModel *)tableViewPushModelWithIconName:(NSString *)iconName labelText:(NSString *)labelText detailedText:(NSString *)detailedText controllerClass:(Class)controllerClass;

@end
