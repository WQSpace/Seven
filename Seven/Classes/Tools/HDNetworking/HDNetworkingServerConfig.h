//
//  HDNetworkingServerConfig.h
//  Seven
//
//  Created by HeDong on 16/9/14.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDSingleton.h"

@interface HDNetworkingServerConfig : NSObject

HDSingletonH(HDNetworkingServerConfig) // 单列

/** IP或域名:端口 */
@property (nonatomic, copy, readonly) NSString *hostPort;

@end
