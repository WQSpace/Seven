//
//  NSDate+HDExtension.m
//  PortableTreasure
//
//  Created by HeDong on 15/5/10.
//  Copyright © 2015年 hedong. All rights reserved.
//

#import "NSDate+HDExtension.h"
#import "NSDateFormatter+HDExtension.h"

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

#define DATE_COMPONENTS (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | \
                         NSCalendarUnitWeekOfMonth |  NSCalendarUnitHour | NSCalendarUnitMinute | \
                         NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

@implementation NSDate (HDExtension)

- (instancetype)hd_dateWithYMD {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [dateFormatter stringFromDate:self];
    
    return [dateFormatter dateFromString:selfStr];
}

- (NSString *)hd_dateWithYMDHMSS {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    
    return [dateFormatter stringFromDate:self];
}

- (NSString *)hd_timeIntervalDescription {
    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];
    
    if (timeInterval < 60) {
        return NSLocalizedString(TimeText1, @"");
    } else if (timeInterval < 3600) {
        return [NSString stringWithFormat:NSLocalizedString(TimeText2, @""), timeInterval / 60];
    } else if (timeInterval < 86400) {
        return [NSString stringWithFormat:NSLocalizedString(TimeText3, @""), timeInterval / 3600];
    } else if (timeInterval < 2592000) { // 30天内
        return [NSString stringWithFormat:NSLocalizedString(TimeText4, @""), timeInterval / 86400];
    } else if (timeInterval < 31536000) { // 30天至1年内
        NSDateFormatter *dateFormatter = [NSDateFormatter hd_dateFormatterWithFormat:NSLocalizedString(TimeText5, @"")];
        return [dateFormatter stringFromDate:self];
    } else {
        return [NSString stringWithFormat:NSLocalizedString(TimeText6, @""), timeInterval / 31536000];
    }
}

- (NSString *)hd_minuteDescription {
    NSDateFormatter *dateFormatter = [NSDateFormatter hd_dateFormatterWithFormat:@"yyyy-MM-dd"];
    
    NSString *theDay = [dateFormatter stringFromDate:self];
    NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];
    
    if ([theDay isEqualToString:currentDay]) { // 当天
        [dateFormatter setDateFormat:@"ah:mm"];
        return [dateFormatter stringFromDate:self];
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] == 86400) { // 昨天
        [dateFormatter setDateFormat:@"ah:mm"];
        return [NSString stringWithFormat:NSLocalizedString(TimeText7, @""), [dateFormatter stringFromDate:self]];
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] < 86400 * 7) { // 间隔一周内
        [dateFormatter setDateFormat:@"EEEE ah:mm"];
        return [dateFormatter stringFromDate:self];
    } else { // 以前
        [dateFormatter setDateFormat:@"yyyy-MM-dd ah:mm"];
        return [dateFormatter stringFromDate:self];
    }
}

-(NSString *)hd_formattedTime {
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString * dateNow = [formatter stringFromDate:[NSDate date]];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:[[dateNow substringWithRange:NSMakeRange(8,2)] intValue]];
    [components setMonth:[[dateNow substringWithRange:NSMakeRange(5,2)] intValue]];
    [components setYear:[[dateNow substringWithRange:NSMakeRange(0,4)] intValue]];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:components]; // 今天0点时间
    
    NSInteger hour = [self hd_hoursAfterDate:date];
    NSDateFormatter *dateFormatter = nil;
    NSString *ret = @"";
    
    // hasAMPM == TURE为12小时制,否则为24小时制.
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    
    if (!hasAMPM) { // 24小时制
        if (hour <= 24 && hour >= 0) {
            dateFormatter = [NSDateFormatter hd_dateFormatterWithFormat:@"HH:mm"];
        } else if (hour < 0 && hour >= -24) {
            dateFormatter = [NSDateFormatter hd_dateFormatterWithFormat:NSLocalizedString(TimeText8, @"")];
        } else {
            dateFormatter = [NSDateFormatter hd_dateFormatterWithFormat:@"yyyy-MM-dd HH:mm"];
        }
    } else {
        if (hour >= 0 && hour <= 6) {
            dateFormatter = [NSDateFormatter hd_dateFormatterWithFormat:NSLocalizedString(TimeText9, @"")];
        } else if (hour > 6 && hour <=11 ) {
            dateFormatter = [NSDateFormatter hd_dateFormatterWithFormat:NSLocalizedString(TimeText10, @"")];
        } else if (hour > 11 && hour <= 17) {
            dateFormatter = [NSDateFormatter hd_dateFormatterWithFormat:NSLocalizedString(TimeText11, @"")];
        } else if (hour > 17 && hour <= 24) {
            dateFormatter = [NSDateFormatter hd_dateFormatterWithFormat:NSLocalizedString(TimeText12, @"")];
        } else if (hour < 0 && hour >= -24) {
            dateFormatter = [NSDateFormatter hd_dateFormatterWithFormat:NSLocalizedString(TimeText13, @"")];
        } else {
            dateFormatter = [NSDateFormatter hd_dateFormatterWithFormat:@"yyyy-MM-dd HH:mm"];
        }
    }
    
    ret = [dateFormatter stringFromDate:self];
    return ret;
}

