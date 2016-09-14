//
//  HDNetworking.h
//  Seven
//
//  Created by HeDong on 16/2/10.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDSingleton.h"
#import "HDNetworkingErrorCode.h"

NS_ASSUME_NONNULL_BEGIN

@class HDRequestModel, HDResponseBodyModel;

typedef void (^Success)(HDResponseBodyModel *responseBodyModel); // 成功Block
typedef void (^Failure)(HDNetworkingErrorCode *error);           // 失败Blcok

typedef void (^ _Nullable Progress)(NSProgress * _Nullable progress); // 进度Block
typedef void (^ _Nullable Unknown)();          // 未知网络状态的Block
typedef void (^ _Nullable Reachable)();        // 无网络的Blcok
typedef void (^ _Nullable ReachableViaWWAN)(); // 蜂窝数据网的Block
typedef void (^ _Nullable ReachableViaWiFi)(); // WiFi网络的Block

@interface HDNetworking : NSObject

HDSingletonH(HDNetworking) // 单列


/**
 *  网络监测(在什么网络状态)
 *
 *  @param unknown          未知网络
 *  @param reachable        无网络
 *  @param reachableViaWWAN 蜂窝数据网
 *  @param reachableViaWiFi WiFi网络
 */
- (void)networkStatusUnknown:(Unknown)unknown reachable:(Reachable)reachable reachableViaWWAN:(ReachableViaWWAN)reachableViaWWAN reachableViaWiFi:(ReachableViaWiFi)reachableViaWiFi;

/**
 *  封装的GET请求
 *
 *  @param HDRequestModel 请求的模型
 *  @param progress       请求进度回调
 *  @param success        请求成功回调
 *  @param failure        请求失败回调
 */
- (NSURLSessionDataTask *)GET:(HDRequestModel *)requestModel progress:(Progress)progress success:(Success)success failure:(Failure)failure;

/**
 *  封装的POST请求
 *
 *  @param HDRequestModel 请求的模型
 *  @param progress       请求进度回调
 *  @param success        请求成功回调
 *  @param failure        请求失败回调
 */
- (NSURLSessionDataTask *)POST:(HDRequestModel *)requestModel progress:(Progress)progress success:(Success)success failure:(Failure)failure;

@end

NS_ASSUME_NONNULL_END
