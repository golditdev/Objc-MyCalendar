//
//  DateTools.h
//  Calendar
//
//  Created by Crane on 18/12/15.
//  Copyright © 2015 GoldITDev All rights reserved.
//

#import <Foundation/Foundation.h>
@class CellDateModel;
@interface DateTools : NSObject

+(CellDateModel *)dateToCell:(NSInteger)deviation;
+(NSInteger)getDrawRow:(NSInteger)deviation;
+(NSDateComponents *)getCurrentDate;
+(NSDateComponents *)getCellMonthDate:(NSInteger)deviation;

@end
