//
//  MapViewController.h
//  food－square
//
//  Created by Apple on 13-9-28.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>





@interface MapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>{
 
    CLLocationManager               *locationManager;
    CLLocationCoordinate2D          newLocCoordinate;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;







@end
