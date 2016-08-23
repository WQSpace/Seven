//
//  AppDelegate.m
//  Seven
//
//  Created by HeDong on 16/8/6.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import "AppDelegate.h"
#import "HDDDLogManager.h"
#import "HDGrowingManager.h"
#import "HDCrashMasterManager.h"
#import "HDMainTabBarController.h"
#import <SDWebImage/SDImageCache.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [HDDDLogManager configDDLog];             // 配置日志系统
    [HDGrowingManager configGrowingManager];  // 配置Growing数据分析
    [HDCrashMasterManager configCrashMaster]; // 配置testin测试
    
    self.window = [[UIWindow alloc] initWithFrame:HDMainScreenBounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[HDMainTabBarController alloc] init];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
#ifdef DEBUG
    
#else
    if ([HDGrowingManager handleUrl:url]) return YES;
#endif
    return NO;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[SDImageCache sharedImageCache] clearMemory];
}

@end
