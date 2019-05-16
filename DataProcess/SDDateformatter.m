//
//  SDDateformatter.m
//  SuperDeer
//
//  Created by liulei on 2018/7/30.
//  Copyright © 2018年 NHN. All rights reserved.
//

#import "SDDateformatter.h"

@interface SDDateformatter () {
    
    NSCalendar *_calendar;
}

@end

static SDDateformatter *kSDDateformatterInstance = nil;
static NSString *defaultDateFormat = @"yyyy-MM-dd";

@implementation SDDateformatter

+ (SDDateformatter *)sharedInstance
{
    @synchronized(self)
    {
        if (kSDDateformatterInstance == nil)
        {
            kSDDateformatterInstance = [[SDDateformatter alloc] init];
            kSDDateformatterInstance.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
            kSDDateformatterInstance.dateFormat = defaultDateFormat;
        }
    }
    return kSDDateformatterInstance;
}

- (void)changeDateFormatToString:(NSString *)string {
    
    self.dateFormat = string;
}

- (void)changeToDefaultDateFormat {
    
    self.dateFormat = defaultDateFormat;
}

- (NSString *)todayDateString {
    
    NSDate *now = [NSDate date];
    NSString *dateString = [self stringFromDate:now];
    
    return dateString;
}

- (NSString *)weekDayString
{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 指定日历的算法
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    // 1 是周日，2是周一 3.以此类推
    NSNumber * weekNumber = @([comps weekday]);
    NSInteger weekInt = [weekNumber integerValue];
    
    return [self parseWeek:[NSString stringWithFormat:@"%ld",(long)weekInt]];
}

- (NSString *)recentDateString {
    
    if (!_calendar) {
        _calendar = [NSCalendar currentCalendar];
    }
    NSDateComponents *components = [_calendar components:NSCalendarUnitDay fromDate:[[NSDate alloc] init]];
    [components setDay:-7];
    
    NSDate *now = [NSDate date];
    NSDate *recent = [_calendar dateByAddingComponents:components toDate:now options:0];
    NSString *dateString = [self stringFromDate:recent];
    
    return dateString;
}

- (NSString *)monthBeginDateString {
    
    return [self getFirstAndLastDayOfThisMonthWithDate:[NSDate date] isFirst:YES];
}

- (NSString *)monthEndDateString {
    
    return [self getFirstAndLastDayOfThisMonthWithDate:[NSDate date] isFirst:NO];
}

- (NSString *)weekBeginDateString {
    
    return [self getFirstAndLastDayOfThisWeekWithDate:[NSDate date] isFirst:YES];
}

- (NSString *)weekEndDateString {
    
    return [self getFirstAndLastDayOfThisWeekWithDate:[NSDate date] isFirst:NO];
}

- (NSString *)monthBeginDateStringWithString:(NSString *)day {
    
    return [self getFirstAndLastDayOfThisMonthWithDate:[self dateFromString:day] isFirst:YES];
}

- (NSString *)weekBeginDateStringWithString:(NSString *)day {
    
    return [self getFirstAndLastDayOfThisWeekWithDate:[self dateFromString:day] isFirst:YES];
}

- (NSString *)getFirstAndLastDayOfThisWeekWithDate:(NSDate *)date isFirst:(BOOL)isFirst
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    NSInteger weekday = [dateComponents weekday];   //第几天(从sunday开始)
    NSInteger firstDiff,lastDiff;
    if (weekday == 1) {
        firstDiff = -6;
        lastDiff = 0;
    }else {
        firstDiff =  - weekday + 2;
        lastDiff = 8 - weekday;
    }
    
    NSInteger day = [dateComponents day];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    if (isFirst) {
        [components setDay:day+firstDiff];
        NSDate *firstDay = [calendar dateFromComponents:components];
        NSString *dateString = [self stringFromDate:firstDay];
        
        return dateString;
    }
    else {
        [components setDay:day+lastDiff];
        NSDate *lastDay = [calendar dateFromComponents:components];
        NSString *dateString = [self stringFromDate:lastDay];
        
        return dateString;
    }
}

- (NSString *)getFirstAndLastDayOfThisMonthWithDate:(NSDate *)date isFirst:(BOOL)isFirst
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSString *dateString;
    NSDate *firstDay;
    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&firstDay interval:nil forDate:date];
    dateString = [self stringFromDate:firstDay];
    if (isFirst) {
        return dateString;
    }
    NSDateComponents *lastDateComponents = [calendar components:NSCalendarUnitMonth | NSCalendarUnitYear |NSCalendarUnitDay fromDate:firstDay];
    NSUInteger dayNumberOfMonth = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
    NSInteger day = [lastDateComponents day];
    [lastDateComponents setDay:day+dayNumberOfMonth-1];
    NSDate *lastDay = [calendar dateFromComponents:lastDateComponents];
    dateString = [self stringFromDate:lastDay];
    
    return dateString;
}

- (NSString *)parseWeek:(NSString *)week {
    
    if ([week containsString:@"1"]) {
        return @"周日";
    }
    else if ([week containsString:@"2"]) {
        return @"周一";
    }
    else if ([week containsString:@"3"]) {
        return @"周二";
    }
    else if ([week containsString:@"4"]) {
        return @"周三";
    }
    else if ([week containsString:@"5"]) {
        return @"周四";
    }
    else if ([week containsString:@"6"]) {
        return @"周五";
    }
    else if ([week containsString:@"7"] || [week isEqualToString:@"0"]) {
        return @"周六";
    }
    else {
        return @"";
    }
}

- (NSInteger)getWeekDayForDate:(NSDate *)date {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    comps = [calendar components:unitFlags fromDate:date];
    
    return [comps weekday] - 1;
}

- (NSArray *)getSevenTimeAry {
    
    NSMutableArray *weekAry = [NSMutableArray array];
    NSDate *nowDate = [NSDate date];
    NSDate *theDate;
    NSString* str;
    for (int index = 0; index < 7; index++) {
        NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
        
        theDate = [nowDate initWithTimeIntervalSinceNow: +oneDay*index];
        str = [kSDDateformatterInstance stringFromDate:theDate];
        [weekAry addObject:str];
    }
    
    return weekAry;
}


@end
