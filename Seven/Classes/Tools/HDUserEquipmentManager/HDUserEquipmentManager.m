//
//  HDUserEquipmentManager.m
//  Seven
//
//  Created by HeDong on 16/8/9.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import "HDUserEquipmentManager.h"
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation HDUserEquipmentManager

+ (BOOL)isPhotoAlbumAuthorizedState {
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    
    if (author == kCLAuthorizationStatusRestricted || author == kCLAuthorizationStatusDenied) {
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:nil message:@"请在iPhone的“设置-隐私-照片”选项中，允许此APP访问你的照片。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
        
        return NO; // 无权限
    }
    
    return YES;
}

+ (BOOL)isCameraAuthorizedState {
    if (![HDUserEquipmentManager isCameraAvailable]) {
        return NO;
    }
    
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if(authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied) {
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:nil message:@"请在iPhone的“设置-隐私-相机”选项中，允许此APP访问你的相机。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
        
        return NO; // 无权限
    }
    
    return YES;
    
}

+ (BOOL)isCameraAvailable {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        return YES;
    } else {
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:nil message:@"您的设备可能没有相机存在!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
        
        return NO;
    }
}

+ (BOOL)isFrontCameraAvailable {
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
        return YES;
    } else {
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:nil message:@"您的设备前置相机不可使用!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
        
        return NO;
    }
}

+ (BOOL)isRearCameraAvailable {
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
        return YES;
    } else {
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:nil message:@"您的设备后置相机不可使用!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
        
        return NO;
    }
}

@end
