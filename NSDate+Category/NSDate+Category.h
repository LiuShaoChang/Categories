//
//  NSDate+Category.h
//  YjyxParent
//
//  Created by 刘少昌 on 2018/6/13.
//  Copyright © 2018年 YJYX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    DATE_TIME_PAST,         // 过去
    DATE_TIME_ONEDAY,       // 同一天
    DATE_TIME_FUTURE,       // 将来
} DATE_TIME;

@interface NSDate (Category)

/**
 * 时间格式化为字串
 * @param       format 时间格式
 * @returned    转换后的字串
 */
- (NSString*)toString:(NSString*)format withTimeZone:(NSTimeZone*)timeZone;

/**
 * 时间的年
 * @returned    日期年的整数
 */
- (NSInteger)year;

/**
 * 时间的月
 * @returned    日期月的整数
 */
- (NSInteger)month;

/**
 * 时间的日
 * @returned    日期日的整数
 */
- (NSInteger)day;

/**
 * 时间的时
 * @returned    日期时的整数
 */
- (NSInteger)hour;

/**
 * 时间的分
 * @returned    日期分的整数
 */
- (NSInteger)minute;

/**
 * 时间的秒
 * @returned    日期秒的整数
 */
- (NSInteger)second;

/**
 * 获取日期是星期几
 * @returned    星期几
 */
- (NSString*)weekDay;

/**
 * 日期日历对象
 * @returned    日期日历对象
 */
- (NSDateComponents*)calender;

/**
 * 比较两个日期大小
 * @returned    比较两个日期大小(oneday 是 anotherday的过去/同一天/将来)
 */
+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

/**
 * 比较两个日期是不是同一天
 * @returned    比较两个日期是不是同一天(oneday 是 anotherday的过去/同一天/将来)
 */
+(DATE_TIME)compareCurrentDayWithAnotherDay:(NSDate *)anotherDay;

//返回日期的00:00时间
- (NSDate*)dayForBegin;
//返回日期的23:59时间
- (NSDate*)dayForEnd;

@end
