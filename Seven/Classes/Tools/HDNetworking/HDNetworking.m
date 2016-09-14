//
//  HDNetworking.m
//  Seven
//
//  Created by HeDong on 16/2/10.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import "HDNetworking.h"
#import "AFNetworking.h"
#import "HDNetModel.h"
#import <MJExtension/MJExtension.h>

@interface HDNetworking ()

/** http管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation HDNetworking
HDSingletonM(HDNetworking) // 单例实现


#pragma mark - 懒加载
- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    
    return _manager;
}


#pragma mark - 添加内容类型
- (void)addContentTypes:(NSMutableSet *)contentTypes {
    [contentTypes addObject:@"text/html"];
    [contentTypes addObject:@"text/plain"];
}


#pragma mark - 网络方法
- (void)networkStatusUnknown:(Unknown)unknown reachable:(Reachable)reachable reachableViaWWAN:(ReachableViaWWAN)reachableViaWWAN reachableViaWiFi:(ReachableViaWiFi)reachableViaWiFi {
    // 创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 监测到不同网络的情况
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                unknown();
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                reachable();
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                reachableViaWWAN();
                
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                reachableViaWiFi();
                break;
                
            default:
                break;
        }
    }] ;
    
    // 开始监听网络状况
    [manager startMonitoring];
}

- (NSURLSessionDataTask *)GET:(HDRequestModel *)requestModel progress:(Progress)progress success:(Success)success failure:(Failure)failure {
    NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:self.manager.responseSerializer.acceptableContentTypes];
    [self addContentTypes:contentTypes];
    
    self.manager.responseSerializer.acceptableContentTypes = requestModel.acceptableContentTypes;
    self.manager.requestSerializer.timeoutInterval = requestModel.timeout;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSDictionary *parameters = [requestModel mj_keyValues];
    NSURLSessionDataTask *task = [self.manager GET:requestModel.hostURL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // TODO:根据实际情况编写
//        if (success) {
//            success(responseObject);
//        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure((HDNetworkingErrorCode *)error);
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];

    return task;
}

- (NSURLSessionDataTask *)POST:(HDRequestModel *)requestModel progress:(Progress)progress success:(Success)success failure:(Failure)failure {
    
    NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:self.manager.responseSerializer.acceptableContentTypes];
    [self addContentTypes:contentTypes];
    
    self.manager.responseSerializer.acceptableContentTypes = requestModel.acceptableContentTypes;
    self.manager.requestSerializer.timeoutInterval = requestModel.timeout;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES]; // 开启状态栏动画
    
    NSDictionary *parameters = [requestModel mj_keyValues];
    NSURLSessionDataTask *task = [self.manager POST:requestModel.hostURL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        HDResponseModel *responseModel = [HDResponseModel mj_objectWithKeyValues:responseObject];
        HDResponseBodyModel *responseBodyModel = [NSClassFromString(requestModel.body.parseClass)  mj_objectWithKeyValues:responseModel];

        // TODO:根据实际情况编写
//        if (networkingErrorCode.code.intValue == HDNetworkingResponseErrorCode_Success) {
//            if (success) {
//                success(responseBodyModel);
//            }
//            
//        } else {
//            HDNetworkingErrorCode *err = [HDNetworkingErrorCode errorWithDomain:@"error" code:networkingErrorCode.code.integerValue userInfo:nil];
//            failure(err);
//        }
        
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure((HDNetworkingErrorCode *)error);
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
    
    return task;
}

@end
