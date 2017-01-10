//
//  HDOpenURLManager.m
//  Seven
//
//  Created by HeDong on 2017/1/10.
//  Copyright © 2017年 hedong. All rights reserved.
//

#import "HDOpenURLManager.h"
#import "HDWXShareManager.h"
#import "HDGrowingManager.h"

@implementation HDOpenURLManager

+ (BOOL)handleWithURL:(NSURL *)url {
#ifdef APP_STORE
    if ([url.scheme isEqualToString:@"growing.e7e0d8cbcb7ca6c5"]) {
        return [HDGrowingManager handleUrl:url];
    }
    
    if ([url.scheme isEqualToString:@"7777777"]) {
        return [[HDWXShareManager sharedHDWXShareManager] handleOpenURL:url];
    }
#else
    if ([url.scheme isEqualToString:@"xxxxxxx"]) {
        return [[HDWXShareManager sharedHDWXShareManager] handleOpenURL:url];
    }
#endif
    return NO;
}

@end
