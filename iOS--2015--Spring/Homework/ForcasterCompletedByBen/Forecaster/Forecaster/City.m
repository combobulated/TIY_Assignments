//
//  City.m
//  Forecaster
//
//  Created by Ben Gohlke on 3/21/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "City.h"

// add map STEP 4
// add a private interface
// (also called a class extension)
// In the interface we add a private property
// called coordinate.  Coordinate is a struct
// containing lat and lng.  It is not an obj
// and does not require a *pointer.
// we could also add private methods in the
// interface.


@interface City ()

// add private property for city class
// only city class can see these properties
// ( note that this interface is opposite to
// the interface found in the header )

@property (nonatomic) CLLocationCoordinate2D coordinate;

@end



@implementation City

- (instancetype)initWithZipCode:(NSString *)zip
{
    self = [super init];
    if (self)
    {
        _zipCode = zip;
    }
    return self;
}


- (instancetype)initWithName:(NSString *)name latitude:(double)lat longitude:(double)lng andZipCode:(NSString *)zip
{
    self = [super init];
    if (self)
    {
        _name = name;
        _latitude = lat;
        _longitude = lng;
        _zipCode   = zip;
        _coordinate = CLLocationCoordinate2DMake(lat, lng);
        
    }
    return self;
}

- (instancetype)init
{
    return [self initWithZipCode:@"0"];
}

- (BOOL)parseCoordinateInfo:(NSDictionary *)mapsDictionary
{
    BOOL rc = NO;
    
    if (mapsDictionary)
    {
        rc = YES;
        NSArray *results = mapsDictionary[@"results"];
        NSDictionary *resultsDictionary = [results objectAtIndex:0];
        NSString *formatted_address = resultsDictionary[@"formatted_address"];
        NSArray *addressComponents = [formatted_address componentsSeparatedByString:@","];
        self.name = addressComponents[0];
        self.state = [addressComponents[1] componentsSeparatedByString:@" "][0];
        NSDictionary *geometry = resultsDictionary[@"geometry"];
        NSDictionary *location = geometry[@"location"];
        self.latitude = [location[@"lat"] doubleValue];
        self.longitude = [location[@"lng"] doubleValue];
        
        // add map STEP 6B
        // setting the coordinate value. we have two options:
        // 1) self.coordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude);
        // and 2) a setter // setter standard is to us set with var name Capitalized.
        [self setCoordinate:CLLocationCoordinate2DMake(self.latitude, self.longitude)];
    //    self.coordinate
    //    [self coordinate] // getter example runs method coordinate
                              // standard is to use variable as getter
    }
    
    return rc;
}

// add map STEP 5
// add methods title and subtitle
// note:we are overriding title as defined in ..
// title is a method of MKannotation. It is
// the string containing annotations title"

- (NSString *)title
{
    // return the city name
    
    return self.name;
}


-(NSString *)subtitle
{
    // return the temperature (in string format)
    
    return [ self.currentWeather currentTemperature];
}

//  add map STEP 6
//  configuring coordinate method
//  as public getters but not public setters

// note we are using property
// with setters and getters defined
// for this class.  coordinate is private inside
// our interface.  Normally, Outside classes cannot
// view coordinate. but, notice
// inside our header interface, a coordinate method
//  is declared.
//  For this reason, we allow other
//  classes to "get" this property value.
//  But other classes cannot "set" this value.
//

- (CLLocationCoordinate2D)coordinate
{
    // we are overriding the coordinate getter
    // for this reason we use an underscore
    
    return _coordinate;
}


 // add map STEP 7  add the place mark method

- (MKMapItem *)mapItem
{
    //we are overriding MKAnnotation mapItem
    // creaet a placemark object, set its location with a coordinate, set
    // the dictionary to nil
    
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:nil];
   
    // now create the map icon
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark ];
   
    // set mapItems name property to name of city
    
    mapItem.name = self.name;
    
    return mapItem;
}
// add map STEP 8  go to story board and create a map object, set
//  constraints for leading, trailing top and bottom edge

//  add map STEP 9
//  go to WeatherDetailViewController.m

//amad step 2
#pragma mark -NSCoding

// the pound defines use small k prefix
// implying the value is a constant
#define kNamekey      @"name"
#define kLatitudeKey  @"latitude"
#define kLongitudeKey @"longitude"
#define kZipCodeKey   @"zipCode"

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:kNamekey];
    [aCoder encodeDouble:self.latitude forKey:kLatitudeKey];
    [aCoder encodeDouble:self.longitude forKey:kLongitudeKey];
    [aCoder encodeObject:self.zipCode forKey:kZipCodeKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    NSString *cityName  = [aDecoder decodeObjectForKey:kNamekey];
    double    latitude  = [aDecoder decodeDoubleForKey:kLatitudeKey];
    double    longitude = [aDecoder decodeDoubleForKey:kLongitudeKey];
    NSString  *zipCode  = [aDecoder decodeObjectForKey:kZipCodeKey];
    
   return [self initWithName:cityName latitude:latitude   longitude:longitude andZipCode:zipCode];
    
}
// amad step 3
// next step: geenrate new class called CityDoc, a subclass of NSObject
@end