//
//  HDDDLogManager.m
//  Test
//
//  Created by HeDong on 16/7/28.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import "HDDDLogManager.h"
#import "NSDate+HDExtension.h"

@implementation HDDDLogManager

+ (void)configDDLog {
#ifdef DEBUG
    [self setUpDDLogger];
#else
    
#endif
}

+ (void)setUpDDLogger {
    DDTTYLogger *logger = [DDTTYLogger sharedInstance]; // 将log发送给Xcode的控制台.
    [DDLog addLogger:logger];
    
    [logger setColorsEnabled:YES]; // 启用颜色区分
    [logger setForegroundColor:[UIColor greenColor] backgroundColor:nil forFlag:LOG_FLAG_INFO];
    [logger setForegroundColor:[UIColor blueColor] backgroundColor:nil forFlag:LOG_FLAG_VERBOSE];
    [logger setLogFormatter:[[self alloc] init]]; // 自定义消息格式
    
    HDLogInfo(@"开启日志系统");
    
    //    [DDLog addLogger:[DDASLLogger sharedInstance]]; // 将log发送给苹果服务器,之后在 Console.app中可以查看.
    
    //    DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // 将log写入文件.
    //    fileLogger.rollingFrequency = 660 * 660 * 24; // 保存周期 24 hour rolling
    //    fileLogger.logFileManager.maximumNumberOfLogFiles = 7; // 最大的日志文件数量
    //    [DDLog addLogger:fileLogger];
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    NSMutableDictionary *logDict = [NSMutableDictionary dictionary];
    NSString *locationString; // 取得文件名
    
    NSArray *parts = [logMessage->_file componentsSeparatedByString:@"/"];
    if (parts.count > 0) {
        locationString = [parts lastObject];
    }
    if (locationString.length == 0) {
        locationString = @"No file";
    }
    
    NSString *dateStr = [logMessage->_timestamp hd_dateWithYMDHMSS];
    
    logDict[@"location"] = [NSString stringWithFormat:@"%@ [%@:(%zd lines)][%@] %@", dateStr, locationString, logMessage->_line, logMessage->_function, logMessage->_message];
    
    return logDict[@"location"];
    
    /*** 如果需求上传服务器,则转化为Json数据上传服务器(看交互格式自行转化) ***/
    //    NSError *error;
    //    NSData *outputJson = [NSJSONSerialization dataWithJSONObject:logDict options:0 error:&error];
    //    if (error) {
    //        return @"{\"location\":\"error\"}";
    //    }
    //
    //    NSString *jsonString = [[NSString alloc] initWithData:outputJson encoding:NSUTF8StringEncoding];
    //    if (jsonString) return jsonString;
    //    
    //    return @"{\"location\":\"error\"}";
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Override Me
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (instancetype)init {
    if (self = [super init]) {
        _saveThreshold = 500;
        _saveInterval = 60;           // 60 seconds
        _maxAge = (60 * 60 * 24 * 7); // 7 days
        _deleteInterval = (60 * 5);   // 5 minutes
    }
    
    return self;
}

- (BOOL)db_log:(DDLogMessage *)logMessage {
    // Override me and add your implementation.
    //
    // Return YES if an item was added to the buffer.
    // Return NO if the logMessage was ignored.
    
    return NO;
}

- (void)db_save {
    // Override me and add your implementation.
}

- (void)db_delete {
    // Override me and add your implementation.
}

- (void)db_saveAndDelete {
    // Override me and add your implementation.
}

@end
