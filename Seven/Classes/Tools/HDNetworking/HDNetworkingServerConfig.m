//
//  HDNetworkingServerConfig.m
//  Seven
//
//  Created by HeDong on 16/9/14.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import "HDNetworkingServerConfig.h"

@interface HDNetworkingServerConfig ()

/** IP或域名:端口 */
@property (nonatomic, copy) NSString *hostPort;

@end

@implementation HDNetworkingServerConfig

HDSingletonM(HDNetworkingServerConfig)

- (NSString *)hostPort {
    if (!_hostPort) {
#ifdef APP_STORE
        _hostPort = @"http://www.hedong.com:7777";
#else
        _hostPort = @"http://192.168.0.1:8080";
#endif
    }
    return _hostPort;
}

@end
