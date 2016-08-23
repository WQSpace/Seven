//
//  HDCrashMasterManager.m
//  Seven
//
//  Created by HeDong on 16/8/7.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import "HDCrashMasterManager.h"
#import <CrashMaster/CrashMaster.h>

@implementation HDCrashMasterManager

+ (void)configCrashMaster {
#ifdef DEBUG
//    [self setUpCrashMaster];
#else
    [self setUpCrashMaster]; // release版本发布之后才需要开启
#endif
}

+ (void)setUpCrashMaster {
    CrashMasterConfig *crashMasterConfig = [CrashMasterConfig defaultConfig];
    //    crashMasterConfig.printLogForDebug = YES;
    //    crashMasterConfig.enabledShakeFeedback = YES;
    
    [CrashMaster init:@"a555501fb5b7a649567e97340eef1946" channel:@"AppStore" config:crashMasterConfig]; // 配置内测
    [CrashMaster init:@"e729f893e526fd3b279fa61d49fe7f50" channel:@"AppStore" config:crashMasterConfig]; // 配置崩溃分析
    
    HDLogInfo(@"开启testin测试");
}

@end
