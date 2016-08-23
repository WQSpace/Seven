//
//  HDTabBar.h
//  Seven
//
//  Created by HeDong on 16/8/6.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HDTabBar;

typedef void(^tabBarDidClickPlusButton)(HDTabBar *tabBar);

@interface HDTabBar : UITabBar

/** 点击加号按钮 */
@property (nonatomic, copy) tabBarDidClickPlusButton tabBarDidClickPlusButtonBlcok;

@end
