//
//  HDOpenURLManager.h
//  Seven
//
//  Created by HeDong on 2017/1/10.
//  Copyright © 2017年 hedong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDOpenURLManager : NSObject

/**
 *  统一处理openURL
 */
+ (BOOL)handleWithURL:(NSURL *)url;

@end
