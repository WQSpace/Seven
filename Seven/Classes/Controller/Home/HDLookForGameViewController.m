//
//  HDLookForGameViewController.m
//  Seven
//
//  Created by HeDong on 16/8/7.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import "HDLookForGameViewController.h"

@interface HDLookForGameViewController ()

@end

@implementation HDLookForGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [[HDNetworking sharedHDNetworking] GET:@"http://cdn.4399sj.com/app/iphone/v3.0/home.html?n=25&p=1" parameters:@{} success:^(id  _Nonnull responseObject) {
        HDLog(@"成功 = %@", responseObject);
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil];
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        HDLog(@"%@", jsonStr);
        
    } failure:^(NSError * _Nonnull error) {
        HDLog(@"失败");
    }];
}

@end
