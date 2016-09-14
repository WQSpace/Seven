//
//  HDRequestModel.h
//  Seven
//
//  Created by HeDong on 16/9/13.
//  Copyright © 2016年 huoban. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HDRequestBodyModel;

@interface HDRequestModel : NSObject

/** 后台URL */
@property (nonatomic, copy, readonly) NSString *hostURL;

/** 请求消息体 */
@property (nonatomic, strong) HDRequestBodyModel *body;

/** 超时(默认20秒) */
@property (nonatomic, assign) float timeout;

/** 可接受的响应内容类型 */
@property (nonatomic, copy) NSSet <NSString *> *acceptableContentTypes;


/**
 *  快速创建请求信息
 *
 *  @param body 请求消息体
 */
+ (__kindof HDRequestModel *)requestModelWithBody:(HDRequestBodyModel *)body;

@end
