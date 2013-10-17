//
//  MapItemAnnotation.h
//  food－square
//
//  Created by Apple on 13-10-11.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapItemAnnotation : NSObject<MKAnnotation>



@property (nonatomic)CLLocationCoordinate2D coordinate;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *subtitle;
@property(nonatomic)float longtitude;
@property(nonatomic)float latitude;
-(id)initWithLongtitude:(float)longtitude latitude:(float)latitude;
@end
