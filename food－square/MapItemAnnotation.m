//
//  MapItemAnnotation.m
//  food－square
//
//  Created by Apple on 13-10-11.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "MapItemAnnotation.h"


@implementation MapItemAnnotation




@synthesize coordinate;
@synthesize title;
@synthesize subtitle;


-(id)initWithLongtitude:(float)longtitude latitude:(float)latitude{
    self=[super init];
    if (self) {
        _latitude=latitude;
        _longtitude=longtitude;
    }
    return self;}


@end
