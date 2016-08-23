//
//  HDTabBar.m
//  Seven
//
//  Created by HeDong on 16/8/6.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import "HDTabBar.h"

@interface HDTabBar ()

/** 加号按钮 */
@property (nonatomic, weak) UIButton *plusBtn;

@end

@implementation HDTabBar

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        
        plusBtn.hd_size = plusBtn.currentBackgroundImage.size;
        [plusBtn addTarget:self action:@selector(clickPlusBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        
        self.plusBtn = plusBtn;
    }
    return self;
}

- (void)clickPlusBtn {
    if (self.tabBarDidClickPlusButtonBlcok) {
        self.tabBarDidClickPlusButtonBlcok(self);
    };
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.plusBtn.hd_centerX = self.hd_width * 0.5;
    self.plusBtn.hd_centerY = self.hd_height * 0.5;
    static NSInteger btnCount = 5;

    CGFloat tabbarButtonW = self.hd_width / btnCount;
    CGFloat tabbarButtonIndex = 0;
    
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {

            child.hd_width = tabbarButtonW;
    
            child.hd_x = tabbarButtonIndex * tabbarButtonW;
            
            tabbarButtonIndex++;
            if (tabbarButtonIndex == 2) {
                tabbarButtonIndex++;
            }
        }
    }
}

- (void)dealloc {
    HDLogInfo(@"dealloc");
}

@end
