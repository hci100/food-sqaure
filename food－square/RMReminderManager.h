//
//  RMReminderManager.h
//  food－square
//
//  Created by Apple on 13-9-29.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>
#import "RMGeofencedReminderAnnotation.h"

typedef void (^RMReminderFetchCompletionBlock)(NSArray *reminders);
typedef void (^RMReminderAddCompletionBlock)(EKReminder *reminder);
typedef void (^RMReminderOperationCompletionBlock)(BOOL result);

extern NSString * const RMReminderManagerAccessGrantedNotification;
extern NSString * const RMReminderManagerReminderUpdatedNotification;

@interface RMReminderManager : NSObject

// singleton

+(RMReminderManager*)defaultManager;

@property (nonatomic, strong, readonly) EKEventStore *store;

// Access to reminders

@property (atomic, readonly) BOOL accessGranted;
-(void)requestAccess;
-(void)requestAccessAndWait;


// Verification methods

-(BOOL)isCalendarIdentifierValid:(NSString*)calendarIdentifier;


// Fetch and add reminders

-(void)fetchGeofencedRemindersWithCompletion:(RMReminderFetchCompletionBlock)completionBlock;

-(void)addReminderWithAnnotation:(RMGeofencedReminderAnnotation*)annotation
        inCalendarWithIdentifier:(NSString*)calendarIdentifier
                      completion:(RMReminderAddCompletionBlock)completionBlock;

-(void)saveReminder:(EKReminder*)reminder withCompletion:(RMReminderOperationCompletionBlock)completionBlock;
-(void)removeReminder:(EKReminder*)reminder withCompletion:(RMReminderOperationCompletionBlock)completionBlock;

// Sources, calendars


-(EKCalendar*)defaultReminderCalendar;
-(EKCalendar*)calendarWithIdentifier:(NSString*)identifier;

@end
