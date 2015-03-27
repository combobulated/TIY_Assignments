//
//  City.h
//  Forecaster
//
//  Created by Ben Gohlke on 3/21/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"

// Adding a Map and Annotation to the map tutorial
// ( for this tutorial look for the ama or add map
// markers to follow along step by step.
// The City class was chosen to implement the MKAnnotation
// marker being City has the available lat and lng data.

// Add map STEP 1:

// add MapKit Framework
// (note the @ designator and no quotes

@import MapKit;  // new way to import a Framework

// STEP 2:

// implement MKAnnotation into this City class.
// Give City class permission to implement the methods in MKAnnotation
// they are in the mapKit framework.  City will now act like
// class MKAnnotation.
// ama step 2   implement the MKAnnotation protocol
// @interface City : NSObject               to
// @interface City : NSObject <MKAnnotation>

@interface City : NSObject <MKAnnotation, NSCoding >;
// City class inherits from NSObject
// city class "implements MKAnnotation Protocol"

@property (strong, nonatomic) Weather *currentWeather;
@property (strong, nonatomic) NSArray *forecastedWeather;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *state;
@property (assign) double latitude;
@property (assign) double longitude;
@property (strong, nonatomic) NSString *zipCode;

- (instancetype)initWithZipCode:(NSString *)zip;

- (instancetype)initWithName:(NSString *)name latitude:(double)lat longitude:(double)lng andZipCode:(NSString *)zip;

- (BOOL)parseCoordinateInfo:(NSDictionary *)mapsDictionary;


// add map STEP 3

// add a coordinate method that returns
// coordinates in latitude and longitude
- (CLLocationCoordinate2D)coordinate;

@end
// STEP 4 go to .m file to add a private interface and a few other things