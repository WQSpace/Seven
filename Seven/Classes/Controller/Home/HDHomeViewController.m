//
//  HDHomeViewController.m
//  Seven
//
//  Created by HeDong on 16/8/6.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import "HDHomeViewController.h"
#import "HDLookForGameViewController.h"
#import "HDClassifyViewController.h"
#import "HDMakeMoneyViewController.h"
#import "HDSquareViewController.h"
#import "HDMeViewController.h"

@interface HDHomeViewController () 

@end

@implementation HDHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    self.navigationController.navigationBarHidden = YES; // 隐藏导航栏
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpSelfAttribute];
    [self setUpMenuViewController];
}

#pragma mark - set
- (void)setUpSelfAttribute {
    self.edgesForExtendedLayout = UIRectEdgeNone; // view内容不此区域navBar和tabBar
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFont:[UIFont systemFontOfSize:20.0]];
    [titleLabel setTextColor:[UIColor hd_randomColor]];
    titleLabel.text = NSLocalizedString(homeText, @"首页");
    [titleLabel sizeToFit];
    
    [self.navigationItem setTitleView:titleLabel];
}

/**
 *  设置菜单视图控制器相关
 */
- (void)setUpMenuViewController {
    HDMenuViewControllerBaseModel *lookForGame = [HDMenuViewControllerBaseModel menuViewControllerBaseModelWithTitle:NSLocalizedString(lookForGameText, @"找游戏") controllerClass:[HDLookForGameViewController class]];
    HDMenuViewControllerBaseModel *classify = [HDMenuViewControllerBaseModel menuViewControllerBaseModelWithTitle:NSLocalizedString(classifyText, @"分类") controllerClass:[HDClassifyViewController class]];
    HDMenuViewControllerBaseModel *makeMoney = [HDMenuViewControllerBaseModel menuViewControllerBaseModelWithTitle:NSLocalizedString(makeMoneyText, @"赚钱") controllerClass:[HDMakeMoneyViewController class]];
    HDMenuViewControllerBaseModel *square = [HDMenuViewControllerBaseModel menuViewControllerBaseModelWithTitle:NSLocalizedString(squareText, @"广场") controllerClass:[HDSquareViewController class]];
    HDMenuViewControllerBaseModel *me = [HDMenuViewControllerBaseModel menuViewControllerBaseModelWithTitle:NSLocalizedString(meText, @"我") controllerClass:[HDMeViewController class]];
    
    self.menuVCBaseModelArr = @[lookForGame, classify, makeMoney, square, me];
    
    [self showMenuViewController];
}

@end
