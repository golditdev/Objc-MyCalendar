//
//  ViewController.m
//  Calendar
//
//  Created by Crane on 15/12/15.
//  Copyright © 2015 GoldITDev All rights reserved.
//

#import "ViewController.h"
#import "WKBoundlessScrollView.h"
#import "WKBoundlessScrollViewCell.h"
#import "TipView.h"
#import "DateTools.h"
#import "CellDateModel.h"
#define CALENDAR_TOP_MARGIN 70

@interface ViewController ()<WKBoundlessScrollViewDelegate>
{
    TipView *_tipView;
    NSInteger _currentYear;
    NSInteger _currentMonth;
    NSInteger _currentDay;
    NSInteger _currentWeekday;
    NSInteger _lastCellDeviation;
    NSMutableDictionary *_cell;
    CGFloat iWidth;
    CGFloat iHeight;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self getCurrentDate];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelecteDate:) name:@"DID_SELETED_DATEVIEW" object:nil];
    
    iWidth = [UIScreen mainScreen].bounds.size.width;
    iHeight = [UIScreen mainScreen].bounds.size.height;
    
    [self.view addSubview:[self getTitleView]];
    
    WKBoundlessScrollView *boundlessScrollView = [[WKBoundlessScrollView alloc] initWithFrame:CGRectMake(0, CALENDAR_TOP_MARGIN, iWidth, iHeight-CALENDAR_TOP_MARGIN)];
    
    boundlessScrollView.decelerationRate = 1.0;
    boundlessScrollView.delegateForCell = self;
    [self.view addSubview:boundlessScrollView];
    
    
}


-(UIView *)getTitleView
{
    NSArray *titleArray = @[@"S",@"M",@"T",@"W",@"T",@"F",@"S"];
    CGFloat width = (iWidth-20)/7;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CALENDAR_TOP_MARGIN - 25, iWidth, 25)];
    for (int i = 0; i < titleArray.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*width+10, 2, width, 20)];
        label.text = titleArray[i];
        label.font = [UIFont systemFontOfSize:12.0];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];
    }
    UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 25, iWidth, 0.5)];
    separatorView.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:separatorView];
    return view;
}

-(TipView *)getTipLabel:(NSString *)string
{
    if (!_tipView) {
        _tipView = [[TipView alloc] initWithFrame:CGRectMake(0, CALENDAR_TOP_MARGIN + 2, iWidth, 50)];
        _tipView.backgroundColor = [UIColor clearColor];
        _tipView.hidden = YES;

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, iWidth, 35)];
        label.backgroundColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14.0];
        label.tag = 100;
        [_tipView addSubview:label];
        _tipView.alpha = 0.0;
        [self.view addSubview:_tipView];
    }
    UILabel *label = [_tipView viewWithTag:100];
    label.text = string;
    return _tipView;
}

-(void)didSelecteDate:(NSNotification *)notification
{
    NSDictionary * dict = notification.userInfo;
    DateModel *dateModel = dict[@"dateModel"];
    NSLog(@"%@",dateModel);
}

-(WKBoundlessScrollViewCell *)boundlessScrollViewCellWithDeviation:(NSInteger)deviation boundlessScrollView:(WKBoundlessScrollView *)boundlessScrollView
{
    
    static NSString *cellID = @"cellID";
    
    WKBoundlessScrollViewCell *cell = [boundlessScrollView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[WKBoundlessScrollViewCell alloc] initWithIdentifier:cellID];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CellDateModel *cellDateModel = [DateTools dateToCell:deviation];
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell fillDate:cellDateModel];
        });
    });
    
    return cell;
}

-(CGFloat)boundlessScrollViewCellHeightWithdeviation:(NSInteger)deviation boundlessScrollView:(WKBoundlessScrollView *)boundlessScrollView{
    
    NSInteger row = [DateTools getDrawRow:deviation];
    CGFloat width = (iWidth-20)/7.0;
    return (width+15)*row+10+30;
}

-(void)didSelectedWithDeviation:(NSInteger)deviation boundlessScrollView:(WKBoundlessScrollView *)boundlessScrollView
{
    NSLog(@"%ld",(long)deviation);
}

-(void)boundlessScrollViewArriveTopVisible:(NSInteger)deviation
{
    NSDateComponents *components = [DateTools getCellMonthDate:deviation];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    NSString *monthName = [[df monthSymbols] objectAtIndex:(components.month-1)];
    NSString *string = [NSString stringWithFormat:@"%@ %ld",monthName, components.year];
    
    TipView *tipView = [self getTipLabel:string];
    if (tipView.hidden == YES) {
        tipView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            tipView.alpha = 1.0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.6 animations:^{
                tipView.alpha = 0.6;
            } completion:^(BOOL finished) {
                tipView.hidden = YES;;
            }];
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
