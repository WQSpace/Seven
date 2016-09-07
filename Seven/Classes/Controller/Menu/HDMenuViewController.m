//
//  HDMenuViewController.m
//  Seven
//
//  Created by HeDong on 16/8/7.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import "HDMenuViewController.h"

@interface HDMenuViewController ()

@end

@implementation HDMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)showMenuViewController {
    [self addChildVC];
}

/**
 *  添加子控制器
 */
- (void)addChildVC {
    [self addChildViewController:self.homeController];
    [self.view addSubview:self.homeController.view];
    [self.homeController.magicView reloadData];
}


#pragma mark - <VTMagicViewDataSource, VTMagicViewDelegate>
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    NSMutableArray *arr = [NSMutableArray array];
    
    [self.menuVCBaseModelArr enumerateObjectsUsingBlock:^(HDMenuViewControllerBaseModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [arr addObject:obj.title];
    }];
    
    return arr;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:HDColor(50, 50, 50) forState:UIControlStateNormal];
        [menuItem setTitleColor:HDColor(169, 37, 37) forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16.0];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
//    static NSString * const viewControllerID = @"viewControllerIdentifier";
//    UIViewController *viewController = [magicView dequeueReusablePageWithIdentifier:viewControllerID];
    
//    if (!viewController) {
        HDMenuViewControllerBaseModel *baseVCModel = self.menuVCBaseModelArr[pageIndex];
        UIViewController *viewController = [[baseVCModel.controllerClass alloc] init];
//    }
    
    return viewController;
}

- (void)magicView:(VTMagicView *)magicView didSelectItemAtIndex:(NSUInteger)itemIndex {
    //    HDBaseViewControllerModel *baseVCModel = self.baseVCArr[itemIndex];
    //    viewController = [[baseVCModel.controllerClass alloc] init];
}


#pragma mark - 懒加载
- (NSArray<HDMenuViewControllerBaseModel *> *)menuVCBaseModelArr {
    if (!_menuVCBaseModelArr) {
        _menuVCBaseModelArr = [NSArray array];
    }
    
    return _menuVCBaseModelArr;
}

- (VTMagicController *)homeController {
    if (!_homeController) {
        VTMagicController *homeController = [[VTMagicController alloc] init];
        homeController.magicView.navigationColor = [UIColor whiteColor];
        homeController.magicView.sliderColor = [UIColor redColor];
        homeController.magicView.layoutStyle = VTLayoutStyleDivide;
        homeController.magicView.switchStyle = VTSwitchStyleDefault;
        homeController.magicView.navigationHeight = 40.0;
        homeController.magicView.dataSource = self;
        homeController.magicView.delegate = self;
        _homeController = homeController;
    }
    return _homeController;
}

@end
