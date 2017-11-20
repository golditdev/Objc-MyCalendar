//
//  WKBoundlessScrollViewCell.h
//  Calendar
//
//  Created by Crane on 16/12/15.
//  Copyright © 2015 GoldITDev All rights reserved.
//

#import <UIKit/UIKit.h>


@class CellDateModel;


@interface WKBoundlessScrollViewCell : UIView


@property(nonatomic,copy)NSString *identifier;
@property(nonatomic,assign)NSInteger deviation;
@property(nonatomic,strong)UILabel *label;
-(instancetype)initWithIdentifier:(NSString *)identifier;
-(void)fillDate:(CellDateModel *)cellDateModel;


@end
