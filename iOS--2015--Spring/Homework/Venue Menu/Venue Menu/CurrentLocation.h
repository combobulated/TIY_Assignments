//
//  CurrentLocation.h
//  Venue Menu
//
//  Created by Jim on 4/4/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@import MapKit;  // the MapKit framework

@interface CurrentLocation : NSObject // < MKAnnotation, NSCoding >

// public variables and methods

//@property (strong, nonatomic) NSString *name;  /perhaps we should name this loation?
@property (assign) double latitude;
@property (assign) double longitude;

// add a coordinate method that returns
// coordinates in latitude and longitude
- (CLLocationCoordinate2D)coordinate; // note this is a struct not object

//- (instancetype)initWithName:(NSString *)name latitude:(double)lat longitude:(double)lng;
- (instancetype)initWithLatLng:(double)lat longitude:(double)lng;

@end
