//
//  HDGrowingManager.m
//  Seven
//
//  Created by HeDong on 16/8/7.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import "HDGrowingManager.h"
#import "Growing.h"

@implementation HDGrowingManager

+ (void)configGrowingManager {
#ifdef DEBUG
    
#else
    [self setUpGrowing]; // release版本发布之后才需要开启
#endif
}

+ (BOOL)handleUrl:(NSURL *)url {
    return [Growing handleUrl:url];
}

+ (void)setUpGrowing {
    HDLog(@"Growing版本号:%@", [Growing sdkVersion]);
    
    [Growing startWithAccountId:@"8beae9158a9481b6"];
    //    [Growing setEnableLog:YES]; // 开启Growing调试日志
    
    HDLogInfo(@"开启Growing数据分析");
}

@end
