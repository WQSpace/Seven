//
//  HDTableViewBaseModel.h
//  PortableTreasure
//
//  Created by HeDong on 15/3/17.
//  Copyright © 2015年 hedong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Option)();

@interface HDTableViewBaseModel : NSObject

/** 头像图片名字 */
@property (nonatomic, copy) NSString *iconName;

/** 标签文本 */
@property (nonatomic, copy) NSString *labelText;

/** 详细文本 */
@property (nonatomic, copy) NSString *detailedText;

/** 回调操作 */
@property (nonatomic, copy) Option option;


/**
 *  快速创建HDTableViewBaseModel对象
 *
 *  @param iconName     头像图片名字
 *  @param labelText    标签文本
 *  @param detailedText 详细文本
 *  @param option       回调操作
 */
+ (__kindof HDTableViewBaseModel *)tableViewBaseModelWithIconName:(NSString *)iconName labelText:(NSString *)labelText detailedText:(NSString *)detailedText option:(Option)option;

@end
