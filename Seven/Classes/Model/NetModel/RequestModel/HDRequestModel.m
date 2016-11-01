//
//  HDRequestModel.m
//  Seven
//
//  Created by HeDong on 16/9/13.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import "HDRequestModel.h"
#import "HDNetworkingServerConfig.h"
#import "HDRequestBodyModel.h"

@interface HDRequestModel ()

/** 后台URL */
@property (nonatomic, copy) NSString *hostURL;

@end

@implementation HDRequestModel

- (NSString *)hostURL {
    if (!_hostURL) {
        _hostURL = [NSString stringWithFormat:@"%@/xxx/xxx/", [HDNetworkingServerConfig sharedHDNetworkingServerConfig].hostPort];
    }
    
    return _hostURL;
}

+ (__kindof HDRequestModel *)requestModelWithBody:(HDRequestBodyModel *)body {
    HDRequestModel *request = [[self alloc] init];
    request.body = body;
    request.timeout = 20.0;
    return request;
}

@end
