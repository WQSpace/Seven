//
//  HDDDLogManager.h
//  Test
//
//  Created by HeDong on 16/7/28.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import <CocoaLumberjack/DDAbstractDatabaseLogger.h>

@interface HDDDLogManager : DDAbstractDatabaseLogger <DDLogFormatter>

/**
 *  配置DDLog日志
 */
+ (void)configDDLog;

@end