- (NSString *)hd_formattedDateDescription {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *theDay = [dateFormatter stringFromDate:self];
    NSString *currentDay = [dateFormatter stringFromDate:[NSDate date]];
    NSInteger timeInterval = -[self timeIntervalSinceNow];
    
    if (timeInterval < 60) {
        return NSLocalizedString(TimeText1, @"");
    } else if (timeInterval < 3600) { // 1小时内
        return [NSString stringWithFormat:NSLocalizedString(TimeText2, @""), timeInterval / 60];
    } else if (timeInterval < 21600) { // 6小时内
        return [NSString stringWithFormat:NSLocalizedString(TimeText3, @""), timeInterval / 3600];
    } else if ([theDay isEqualToString:currentDay]) { // 当天
        [dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:NSLocalizedString(TimeText14, @""), [dateFormatter stringFromDate:self]];
    } else if ([[dateFormatter dateFromString:currentDay] timeIntervalSinceDate:[dateFormatter dateFromString:theDay]] == 86400) { // 昨天
        [dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:NSLocalizedString(TimeText7, @""), [dateFormatter stringFromDate:self]];
    } else { // 以前
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        return [dateFormatter stringFromDate:self];
    }
}

- (NSTimeInterval)hd_timeIntervalSince1970InMilliSecond {
    NSTimeInterval ret;
    ret = [self timeIntervalSince1970] * 1000;
    
    return ret;
}

+ (instancetype)hd_dateWithTimeIntervalInMilliSecondSince1970:(NSTimeInterval)timeIntervalInMilliSecond {
    NSDate *ret = nil;
    NSTimeInterval timeInterval = timeIntervalInMilliSecond;

    if (timeIntervalInMilliSecond > 140000000000) {
        timeInterval = timeIntervalInMilliSecond / 1000;
    }
    
    ret = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    return ret;
}

+ (NSString *)hd_formattedTimeFromTimeInterval:(NSTimeInterval)time {
    return [[NSDate hd_dateWithTimeIntervalInMilliSecondSince1970:time] hd_formattedTime];
}

#pragma mark - Relative dates from the current date
+ (instancetype)hd_dateWithDaysFromNow:(NSInteger)days {
    return [[NSDate date] hd_dateByAddingDays:days];
}

+ (instancetype)hd_dateWithDaysBeforeNow:(NSInteger)days {
    return [[NSDate date] hd_dateBySubtractingDays:days];
}

+ (instancetype)hd_dateTomorrow {
    return [NSDate hd_dateWithDaysFromNow:1];
}

+ (instancetype)hd_dateYesterday {
    return [NSDate hd_dateWithDaysBeforeNow:1];
}

