//
//  HDLookForGameViewController.m
//  Seven
//
//  Created by HeDong on 16/8/7.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import "HDLookForGameViewController.h"
#import "HDNetModel.h"

@interface HDLookForGameViewController ()

@end

@implementation HDLookForGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    HDRequestBodyModel *requestBody = [[HDRequestBodyModel alloc] init];
    HDRequestModel *requestModel = [HDRequestModel requestModelWithBody:requestBody];
    
    [[HDNetworking sharedHDNetworking] POST:requestModel progress:^(NSProgress * _Nullable progress) {
        HDLog(@"进度 == %@", progress);
    } success:^(HDResponseBodyModel * _Nonnull responseBodyModel) {
        HDLog(@"成功 = %@", responseBodyModel);
    } failure:^(HDNetworkingErrorCode * _Nonnull error) {
        HDLog(@"error = %@", error);
        
        switch (error.code) {
            case HDNetworkingResponseErrorCode_NetError:

                break;
                
            default:
                break;
        }
    }];
}

@end
