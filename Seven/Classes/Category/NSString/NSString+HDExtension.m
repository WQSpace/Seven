//
//  NSString+HDExtension.m
//  PortableTreasure
//
//  Created by HeDong on 15/5/10.
//  Copyright © 2015年 hedong. All rights reserved.
//

#import "NSString+HDExtension.h"
#import "sys/utsname.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (HDExtension)


#pragma mark - 散列函数
- (instancetype)hd_md5String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(str, (CC_LONG)strlen(str), buffer);
    
    return [self hd_stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (instancetype)hd_sha1String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(str, (CC_LONG)strlen(str), buffer);
    
    return [self hd_stringFromBytes:buffer length:CC_SHA1_DIGEST_LENGTH];
}

- (instancetype)hd_sha224String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_SHA224_DIGEST_LENGTH];
    
    CC_SHA224(str, (CC_LONG)strlen(str), buffer);
    
    return [self hd_stringFromBytes:buffer length:CC_SHA224_DIGEST_LENGTH];
}

- (instancetype)hd_sha256String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(str, (CC_LONG)strlen(str), buffer);
    
    return [self hd_stringFromBytes:buffer length:CC_SHA256_DIGEST_LENGTH];
}

- (instancetype)hd_sha384String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_SHA384_DIGEST_LENGTH];
    
    CC_SHA384(str, (CC_LONG)strlen(str), buffer);
    
    return [self hd_stringFromBytes:buffer length:CC_SHA384_DIGEST_LENGTH];
}

- (instancetype)hd_sha512String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_SHA512_DIGEST_LENGTH];
    
    CC_SHA512(str, (CC_LONG)strlen(str), buffer);
    
    return [self hd_stringFromBytes:buffer length:CC_SHA512_DIGEST_LENGTH];
}


#pragma mark - HMAC 散列函数
- (instancetype)hd_hmacMD5StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgMD5, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self hd_stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (instancetype)hd_hmacSHA1StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self hd_stringFromBytes:buffer length:CC_SHA1_DIGEST_LENGTH];
}

- (instancetype)hd_hmacSHA256StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_SHA256_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA256, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self hd_stringFromBytes:buffer length:CC_SHA256_DIGEST_LENGTH];
}

- (instancetype)hd_hmacSHA512StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_SHA512_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA512, keyData, strlen(keyData), strData, strlen(strData), buffer);
    
    return [self hd_stringFromBytes:buffer length:CC_SHA512_DIGEST_LENGTH];
}


#pragma mark - 文件散列函数
#define FileHashDefaultChunkSizeForReadingData 4096
- (instancetype)hd_fileMD5Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) return nil;
    
    CC_MD5_CTX hashCtx;
    CC_MD5_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_MD5_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) break;
        }
    }
    [fp closeFile];
    
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(buffer, &hashCtx);
    
    return [self hd_stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (instancetype)hd_fileSHA1Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) return nil;
    
    CC_SHA1_CTX hashCtx;
    CC_SHA1_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_SHA1_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) break;
        }
    }
    [fp closeFile];
    
    uint8_t buffer[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1_Final(buffer, &hashCtx);
    
    return [self hd_stringFromBytes:buffer length:CC_SHA1_DIGEST_LENGTH];
}

- (instancetype)hd_fileSHA256Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) return nil;
    
    CC_SHA256_CTX hashCtx;
    CC_SHA256_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_SHA256_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) break;
        }
    }
    [fp closeFile];
    
    uint8_t buffer[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256_Final(buffer, &hashCtx);
    
    return [self hd_stringFromBytes:buffer length:CC_SHA256_DIGEST_LENGTH];
}

- (instancetype)hd_fileSHA512Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) return nil;
    
    CC_SHA512_CTX hashCtx;
    CC_SHA512_Init(&hashCtx);
    
    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];
            
            CC_SHA512_Update(&hashCtx, data.bytes, (CC_LONG)data.length);
            
            if (data.length == 0) break;
        }
    }
    [fp closeFile];
    
    uint8_t buffer[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512_Final(buffer, &hashCtx);
    
    return [self hd_stringFromBytes:buffer length:CC_SHA512_DIGEST_LENGTH];
}


