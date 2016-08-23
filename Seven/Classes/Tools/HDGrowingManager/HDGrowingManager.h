//
//  HDGrowingManager.h
//  Seven
//
//  Created by HeDong on 16/8/7.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDGrowingManager : NSObject

/**
 *  配置Growing数据分析
 */
+ (void)configGrowingManager;

/**
 *  应用回调
 */
+ (BOOL)handleUrl:(NSURL *)url;

@end
