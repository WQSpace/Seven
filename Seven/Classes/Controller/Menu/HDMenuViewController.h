//
//  HDMenuViewController.h
//  Seven
//
//  Created by HeDong on 16/8/7.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import "HDBaseViewController.h"
#import "VTMagic.h"
#import "HDBaseViewControllerModel.h"

@interface HDMenuViewController : HDBaseViewController <VTMagicViewDataSource, VTMagicViewDelegate>

/** 首页主要的控制器 */
@property (nonatomic, weak) VTMagicController *homeController;

/** 基础VC模型 */
@property (nonatomic, strong) NSArray<HDBaseViewControllerModel *> *baseVCArr;

/**
 *  显示菜单视图控制器(默认不显示,需要子类调用才可显示)
 */
- (void)showMenuViewController;

@end
