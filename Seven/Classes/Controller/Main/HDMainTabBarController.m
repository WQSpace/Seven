//
//  HDMainTabBarController.m
//  Test
//
//  Created by HeDong on 16/7/25.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import "HDMainTabBarController.h"
#import "HDMainNavigationController.h"
#import "HDTabBar.h"
#import "HDHomeViewController.h"

@interface HDMainTabBarController ()

@end

@implementation HDMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpChildViewController];
}

- (void)setUpChildViewController {
    HDHomeViewController *home = [[HDHomeViewController alloc] init];
    [self addChildVc:home title:NSLocalizedString(homeText, @"") image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    UIViewController *t = [[UIViewController alloc] init];
    [self addChildVc:t title:@"未知" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    UIViewController *t1 = [[UIViewController alloc] init];
    [self addChildVc:t1 title:@"未知" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    UIViewController *t2 = [[UIViewController alloc] init];
    [self addChildVc:t2 title:@"未知" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    
    HDTabBar *tabBar = [[HDTabBar alloc] init];
  
    weakSelf(weakSelf)
    tabBar.tabBarDidClickPlusButtonBlcok = ^(HDTabBar *tabBar) {
        strongSelf(strongSelf)
        // TODO:待完成
        HDLogWarn(@"待完成");
//        UIViewController *t3 = [[UIViewController alloc] init];
//        HDMainNavigationController *nav = [[HDMainNavigationController alloc] initWithRootViewController:t3];
//        [strongSelf presentViewController:nav animated:YES completion:nil];
    };
    
    [self setValue:tabBar forKeyPath:@"tabBar"];
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    childVc.tabBarItem.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = HDColor(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = HDColor(81, 81, 81);
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    // 包装导航控制器
    HDMainNavigationController *nav = [[HDMainNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

@end
