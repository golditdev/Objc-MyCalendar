//
//  DateTools.m
//  Calendar
//
//  Created by Crane on 18/12/15.
//  Copyright © 2015 GoldITDev All rights reserved.
//

#import "DateTools.h"
#import "CellDateModel.h"
#import "DateModel.h"

@implementation DateTools
+(CellDateModel *)dateToCell:(NSInteger)deviation
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:30];
    
    NSDateComponents *components = [DateTools getCellMonthDate:deviation];
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];
    NSInteger weekday = [components weekday];
    NSInteger monthDays = [DateTools getMonthDays:month year:year];
    CellDateModel *cellDateModel = [[CellDateModel alloc] init];
    cellDateModel.year = year;
    cellDateModel.month = month;
    cellDateModel.monthDays = monthDays;
    cellDateModel.beginWeekDay = weekday;
    
    NSInteger row = 0;
    NSInteger dayBeginIndex = weekday-1;
    if((monthDays + dayBeginIndex)%7 == 0){
        row = (monthDays + dayBeginIndex)/7;
    }else{
        row = (monthDays + dayBeginIndex)/7 + 1;
    }
    cellDateModel.drawDayRow = row;
    cellDateModel.drawDayBeginIndex = dayBeginIndex;
    for (int i = 0; i < monthDays; i++) {
        DateModel *dateModel = [[DateModel alloc] init];
        dateModel.year = year;
        dateModel.month = month;
        dateModel.day = day;
        dateModel.weekday = (dayBeginIndex+day-1)%7;        
        day++;
        [array addObject:dateModel];
    }
    cellDateModel.dateModelArray = array;
    return cellDateModel;
}


+(NSInteger)getDrawRow:(NSInteger)deviation
{
    NSDateComponents *components = [DateTools getCellMonthDate:deviation];
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger weekday = [components weekday];
    NSInteger monthDays = [DateTools getMonthDays:month year:year];
    NSInteger row = 0;
    NSInteger dayBeginIndex = weekday-1;
    if((monthDays + dayBeginIndex)%7 == 0){
        row = (monthDays + dayBeginIndex)/7;
    }else{
        row = (monthDays + dayBeginIndex)/7 + 1;
    }
    return row;
}


+(NSDateComponents *)getCurrentDate
{
    unsigned units = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitWeekday;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    
    return components;
}


+(NSDateComponents *)getCellMonthDate:(NSInteger)deviation
{
    NSDateComponents *comps = [DateTools getCurrentDate];
    NSInteger month = [comps month];
    NSInteger year = [comps year];
    NSInteger yearDeviation;
    NSInteger monthDeviation;
    if (deviation > 0) {
        yearDeviation = deviation/12;
        monthDeviation = deviation % 12;
        if (monthDeviation+month > 12 ) {
            month = monthDeviation + month - 12;
            yearDeviation++;
        } else {
            month = month + monthDeviation;
        }
    } else {
        yearDeviation = deviation / 12;
        monthDeviation = deviation % 12;
        if (monthDeviation + month <= 0) {
            month = month + monthDeviation + 12;
            yearDeviation--;
        } else {
            month = month + monthDeviation;
        }
    }
    year = year + yearDeviation;
    NSString* string;
    if(month < 10)
    {
        string = [NSString stringWithFormat:@"%ld0%ld01",year,month];
    } else {
        string = [NSString stringWithFormat:@"%ld%ld01",year,month];
    }
    NSLog(@"%@",string);
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    inputFormatter.timeZone = [NSTimeZone systemTimeZone];
    [inputFormatter setDateFormat:@"yyyyMMdd"];
    NSDate* inputDate = [inputFormatter dateFromString:string];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    components = [calendar components:unitFlags fromDate:inputDate];
    return components;
}

+(NSInteger)getMonthDays:(NSInteger)month year:(NSInteger)year
{
    if (month<=0 || month > 12) {
        return 0;
    }
    BOOL isLeapYear = [DateTools isLeapYear:year];
    int  februaryDay;
    if (isLeapYear) {
        februaryDay = 29;
    }
    else
    {
        februaryDay = 28;
    }
    
    if (month == 1||month == 3||month == 5||month == 7||month == 8||month == 10||month == 12) {
        return 31;
    } else if (month == 4||month ==6||month ==9||month ==11) {
        return 30;
    }else {
        return februaryDay;
    }
}

+(BOOL)isLeapYear:(NSInteger)year{
    if ((year % 4  == 0 && year % 100 != 0)|| year % 400 == 0)
        return YES;
    else
        return NO;
}

@end
