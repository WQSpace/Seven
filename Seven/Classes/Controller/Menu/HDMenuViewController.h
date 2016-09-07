//
//  HDMenuViewController.h
//  Seven
//
//  Created by HeDong on 16/8/7.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import "HDBaseViewController.h"
#import "VTMagic.h"
#import "HDMenuViewControllerBaseModel.h"

@interface HDMenuViewController : HDBaseViewController <VTMagicViewDataSource, VTMagicViewDelegate>

/** 首页主要的控制器 */
@property (nonatomic, weak) VTMagicController *homeController;

/** 存放基础VC模型 */
@property (nonatomic, strong) NSArray<HDMenuViewControllerBaseModel *> *menuVCBaseModelArr;

/**
 *  显示菜单视图控制器(默认不显示, 需要子类调用才可显示)
 *  可重写此方法, 设置自定义homeController.
 */
- (void)showMenuViewController;

@end
