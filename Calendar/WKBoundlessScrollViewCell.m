//
//  WKBoundlessScrollViewCell.m
//  Calendar
//
//  Created by Crane on 16/12/15.
//  Copyright © 2015 GoldITDev All rights reserved.
//

#import "WKBoundlessScrollViewCell.h"
#import "CellDateModel.h"
#import "DateView.h"
#import "DateModel.h"
@interface WKBoundlessScrollViewCell ()
{
    NSInteger _year;
    NSInteger _month;
    NSInteger _day;
    NSInteger _weekday;
}
@end


@implementation WKBoundlessScrollViewCell
-(instancetype)initWithIdentifier:(NSString *)identifier
{
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
    self = [super initWithFrame:frame];
    if (self) {
        self.identifier = identifier;
    }
    return self;
}

-(void)fillDate:(CellDateModel *)cellDateModel
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat width = (self.frame.size.width-20)/7.0;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 5, self.frame.size.width-20, 30)];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    NSString *monthName = [[df monthSymbols] objectAtIndex:(cellDateModel.month-1)];
    label.text = [NSString stringWithFormat:@"%@ %ld",monthName, cellDateModel.year];
    
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor redColor];
    [self addSubview:label];
    for (int i = 0; i < cellDateModel.monthDays; i++) {
        
        DateModel *dateModel = cellDateModel.dateModelArray[i];
        NSInteger column =  dateModel.weekday;
        NSInteger row = (i+cellDateModel.drawDayBeginIndex)/7;
        
        DateView *dateView = [[DateView alloc] initWithFrame:CGRectMake(column*width+10, row*(width+15)+5+30+5, width, width)];
        [dateView fillDate:dateModel];
        [self addSubview:dateView];
        
        
//        if (i == 0) {
//            UIView *view = [[UIView alloc] initWithFrame:CGRectMake((cellDateModel.beginWeekDay-1)*width+10, row*(width+15)+5+30+4, self.frame.size.width-(cellDateModel.beginWeekDay-1)*width-20, 0.5)];
//            view.backgroundColor = [UIColor lightGrayColor];
//            [self addSubview:view];
//        }
//        else
//        {
//            if ((i+cellDateModel.drawDayBeginIndex)%7 == 0) {
//                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, row*(width+15)+5+30+4, self.frame.size.width-20, 0.5)];
//                view.backgroundColor = [UIColor lightGrayColor];
//                [self addSubview:view];
//            }
//        }
        
        
    }
}



-(void)layoutSubviews
{
    [super layoutSubviews];
}


-(void)setDeviation:(NSInteger)deviation
{
    _deviation = deviation;
}








@end
