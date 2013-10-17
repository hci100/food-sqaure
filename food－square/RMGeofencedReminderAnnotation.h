//
//  RMGeofencedReminderAnnotation.h
//  food－square
//
//  Created by Apple on 13-9-29.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <EventKit/EventKit.h>

@interface RMGeofencedReminderAnnotation : NSObject <MKAnnotation>

-(instancetype)initWithCoordiate:(CLLocationCoordinate2D)coordinate title:(NSString*)title subtitle:(NSString*)subtitle;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, assign) EKAlarmProximity proximity;
@property (nonatomic, assign) BOOL isFetched;

@property (nonatomic, strong) EKReminder *reminder;

@end
