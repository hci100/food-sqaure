//
//  RMAddReminderViewControoller.h
//  food－square
//
//  Created by Apple on 13-9-29.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "RMGeofencedReminderAnnotation.h"
#import "TQStarRatingView.h"

@interface RMAddReminderViewController : UITableViewController<UIImagePickerControllerDelegate,StarRatingViewDelegate,UIActionSheetDelegate>

@property (strong, nonatomic) RMGeofencedReminderAnnotation *reminderAnnotation;

@property (strong, nonatomic, readonly) EKCalendar *calendar;

@property (nonatomic,retain)IBOutlet UIImageView *photoImageView;
-(IBAction)choosePhoto:(id)sender;

@end
