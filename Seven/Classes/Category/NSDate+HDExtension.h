//
//  NSDate+HDExtension.h
//  PortableTreasure
//
//  Created by HeDong on 15/5/10.
//  Copyright © 2015年 hedong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HDExtension)

/**
 *  返回一个只有年月日的NSDate
 */
- (instancetype)hd_dateWithYMD;

/**
 *  返回一个年月日时分秒毫秒的NSString
 */
- (NSString *)hd_dateWithYMDHMSS;

/**
 *  距离当前的时间间隔描述
 */
- (NSString *)hd_timeIntervalDescription;

/**
 *  精确到分钟的日期描述
 */
- (NSString *)hd_minuteDescription;

/**
 *  标准时间日期描述
 */
- (NSString *)hd_formattedTime;

/**
 *  格式化日期描述
 */
- (NSString *)hd_formattedDateDescription;

/**
 *  获取1970至现在的毫秒
 */
- (NSTimeInterval)hd_timeIntervalSince1970InMilliSecond;

/**
 *  根据1970年至现在的毫秒转为当前的时间NSDate
 */
+ (instancetype)hd_dateWithTimeIntervalInMilliSecondSince1970:(NSTimeInterval)timeIntervalInMilliSecond;

/**
 *  根据1970年至现在的毫秒转为当前的时间NSString
 */
+ (NSString *)hd_formattedTimeFromTimeInterval:(NSTimeInterval)time;

#pragma mark - Relative dates from the current date
+ (instancetype)hd_dateTomorrow;
+ (instancetype)hd_dateYesterday;
+ (instancetype)hd_dateWithDaysFromNow:(NSInteger)days;
+ (instancetype)hd_dateWithDaysBeforeNow:(NSInteger)days;
+ (instancetype)hd_dateWithHoursFromNow:(NSInteger)dHours;
+ (instancetype)hd_dateWithHoursBeforeNow:(NSInteger)dHours;
+ (instancetype)hd_dateWithMinutesFromNow:(NSInteger)dMinutes;
+ (instancetype)hd_dateWithMinutesBeforeNow:(NSInteger)dMinutes;

#pragma mark - Comparing Dates
- (BOOL)hd_isToday;
- (BOOL)hd_isTomorrow;
- (BOOL)hd_isYesterday;
- (BOOL)hd_isThisWeek;
- (BOOL)hd_isNextWeek;
- (BOOL)hd_isLastWeek;
- (BOOL)hd_isThisMonth;
- (BOOL)hd_isThisYear;
- (BOOL)hd_isNextYear;
- (BOOL)hd_isLastYear;
- (BOOL)hd_isInFuture;
- (BOOL)hd_isInPast;
- (BOOL)hd_isLaterThanDate:(NSDate *)aDate;
- (BOOL)hd_isSameWeekAsDate:(NSDate *)aDate;
- (BOOL)hd_isSameYearAsDate:(NSDate *)aDate;
- (BOOL)hd_isEarlierThanDate:(NSDate *)aDate;
- (BOOL)hd_isSameMonthAsDate:(NSDate *)aDate;
- (BOOL)hd_isEqualToDateIgnoringTime:(NSDate *)aDate;

#pragma mark - Roles
- (BOOL)hd_isTypicallyWorkday;
- (BOOL)hd_isTypicallyWeekend;

#pragma mark - Adjusting Dates
- (instancetype)hd_dateAtStartOfDay;
- (instancetype)hd_dateByAddingDays:(NSInteger)dDays;
- (instancetype)hd_dateBySubtractingDays:(NSInteger)dDays;
- (instancetype)hd_dateByAddingHours:(NSInteger)dHours;
- (instancetype)hd_dateBySubtractingHours:(NSInteger)dHours;
- (instancetype)hd_dateByAddingMinutes:(NSInteger)dMinutes;
- (instancetype)hd_dateBySubtractingMinutes:(NSInteger)dMinutes;

#pragma mark - Retrieving Intervals
- (NSInteger)hd_minutesAfterDate:(NSDate *)aDate;
- (NSInteger)hd_minutesBeforeDate:(NSDate *)aDate;
- (NSInteger)hd_hoursAfterDate:(NSDate *)aDate;
- (NSInteger)hd_hoursBeforeDate:(NSDate *)aDate;
- (NSInteger)hd_daysAfterDate:(NSDate *)aDate;
- (NSInteger)hd_daysBeforeDate:(NSDate *)aDate;
- (NSInteger)hd_distanceInDaysToDate:(NSDate *)anotherDate;

#pragma mark - Decomposing Dates
@property (nonatomic, assign, readonly) NSInteger hd_nearestHour;
@property (nonatomic, assign, readonly) NSInteger hd_hour;
@property (nonatomic, assign, readonly) NSInteger hd_minute;
@property (nonatomic, assign, readonly) NSInteger hd_seconds;
@property (nonatomic, assign, readonly) NSInteger hd_day;
@property (nonatomic, assign, readonly) NSInteger hd_month;
@property (nonatomic, assign, readonly) NSInteger hd_week;
@property (nonatomic, assign, readonly) NSInteger hd_weekday;
@property (nonatomic, assign, readonly) NSInteger hd_nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (nonatomic, assign, readonly) NSInteger hd_year;

@end
