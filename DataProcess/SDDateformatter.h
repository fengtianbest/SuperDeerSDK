//
//  SDDateformatter.h
//  SuperDeer
//
//  Created by liulei on 2018/7/30.
//  Copyright © 2018年 NHN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDDateformatter : NSDateFormatter

+ (SDDateformatter *)sharedInstance;

///-----------------------------------------
/// @name format
///-----------------------------------------

- (void)changeToDefaultDateFormat;
- (void)changeDateFormatToString:(NSString *)string;

///-----------------------------------------
/// @name today
///-----------------------------------------

- (NSString *)todayDateString;
- (NSString *)monthBeginDateString;
- (NSString *)monthEndDateString;
- (NSString *)weekBeginDateString;
- (NSString *)weekEndDateString;
- (NSString *)recentDateString;
- (NSString *)weekDayString;

///-----------------------------------------
/// @name one day
///-----------------------------------------

- (NSString *)monthBeginDateStringWithString:(NSString *)day;
- (NSString *)weekBeginDateStringWithString:(NSString *)day;
- (NSInteger)getWeekDayForDate;

///-----------------------------------------
/// @name array
///-----------------------------------------
- (NSArray *)getSevenTimeAry;

@end
