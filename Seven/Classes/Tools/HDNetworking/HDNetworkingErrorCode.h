//
//  HDNetworkingErrorCode.h
//  Seven
//
//  Created by HeDong on 16/9/14.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HDNetworkingResponseErrorCode) {
    HDNetworkingResponseErrorCode_Success  = 200, // 成功
    HDNetworkingResponseErrorCode_NetError = 500  // 网络异常
};

@interface HDNetworkingErrorCode : NSError

@end
