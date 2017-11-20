//
//  TipView.m
//  Calendar
//
//  Created by Crane on 18/12/15.
//  Copyright © 2015 GoldITDev All rights reserved.
//

#import "TipView.h"

@implementation TipView
-(void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawGradient:context];
}


-(void)drawGradient:(CGContextRef)context
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat components[8] = {1.0,1.0,1.0,1.0,1.0,1.0,1.0,0.8};
    CGFloat locations[2] = {0.0,1.0,};
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);    
 
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0.0f, 0.0f), CGPointMake(0, self.frame.size.height), 0);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
    
}




@end
