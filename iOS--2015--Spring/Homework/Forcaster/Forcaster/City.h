//
//  City.h
//  Forcaster
//
//  Created by Jim on 3/23/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"


@interface City : NSObject
{
   
    @property (strong, nonatomic) Weather *currentWeather;
    
    @property (strong, nonatomic) NSArray *forecastedWeather;
    
    @property (strong, nonatomic) NSString *name;
    @property (strong, nonatomic) NSString *state;
    
    // (note:primatives need not be casted as strongs but as assigns)
    @property (assign) double latitude;
    @property (assign) double longitude;
    
    @property (strong, nonatomic) NSString *zipCode;

    // methods
    
    // initialize city with a zipcode
    - (instancetype)initWithZipCode:(NSString *)zip;
    
    //  from the Google API, fetch and parse the latitude and long.
    - (BOOL)parseCoordinateInfo:(NSDictionary *)mapsDictionary;
}

@end