+ (instancetype)hd_dateWithHoursFromNow:(NSInteger)dHours {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (instancetype)hd_dateWithHoursBeforeNow:(NSInteger)dHours {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (instancetype)hd_dateWithMinutesFromNow:(NSInteger)dMinutes {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (instancetype)hd_dateWithMinutesBeforeNow:(NSInteger)dMinutes {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark - Comparing Dates
- (BOOL)hd_isEqualToDateIgnoringTime:(NSDate *)aDate {
    NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

- (BOOL)hd_isToday {
    return [self hd_isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL)hd_isTomorrow {
    return [self hd_isEqualToDateIgnoringTime:[NSDate hd_dateTomorrow]];
}

- (BOOL)hd_isYesterday {
    return [self hd_isEqualToDateIgnoringTime:[NSDate hd_dateYesterday]];
}

// 设定为一周7天
- (BOOL)hd_isSameWeekAsDate:(NSDate *)aDate {
    NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
    
    if (components1.weekOfMonth != components2.weekOfMonth) return NO;
    
    return (fabs([self timeIntervalSinceDate:aDate]) < D_WEEK);
}

- (BOOL)hd_isThisWeek {
    return [self hd_isSameWeekAsDate:[NSDate date]];
}

- (BOOL)hd_isNextWeek {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self hd_isSameWeekAsDate:newDate];
}

- (BOOL)hd_isLastWeek {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self hd_isSameWeekAsDate:newDate];
}

- (BOOL)hd_isSameMonthAsDate:(NSDate *)aDate {
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL)hd_isThisMonth {
    return [self hd_isSameMonthAsDate:[NSDate date]];
}

- (BOOL)hd_isSameYearAsDate:(NSDate *)aDate {
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:aDate];
    return (components1.year == components2.year);
}

- (BOOL)hd_isThisYear {
    return [self hd_isSameYearAsDate:[NSDate date]];
}

- (BOOL)hd_isNextYear {
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year + 1));
}

- (BOOL)hd_isLastYear {
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year - 1));
}

- (BOOL)hd_isEarlierThanDate:(NSDate *)aDate {
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL)hd_isLaterThanDate:(NSDate *)aDate {
    return ([self compare:aDate] == NSOrderedDescending);
}

- (BOOL)hd_isInFuture {
    return ([self hd_isLaterThanDate:[NSDate date]]);
}

- (BOOL)hd_isInPast {
    return ([self hd_isEarlierThanDate:[NSDate date]]);
}

#pragma mark - Roles
- (BOOL)hd_isTypicallyWeekend {
    NSDateComponents *components = [CURRENT_CALENDAR components:NSCalendarUnitWeekday fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL)hd_isTypicallyWorkday {
    return ![self hd_isTypicallyWeekend];
}

#pragma mark - Adjusting Dates
- (instancetype)hd_dateByAddingDays:(NSInteger)dDays {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_DAY * dDays;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (instancetype)hd_dateBySubtractingDays:(NSInteger)dDays {
    return [self hd_dateByAddingDays: (dDays * -1)];
}

- (instancetype)hd_dateByAddingHours:(NSInteger)dHours {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (instancetype)hd_dateBySubtractingHours:(NSInteger)dHours {
    return [self hd_dateByAddingHours: (dHours * -1)];
}

- (instancetype)hd_dateByAddingMinutes:(NSInteger)dMinutes {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (instancetype)hd_dateBySubtractingMinutes:(NSInteger)dMinutes {
    return [self hd_dateByAddingMinutes: (dMinutes * -1)];
}

- (instancetype)hd_dateAtStartOfDay {
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDateComponents *)hd_componentsWithOffsetFromDate:(NSDate *)aDate {
    NSDateComponents *dTime = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate toDate:self options:0];
    return dTime;
}

#pragma mark - Retrieving Intervals
- (NSInteger)hd_minutesAfterDate:(NSDate *)aDate {
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger)hd_minutesBeforeDate:(NSDate *)aDate {
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger)hd_hoursAfterDate:(NSDate *)aDate {
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger)hd_hoursBeforeDate:(NSDate *)aDate {
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger)hd_daysAfterDate:(NSDate *)aDate {
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_DAY);
}

- (NSInteger)hd_daysBeforeDate:(NSDate *)aDate {
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_DAY);
}

// I have not yet thoroughly tested this(我还没有彻底的测试)
- (NSInteger)hd_distanceInDaysToDate:(NSDate *)anotherDate {
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    return components.day;
}

#pragma mark - Decomposing Dates
- (NSInteger)hd_nearestHour {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [CURRENT_CALENDAR components:NSCalendarUnitHour fromDate:newDate];
    return components.hour;
}

- (NSInteger)hd_hour {
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.hour;
}

- (NSInteger)hd_minute {
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.minute;
}

- (NSInteger)hd_seconds {
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.second;
}

- (NSInteger)hd_day {
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.day;
}

- (NSInteger)hd_month {
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.month;
}

- (NSInteger)hd_week {
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.weekOfMonth;
}

- (NSInteger)hd_weekday {
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.weekday;
}

- (NSInteger)hd_nthWeekday {
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.weekdayOrdinal;
}

- (NSInteger)hd_year {
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return components.year;
}

@end
