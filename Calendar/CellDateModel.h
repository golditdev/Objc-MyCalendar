//
//  CellDateModel.h
//  Calendar
//
//  Created by Crane on 18/12/15.
//  Copyright © 2015 GoldITDev All rights reserved.
//

#import <Foundation/Foundation.h>

@class DateModel;
@interface CellDateModel : NSObject
@property(nonatomic,strong)NSArray <__kindof DateModel *> *dateModelArray;
@property(nonatomic,assign)NSInteger drawDayBeginIndex;
@property(nonatomic,assign)NSInteger drawDayRow;
@property(nonatomic,assign)NSInteger year;
@property(nonatomic,assign)NSInteger month;
@property(nonatomic,assign)NSInteger monthDays;
@property(nonatomic,assign)NSInteger beginWeekDay;
@end
