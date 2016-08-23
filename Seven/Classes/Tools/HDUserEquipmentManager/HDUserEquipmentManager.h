//
//  HDUserEquipmentManager.h
//  Seven
//
//  Created by HeDong on 16/8/9.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDUserEquipmentManager : NSObject

/**
 *  相册授权状态
 */
+ (BOOL)isPhotoAlbumAuthorizedState;

/**
 *  相机授权状态
 */
+ (BOOL)isCameraAuthorizedState;

/**
 *  判断设备是否有相机
 */
+ (BOOL)isCameraAvailable;

/**
 *  前置的相机是否可用
 */
+ (BOOL)isFrontCameraAvailable;

/**
 *  后置的相机是否可用
 */
+ (BOOL)isRearCameraAvailable;

@end
