//
//  Pin.h
//  CarFinder
//
//  Created by Jim on 3/25/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@import MapKit;  // the MapKit framework

@interface Pin : NSObject < MKAnnotation, NSCoding >
// public variables and methods

@property (strong, nonatomic) NSString *name;
@property (assign) double latitude;
@property (assign) double longitude;

// add a coordinate method that returns
// coordinates in latitude and longitude
- (CLLocationCoordinate2D)coordinate; // note this is a struct not object

- (instancetype)initWithName:(NSString *)name latitude:(double)lat longitude:(double)lng;



@end
