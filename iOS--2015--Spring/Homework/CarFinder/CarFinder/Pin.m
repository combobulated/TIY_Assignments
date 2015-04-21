//
//  Pin.m
//  CarFinder
//
//  Created by Jim on 3/25/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "Pin.h"

@interface Pin ()

@property (nonatomic) CLLocationCoordinate2D coordinate;

@end

@implementation Pin


- (instancetype)initWithName:(NSString *)name latitude:(double)lat longitude:(double)lng
{
    self = [super init];
    if (self)
    {
        _name = name;
        _latitude  = lat;
        _longitude = lng;
        _coordinate = CLLocationCoordinate2DMake(lat,lng);
        
    }
    return self;
}


- (instancetype)init
{
    return self;
}

// note:we are overriding title as defined in ..
// title is a method of MKannotation. It is
// the string containing annotations title"

- (NSString *)title
{
    
    return @"Car Location";
}

- (NSString *)subtitle
{
    
    return self.name;
}
    

//  configure coordinate method
//  as public getter but not public setter

// note we are using @property
// with setters and getters defined
// for this class.  coordinate instance var is private inside
// our interface.  Normally, Outside classes cannot
// view coordinate. But, notice
// inside our header interface, a coordinate method
//  is declared.
//  For this reason, we allow other
//  classes to "get" this property value.
//  Outside classes cannot "set" this value.
//

- (CLLocationCoordinate2D)coordinate
{
    // we are overriding the coordinate getter
    // for this reason we use an underscore
    
    return _coordinate;
}


// add the place mark method

- (MKMapItem *)mapItem
{
    // We are overriding MKAnnotation mapItem
    // create a placemark object, set its location with a coordinate, set
    // the dictionary to nil
    
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:nil];
    
    // now create the map icon
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark ];
    
    // set mapItems name property to name of city
    
    mapItem.name = self.name;
    
    return mapItem;
}


#pragma mark -NSCoding

// NSCoding allows the data to be bundeled and stored
// in one "box" so to say.
// This way, app maybe put to sleep when moved to background
// then returned to normal state when brought to forground.
// Key coding is used to store an retrieve the encoded data.
// Note the pounddefines use a small k prefix
// implying the value is a constant

#define kNamekey      @"name"
#define kLatitudeKey  @"latitude"
#define kLongitudeKey @"longitude"

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:kNamekey];
    [aCoder encodeDouble:self.latitude forKey:kLatitudeKey];
    [aCoder encodeDouble:self.longitude forKey:kLongitudeKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    NSString *name  = [aDecoder decodeObjectForKey:kNamekey];
    double   latitude  = [aDecoder decodeDoubleForKey:kLatitudeKey];
    double   longitude = [aDecoder decodeDoubleForKey:kLongitudeKey];
    
    return [self initWithName:name latitude:latitude longitude:longitude];
}
@end
