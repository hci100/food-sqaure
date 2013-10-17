//
//  DetailMainViewController.h
//  food－square
//
//  Created by Apple on 13-10-16.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapItemAnnotation.h"
#import <CoreLocation/CoreLocation.h>

@interface DetailMainViewController : UIViewController<MKAnnotation,CLLocationManagerDelegate,UITextViewDelegate,MKMapViewDelegate>
{
    CLGeocoder *geocoder;
    NSArray *placemarksArray;
}
@property (strong, nonatomic) IBOutlet MKMapView *mapViewForAnnotation;
@property (strong, nonatomic) IBOutlet UITextView *textViewForAddress;
@property (strong,nonatomic)NSArray *placemarksArray;
@property(nonatomic)float longtitude;
@property(nonatomic)float latitude;
@end
