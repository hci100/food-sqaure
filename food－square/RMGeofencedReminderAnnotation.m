//
//  RMGeofencedReminderAnnotation.m
//  food－square
//
//  Created by Apple on 13-9-29.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "RMGeofencedReminderAnnotation.h"

@interface RMGeofencedReminderAnnotation()

@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;

@end

@implementation RMGeofencedReminderAnnotation

-(instancetype)initWithCoordiate:(CLLocationCoordinate2D)coordinate title:(NSString*)title subtitle:(NSString*)subtitle
{
    self = [super init];
    if (self)
    {
        _coordinate = coordinate;
        _title = [title copy];
        _subtitle = [subtitle copy];
    }
    
    return self;
}


@end
