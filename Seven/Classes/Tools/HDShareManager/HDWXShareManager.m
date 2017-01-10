//
//  HDWXShareManager.m
//  Seven
//
//  Created by HeDong on 2017/1/10.
//  Copyright © 2017年 hedong. All rights reserved.
//

#import "HDWXShareManager.h"
#import "WXApi.h"
#import "UIImage+HDExtension.h"

static NSInteger const kTextMaxLength       = 10000;
static NSInteger const kURLLength           = 10000;
static NSInteger const kTitleLength         = 512;
static NSInteger const kdescriptionLength   = 1000;

@interface HDWXShareManager () <WXApiDelegate>

@end


@implementation HDWXShareManager
HDSingletonM(HDWXShareManager)

- (BOOL)isWXAppInstalled {
    return [WXApi isWXAppInstalled];
}

- (BOOL)registerTRApp:(NSString *)appid {
    return [WXApi registerApp:appid];
}

- (void)shareText:(NSString *)text to:(HDWXShareScene)scene; {
    HDAssert(!HDStringIsEmpty(text), @"文字不能为空, 且文本长度必须大于0且小于10K");
    
    if (text.length > kTextMaxLength) {
        text = [text substringToIndex:kTextMaxLength];
    }
    
    [self verifyLengthWithContent:text scope:kTextMaxLength point:@"文本长度必须大于0且小于10K"];
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = YES;
    req.text = text;
    req.scene = scene;
    [WXApi sendReq:req];
}

- (void)shareURL:(NSString *)URL title:(NSString *)title description:(NSString *)description thumbImage:(UIImage *)thumbImage to:(HDWXShareScene)scene {
    HDAssert(!HDStringIsEmpty(URL), @"URL不能为空");
    HDAssert(title, @"标题不能为空");
    HDAssert(description, @"描述不能为空");
    HDAssert(thumbImage, @"图标不能为空");
    
    if (URL.length > kURLLength) {
        URL = [URL substringToIndex:kURLLength];
    }
    
    if (title.length > kTitleLength) {
        title = [title substringToIndex:kTitleLength];
    }
    
    if (description.length > kdescriptionLength) {
        description = [description substringToIndex:kdescriptionLength];
    }
    
    [self verifyLengthWithContent:URL scope:kURLLength point:@"URL长度必须大于0且小于10K"];
    [self verifyLengthWithContent:title scope:kTitleLength point:@"标题长度必须大于0且小于512字节"];
    [self verifyLengthWithContent:description scope:kdescriptionLength point:@"描述长度必须大于0且小于1K"];
    
    WXWebpageObject *webPageObj = [WXWebpageObject object];
    webPageObj.webpageUrl = URL;
    
    WXMediaMessage *medMessage = [WXMediaMessage message];
    medMessage.title = title;
    medMessage.description = description;
    medMessage.thumbData = [self compressWithImage:thumbImage limitedSize:32]; // 限制32;
    medMessage.mediaObject = webPageObj;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.scene = scene;
    req.message = medMessage;
    
    [WXApi sendReq:req];
}

- (void)shareImage:(UIImage *)image to:(HDWXShareScene)scene {
    HDAssert(image, @"图标不能为空");
    
    WXImageObject *imageObject = [WXImageObject object];
    imageObject.imageData = [self compressWithImage:image limitedSize:10240]; // 限制10M
    
    WXMediaMessage *medMessage = [WXMediaMessage message];
    medMessage.thumbData = [self compressWithImage:image limitedSize:32]; // 限制32;
    medMessage.mediaObject = imageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.scene = scene;
    req.message = medMessage;
    
    [WXApi sendReq:req];
}

- (NSData *)compressWithImage:(UIImage *)image limitedSize:(NSInteger)picSize {
    if (image == nil) return nil;
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    CGFloat maxFileSize = picSize * 1024.0;
    CGFloat precent = maxFileSize / imageData.length;
    
    if (precent > 1) {
        return imageData;
    }
    
    NSData *tempData = UIImageJPEGRepresentation(image, precent);
    
    if (tempData.length > maxFileSize) {
        UIImage *image = [UIImage hd_imageWithDataSimple:tempData scaledToSize:CGSizeMake(200, 200)]; // 因为图片太大已经压缩到最小, 只能修改图片尺寸再压缩
        tempData = [self compressWithImage:image limitedSize:picSize];
    }
    
    return tempData;
}

- (BOOL)handleOpenURL:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:self];
}

- (void)verifyLengthWithContent:(NSString *)content scope:(NSUInteger)scope point:(NSString *)point {
    if (content.length > scope) {
        HDAssert(NO, point);
    }
}


#pragma mark - WXApiDelegate
- (void)onReq:(BaseReq *)req {
    NSLog(@"type == %d, openID == %@", req.type, req.openID);
}


- (void)onResp:(BaseResp *)resp {
    NSLog(@"errCode == %zd, errStr == %@", resp.errCode, resp.errStr);
}

@end

