//
//  City.m
//  Forcaster
//
//  Created by Jim on 3/23/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "City.h"

@implementation City


// initialize city with a zipcode
- (instancetype)initWithZipCode:(NSString *)zip
{

    {
        self = [super init];
        if (self)
        {
            _zipCode = zip;
        }
        return self;
    }
    
}

// from the Google API, fetch and parse the latitude and long.
- (BOOL)parseCoordinateInfo:(NSDictionary *)mapsDictionary
{
   
    
}


@end
