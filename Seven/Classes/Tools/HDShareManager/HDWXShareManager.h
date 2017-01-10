//
//  HDWXShareManager.h
//  Seven
//
//  Created by HeDong on 2017/1/10.
//  Copyright © 2017年 hedong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 请求发送场景
typedef NS_ENUM(NSInteger, HDWXShareScene) {
    HDWXShareScene_session  = 0,        /**< 聊天界面   */
    HDWXShareScene_timeline = 1,        /**< 朋友圈    */
    HDWXShareScene_favorite = 2,        /**< 收藏     */
};

@interface HDWXShareManager : NSObject

HDSingletonH(HDWXShareManager)

/**
 检查微信是否安装
 
 @return 安装返回YES否则NO
 */
- (BOOL)isWXAppInstalled;


/**
 向微信注册同仁appid
 
 @param appid 微信颁发的appid
 @return 是否注册成功
 */
- (BOOL)registerTRApp:(NSString *)appid;


/**
 分享文本(文字不能为空, 且文本长度必须大于0且小于10K)
 
 @param text  文本
 @param scene 分享场景
 */
- (void)shareText:(NSString *)text to:(HDWXShareScene)scene;


/**
 分享网页链接
 
 @param URL         网页URL
 @param title       标题
 @param description 描述
 @param thumbImage  缩略图
 @param scene       分享场景
 */
- (void)shareURL:(NSString *)URL title:(NSString *)title description:(NSString *)description thumbImage:(UIImage *)thumbImage to:(HDWXShareScene)scene;


/**
 分享图片
 
 @param image 图片
 @param scene 分享场景
 */
- (void)shareImage:(UIImage *)image to:(HDWXShareScene)scene;


/**
 处理微信通过URL启动App时传递的数据
 
 @param url 微信启动第三方应用时传递过来的URL
 @return  成功返回YES，失败返回NO。
 */
- (BOOL)handleOpenURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