#pragma mark - Base64编码
- (instancetype)hd_base64Encode {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    return [data base64EncodedStringWithOptions:0];
}

- (instancetype)hd_base64Decode {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


#pragma mark - 路径方法
+ (instancetype)hd_pathForDocuments {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (instancetype)hd_filePathAtDocumentsWithFileName:(NSString *)fileName {
    return  [[self hd_pathForDocuments] stringByAppendingPathComponent:fileName];
}

+ (instancetype)hd_pathForCaches {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

+ (instancetype)hd_filePathAtCachesWithFileName:(NSString *)fileName {
    return [[self hd_pathForCaches] stringByAppendingPathComponent:fileName];
}

+ (instancetype)hd_pathForMainBundle {
    return [NSBundle mainBundle].bundlePath;
}

+ (instancetype)hd_filePathAtMainBundleWithFileName:(NSString *)fileName {
    return [[self hd_pathForMainBundle] stringByAppendingPathComponent:fileName];
}

+ (instancetype)hd_pathForTemp {
    return NSTemporaryDirectory();
}

+ (instancetype)hd_filePathAtTempWithFileName:(NSString *)fileName {
    return [[self hd_pathForTemp] stringByAppendingPathComponent:fileName];
}

+ (instancetype)hd_pathForPreferences {
    return [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES) lastObject];
}

+ (instancetype)hd_filePathAtPreferencesWithFileName:(NSString *)fileName {
    return [[self hd_pathForPreferences] stringByAppendingPathComponent:fileName];
}

+ (instancetype)hd_pathForSystemFile:(NSSearchPathDirectory)directory {
    return [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) lastObject];
}

+ (instancetype)hd_filePathForSystemFile:(NSSearchPathDirectory)directory withFileName:(NSString *)fileName {
    return [[self hd_pathForSystemFile:directory] stringByAppendingPathComponent:fileName];
}


#pragma mark - 文本计算方法
- (CGSize)hd_sizeWithSystemFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode {
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = mode;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    NSDictionary *attributes = @{NSFontAttributeName : font,
                                 NSParagraphStyleAttributeName : paragraphStyle};
    
    CGRect bounds = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    return CGSizeMake(ceil(bounds.size.width), ceil(bounds.size.height));
}

- (CGSize)hd_sizeWithSystemFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)mode numberOfLine:(NSInteger)numberOfLine {
    CGSize maxSize = [self hd_sizeWithSystemFont:font constrainedToSize:size lineBreakMode:mode];
    CGFloat oneLineHeight = [self hd_sizeWithSystemFont:font constrainedToSize:size lineBreakMode:NSLineBreakByTruncatingTail].height;
    CGFloat height = 0;
    CGFloat limitHeight = oneLineHeight * numberOfLine;
    
    if (maxSize.height > limitHeight) {
        height = limitHeight;
    } else {
        height = maxSize.height;
    }
    
    return CGSizeMake(maxSize.width, height);
}

- (CGSize)hd_sizeWithSystemFont:(UIFont *)font constrainedToSize:(CGSize)size {
    return [self hd_sizeWithSystemFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
}

+ (CGSize)hd_sizeWithText:(NSString *)text systemFont:(UIFont *)font constrainedToSize:(CGSize)size {
    return [text hd_sizeWithSystemFont:font constrainedToSize:size];
}


#pragma mark - 其他
/**
 *  返回二进制 Bytes 流的字符串表示形式
 *
 *  @param bytes  二进制 Bytes 数组
 *  @param length 数组长度
 *
 *  @return 字符串表示形式
 */
- (instancetype)hd_stringFromBytes:(uint8_t *)bytes length:(int)length {
    NSMutableString *strM = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        [strM appendFormat:@"%02x", bytes[i]];
    }
    
    return [strM copy];
}

