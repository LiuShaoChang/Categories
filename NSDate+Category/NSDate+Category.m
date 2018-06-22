//
//  NSDate+Category.m
//  YjyxParent
//
//  Created by 刘少昌 on 2018/6/13.
//  Copyright © 2018年 YJYX. All rights reserved.
//

#import "NSDate+Category.h"

@implementation NSDate (Category)

- (NSString*)toString:(NSString*)format withTimeZone:(NSTimeZone*)timeZone
{
    if (timeZone == nil) {
        timeZone = [NSTimeZone systemTimeZone];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setTimeZone:timeZone];
    return [formatter stringFromDate:self];
}

- (NSInteger)year
{
    return [[[self description] substringWithRange:NSMakeRange(0, 4)] integerValue];
}

- (NSInteger)month
{
    return [[[self description] substringWithRange:NSMakeRange(4, 2)] integerValue];
}

- (NSInteger)day
{
    return [[[self description] substringWithRange:NSMakeRange(8, 2)] integerValue];
}

- (NSInteger)hour
{
    return [[[self description] substringWithRange:NSMakeRange(11, 2)] integerValue];
}

- (NSInteger)minute
{
    return [[[self description] substringWithRange:NSMakeRange(14, 2)] integerValue];
}

- (NSInteger)second
{
    return [[[self description] substringWithRange:NSMakeRange(17, 2)] integerValue];
}

- (NSString*)weekDay
{
    NSDateComponents *components = self.calender;
    NSMutableString *week = [NSMutableString stringWithCapacity:0];
    switch (components.weekday)//星期几（注意，周日是“1”，周一是“2”。。。。）
    {
        case 0:
            [week appendString:NSLocalizedString(@"Saturday",nil)];
            break;
        case 1:
            [week appendString:NSLocalizedString(@"Sunday",nil)];
            break;
        case 2:
            [week appendString:NSLocalizedString(@"Monday",nil)];
            break;
        case 3:
            [week appendString:NSLocalizedString(@"Tuesday",nil)];
            break;
        case 4:
            [week appendString:NSLocalizedString(@"Wednesday",nil)];
            break;
        case 5:
            [week appendString:NSLocalizedString(@"Thursday",nil)];
            break;
        case 6:
            [week appendString:NSLocalizedString(@"Friday",nil)];
            break;
            
    }
    return week;
}

- (NSDateComponents*)calender
{
    return [[NSCalendar currentCalendar] components:(NSEraCalendarUnit
                                                     |NSYearCalendarUnit
                                                     |NSMonthCalendarUnit
                                                     |NSDayCalendarUnit
                                                     |NSHourCalendarUnit
                                                     |NSMinuteCalendarUnit
                                                     |NSSecondCalendarUnit
                                                     |NSWeekCalendarUnit
                                                     |NSWeekdayCalendarUnit
                                                     |NSWeekdayOrdinalCalendarUnit
                                                     |NSQuarterCalendarUnit
                                                     |NSWeekOfMonthCalendarUnit
                                                     |NSWeekOfYearCalendarUnit
                                                     |NSYearForWeekOfYearCalendarUnit
                                                     |NSCalendarCalendarUnit
                                                     |NSTimeZoneCalendarUnit)
                                           fromDate:self];
}

+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
}

/**
 * 比较两个日期是不是同一天
 * @returned    比较两个日期是不是同一天(今天 是 anotherday的过去/同一天/将来)
 */
+(DATE_TIME)compareCurrentDayWithAnotherDay:(NSDate *)anotherDay {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    BOOL isInToday = [calendar isDateInToday:anotherDay];
    if (isInToday) {
        return DATE_TIME_ONEDAY;
    }else {
        
        NSDate *currentDate = [NSDate date];
        int result = [self compareOneDay:currentDate withAnotherDay:anotherDay];
        if (result == 1) {
            return DATE_TIME_FUTURE;
        }else {
            return DATE_TIME_PAST;
        }
        
    }
    
}

//返回日期的00:00时间
- (NSDate*)dayForBegin
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:self];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    return [calendar dateFromComponents:components];
}

//返回日期的23:59时间
- (NSDate*)dayForEnd
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:self];
    [components setHour:23];
    [components setMinute:59];
    [components setSecond:59];
    return [calendar dateFromComponents:components];
}

@end
