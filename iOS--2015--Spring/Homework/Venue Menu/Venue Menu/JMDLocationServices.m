//
//  LocationServices.m
//  Venue Menu
//
//  Created by Jim on 4/4/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "JMDLocationServices.h"


@import CoreLocation;
@import MapKit;

@interface JMDLocationServices () <CLLocationManagerDelegate>

{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;   //  given a lat lng returns address
    BOOL rc;
}

@end



@implementation JMDLocationServices

#pragma mark   -CLLocation related methods

- (BOOL)configureLocationManager
{
    
    //return NO if location manager is not successfully enabled
    
    rc = NO;
    
    if ([CLLocationManager authorizationStatus] !=
        kCLAuthorizationStatusDenied && kCLAuthorizationStatusRestricted)
    {
        if   (!locationManager)
        {
            //create a location manager
            locationManager = [[CLLocationManager alloc]init];
            
            // set as delegate
            locationManager.delegate = self;
            
            // set accuracy.. note, super accuracy will drain battery fast
            locationManager.desiredAccuracy =
            kCLLocationAccuracyNearestTenMeters;
            
            // if location services authorization not determined,
            // display message in a pop up view requesting user to
            // authorize location services for this app.
            // note: the developer must place a message
            // about how this app intends to use the location data
            // in the info.plst file.
            
            if ([CLLocationManager authorizationStatus] ==
                kCLAuthorizationStatusNotDetermined)
            {
                [locationManager requestWhenInUseAuthorization]; // pop up appears on screen informing user of message described
                   //  in info.plist file.
            }
            else
            {
                self.didUpdateLocation = NO;
                [self enableLocationManager:YES];
                rc = YES;
            }
        }
    }
    
    return rc;
}



- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status != kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        // suggest doing disable button
        //[self.aButton setEnabled:NO];
    }
    else
    {
        // suggest doing enabling button
        // [self enableLocationManager:YES];
    }
}


- (void)enableLocationManager:(BOOL)enable
{
    if (locationManager) {
        if(enable)
        {
            [locationManager stopUpdatingLocation];
            [locationManager startUpdatingLocation ];
            
        }
        else
        {
            [locationManager stopUpdatingLocation];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if(error != kCLErrorLocationUnknown)
    {
        [self enableLocationManager:NO];
        
        // wise, to set button to disabled like this
        // [self.aButton   setEnabled:NO];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // initialize the pin model with coordinates of user's
    // current location.
    
    [self enableLocationManager:NO];
    
    CLLocation *location = [locations lastObject];
    
    [self.delegate locationWasFound:location];
    
    
    double lat = location.coordinate.latitude;
    double lng = location.coordinate.longitude;


   // update our location model
    self.latitude = lat;
    self.longitude = lng;
    
    self.didUpdateLocation = YES;
    
    
//
//    NSString * pinName = @"";
//    self.pin = [[Pin alloc]initWithName:pinName latitude:lat longitude:lng ];
//    
//    
//    
//    //  MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance([self.pin coordinate], MAP_DISPLAY_SCALE, MAP_DISPLAY_SCALE);
//    
//    [self configureMapView];
//   

    
    /*
     // drop pin on current location and set flag so that
     // we can draw map on init
     
     NSString * pinName = @"";
     Pin *aPin = [[Pin alloc]initWithName:pinName latitude:lat longitude:lng ];
     
     [self.mapView addAnnotation:aPin];
     
     
     // if "mark car"button pressed, drop pin
     // create a  model object and feed it lat lon
     if (markCar) {
     
     NSString * pinName = @"car";
     
     Pin *aPin = [[Pin alloc]initWithName:pinName latitude:lat longitude:lng ];
     
     // display the pin name on the map marker
     // note: addAnnotation accepts any obect
     // that implements the MkAnnotation protocol
     // city object implements the MKAnnotation protocol
     
     [self.mapView addAnnotation:aPin];
     
     // next turn enableLocationManager:OFF
     [self enableLocationManager:NO];
     
     markCar = NO;
     }
     */
}


@end
    
