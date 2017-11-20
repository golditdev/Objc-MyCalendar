//
//  DateView.m
//  Calendar
//
//  Created by Crane on 18/12/15.
//  Copyright © 2015 GoldITDev All rights reserved.
//

#import "DateView.h"
#import "DateModel.h"
@interface DateView()
{
    UIView *_backgroundView;
}
@end
@implementation DateView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        _solarCalendarLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, width * 0.2, width, height*0.6)];
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        _backgroundView.backgroundColor = [UIColor clearColor];
        _backgroundView.layer.cornerRadius = width/2.0;
        _backgroundView.layer.masksToBounds = YES;
        _highlightView = [[UIView alloc] initWithFrame:CGRectMake((width - 5)/2, height*0.6 + 10, 5, 5 )];
        _highlightView.backgroundColor = [UIColor redColor];
        _highlightView.layer.cornerRadius = 2.5;
        _highlightView.layer.masksToBounds = YES;
        _highlightView.hidden = YES;
        [self addSubview:_backgroundView];
        [self addSubview:_solarCalendarLabel];
        [self addSubview:_highlightView];
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _backgroundView.backgroundColor = [UIColor colorWithWhite:0.923 alpha:1.000];

}


-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _backgroundView.backgroundColor = [UIColor clearColor];

}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _backgroundView.backgroundColor = [UIColor clearColor];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DID_SELETED_DATEVIEW" object:nil userInfo:@{@"dateModel":self.dateModel}];
}


-(void)fillDate:(DateModel *)dateModel
{
    _dateModel = dateModel;
    self.solarCalendarLabel.text = [NSString stringWithFormat:@"%ld",dateModel.day];
 
    unsigned units = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];
    
    if (dateModel.year == year && dateModel.month == month && dateModel.day == day) {
        _highlightView.hidden = NO;
    } else {
        _highlightView.hidden = YES;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.solarCalendarLabel.textAlignment = NSTextAlignmentCenter;
}



@end
