//
//  DetailMainViewController.m
//  food－square
//
//  Created by Apple on 13-10-16.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "DetailMainViewController.h"
#import "MapItemAnnotation.h"

@interface DetailMainViewController ()
//method to display the annotation on map view for the location returned by geocoding
- (void)displayAnnotationWitPlacemarksArray;
@end

@implementation DetailMainViewController
@synthesize mapViewForAnnotation;
@synthesize placemarksArray;
@synthesize textViewForAddress;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    geocoder=[[CLGeocoder alloc] init];
    [self getAddress];
}

-(void)getAddress{
    CLLocation *location=[[CLLocation alloc]initWithLatitude:self.latitude longitude:self.longtitude];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        self.placemarksArray=placemarks;
        [self.placemarksArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            CLPlacemark *placeInfo=obj;
            NSString *address=[NSString stringWithFormat:@"%@",placeInfo.name];
            if ([placeInfo.subLocality length]>0) {
                address=[address stringByAppendingFormat:@"%@",placeInfo.subLocality];
            }
            if ([placeInfo.locality length]>0) {
                address = [address stringByAppendingFormat:@",%@",placeInfo.locality];
            }
            if ([placeInfo.country length]>0) {
                address = [address stringByAppendingFormat:@",%@",placeInfo.country];
            }
            if ([placeInfo.postalCode length]>0) {
                address = [address stringByAppendingFormat:@",%@",placeInfo.postalCode];
            }
            textViewForAddress.text=[NSString stringWithString:address];
            NSLog(@"%f",self.longtitude);
        }];
        [self displayAnnotationWitPlacemarksArray];
    }];
}

-(void)displayAnnotationWitPlacemarksArray{
    MapItemAnnotation *markAnnotation=[[MapItemAnnotation alloc]initWithLongtitude:self.longtitude latitude:self.latitude];
    NSLog(@"%f",self.longtitude);
    NSMutableArray *arrayForAnnotation=[[NSMutableArray alloc]init];
    [self.placemarksArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CLPlacemark *placeInfo=obj;
        markAnnotation.coordinate=placeInfo.location.coordinate;
        markAnnotation.title=placeInfo.name;
        markAnnotation.subtitle=placeInfo.country;
        [arrayForAnnotation addObject:markAnnotation];
        MKCoordinateRegion region;
        region.center.latitude=placeInfo.location.coordinate.latitude;
        region.center.longitude = placeInfo.location.coordinate.longitude;
        region.span.latitudeDelta = 0.05;
        region.span.longitudeDelta = 0.05;
        [mapViewForAnnotation setRegion:region];
    }];
    NSLog(@"%f",self.longtitude);
    NSLog(@"111");
    [self.mapViewForAnnotation addAnnotations:arrayForAnnotation];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(MapItemAnnotation *)markAnnotation
{
    static NSString *identifier = @"identifier";
    
    
    MKPinAnnotationView *pinAnnotation = [[MKPinAnnotationView alloc]initWithAnnotation:markAnnotation reuseIdentifier:identifier];
    
    pinAnnotation.canShowCallout = YES;
    
    
    return pinAnnotation;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