/**
 *  设备版本
 */
+ (instancetype)hd_deviceVersion {
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    // iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    
    // iPod
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    // iPad
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    if ([deviceString isEqualToString:@"iPad4,4"]
        ||[deviceString isEqualToString:@"iPad4,5"]
        ||[deviceString isEqualToString:@"iPad4,6"])    return @"iPad mini 2";
    
    if ([deviceString isEqualToString:@"iPad4,7"]
        ||[deviceString isEqualToString:@"iPad4,8"]
        ||[deviceString isEqualToString:@"iPad4,9"])    return @"iPad mini 3";
    
    return deviceString;
}


NSString *const iPhone6_6s_7 = @"iPhone6_6s_7";
NSString *const iPhone6_6s_7Plus = @"iPhone6_6s_7Plus";

+ (instancetype)hd_deviceType {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    // iPhone
    if ([deviceString isEqualToString:@"iPhone7,1"])    return iPhone6_6s_7Plus;
    if ([deviceString isEqualToString:@"iPhone7,2"])    return iPhone6_6s_7;
    if ([deviceString isEqualToString:@"iPhone8,1"])    return iPhone6_6s_7;
    if ([deviceString isEqualToString:@"iPhone8,2"])    return iPhone6_6s_7Plus;
    if ([deviceString isEqualToString:@"iPhone9,1"])    return iPhone6_6s_7;
    if ([deviceString isEqualToString:@"iPhone9,2"])    return iPhone6_6s_7Plus;
    if ([deviceString isEqualToString:@"iPhone9,3"])    return iPhone6_6s_7;
    if ([deviceString isEqualToString:@"iPhone9,4"])    return iPhone6_6s_7Plus;
    
    return deviceString;
}

- (BOOL)hd_isValidEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}

- (BOOL)hd_isChinese {
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", match];
    
    return [predicate evaluateWithObject:self];
}

- (BOOL)hd_isValidUrl {
    NSString *regex = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#;$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^;&*+?:_/=<>]*)?)";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [urlTest evaluateWithObject:self];
}

/**
 * 验证是否是手机号
 */
- (BOOL)hd_isValidateMobile {
    if (self.length < 1) {
        return NO;
    }
    
    return YES; // 现在新增手机号段很多_国际别的手机不一定11位_手机号其实没必要限制死!
//    /**
//     * 手机号码
//     * 移动：134[0-8], 135, 136, 137, 138, 139, 150, 151, 157, 158, 159, 182, 187, 188
//     * 联通：130, 131, 132, 152, 155, 156, 185, 186
//     * 电信：133, 1349, 153, 180, 189
//     */
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0235-9])\\d{8}$";
//    /**
//     * 中国移动：China Mobile
//     * 134[0-8], 135, 136, 137, 138, 139, 150, 151, 157, 158, 159, 182, 187, 188
//     */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    /**
//     * 中国联通：China Unicom
//     * 130, 131, 132, 152, 155, 156, 185, 186
//     */
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    /**
//     * 中国电信：China Telecom
//     * 133, 1349, 153, 180, 189
//     */
//    NSString * CT = @"^1((33|53|7[678]|8[09])[0-9]|349)\\d{7}$";
//    /**
//     * 大陆地区固话及小灵通
//     * 区号：010, 020, 021, 022, 023, 024, 025, 027, 028, 029
//     * 号码：七位或八位
//     */
//    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
//    
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    
//    if (([regextestmobile evaluateWithObject:self] == YES)
//        || ([regextestcm evaluateWithObject:self] == YES)
//        || ([regextestct evaluateWithObject:self] == YES)
//        || ([regextestcu evaluateWithObject:self] == YES)) {
//        
//        return YES;
//    } else {
//        return NO;
//    }
}

- (instancetype)limitLength:(NSInteger)length {
    NSString *str = self;
    if (str.length > length) {
        str = [str substringToIndex:length];
    }
    
    return str;
}

@end
