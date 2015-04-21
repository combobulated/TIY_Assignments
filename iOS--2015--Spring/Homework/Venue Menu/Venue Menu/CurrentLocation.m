//
//  CurrentLocation.m
//  Venue Menu
//
//  Created by Jim on 4/4/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CurrentLocation.h"



@interface CurrentLocation ()

@property (nonatomic) CLLocationCoordinate2D coordinate;

@end



@implementation CurrentLocation


- (instancetype)initWithLatLng:(double)lat longitude:(double)lng
//- (instancetype)initWithName:(NSString *)name latitude:(double)lat longitude:(double)lng
{
    self = [super init];
    if (self)
    {
        //_name = name;
        _latitude  = lat;
        _longitude = lng;
        _coordinate = CLLocationCoordinate2DMake(lat,lng);
        
    }
    return self;
}

//- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate
//{
//    _latitude = coordinate.latitude;
//    _longitude = coordinate.longitude;
//    _coordinate = coordinate;
//    
//}



- (instancetype)init
{
    return self;
}

// note:we are overriding title as defined in ..
//// title is a method of MKannotation. It is
//// the string containing annotations title"
//
//- (NSString *)title
//{
//    
//    return @"Your Location";
//}
//
//- (NSString *)subtitle
//{
//    
//    return self.name;
//}


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
// for adding a pin of this location on the map
//
//- (MKMapItem *)mapItem
//{
//    // We are overriding MKAnnotation mapItem
//    // create a placemark object, set its location with a coordinate, set
//    // the dictionary to nil
//    
//    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:nil];
//    
//    // now create the map icon
//    
//    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark ];
//    
//    // set mapItems name property to name of city
//    
//    mapItem.name = self.name;
//    
//    return mapItem;
//}
//

@end
