//
//  CitySearchViewController.m
//  Forecaster
//
//  Created by Ben Gohlke on 3/21/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CitySearchViewController.h"
#import "City.h"
#import "NetworkManager.h"


// add loc button
@import CoreLocation;
@import MapKit;
@import AddressBook;

// add loc button see CLL
@interface CitySearchViewController () <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;   // lat lng to address
}

//These properties and methods are private (scope only to this class)

@property (weak, nonatomic) IBOutlet UITextField *zipCodeTextField;

//add loc button
@property (weak, nonatomic) IBOutlet UIButton *aButton;


- (IBAction)findCity:(UIButton *)sender;
- (IBAction)cancel:(UIBarButtonItem *)sender;



// add button 2
- (IBAction)findACityWithCurrentLocation:(UIButton *)sender;




@end

@implementation CitySearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    geocoder = [[CLGeocoder alloc]init];
    
    
    // Do any additional setup after loading the view.
}


#pragma mark   -CLLocation related methods

- (void)configureLocationManager
{
    if ([CLLocationManager authorizationStatus] !=
        kCLAuthorizationStatusDenied && kCLAuthorizationStatusRestricted)
    {
       if   (!locationManager)
       {
           locationManager = [[CLLocationManager alloc]init];
           locationManager.delegate = self;
           locationManager.desiredAccuracy =
           kCLLocationAccuracyNearestTenMeters;
           
           if ([CLLocationManager authorizationStatus] ==
               kCLAuthorizationStatusNotDetermined) {
               [locationManager requestWhenInUseAuthorization]; // pop up appears on screen informing user of message described
               //  in info.plist file.
           }
           else
           {
               [self enableLocationManager:YES];
           }
       }
    }
    else
    {   // turn off
        [self.aButton setEnabled:NO];
        
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status != kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        [self.aButton setEnabled:NO];
    }
    else
    {
        [self enableLocationManager:YES];
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

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if(error != kCLErrorLocationUnknown)
    {
    [self enableLocationManager:NO];
    [self.aButton   setEnabled:NO];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error){
        if ((placemarks !=nil) && (placemarks.count>0))
        {
            [self enableLocationManager:NO];
            NSString *cityName = [placemarks[0] locality];
            NSString *zipCode = [[placemarks[0] addressDictionary]
                objectForKey:(NSString *)kABPersonAddressZIPKey];
            double lat = location.coordinate.latitude;
            double lng = location.coordinate.longitude;
            City *aCity = [[City alloc]initWithName:cityName latitude:lat longitude:lng andZipCode:zipCode];
            [[NetworkManager sharedNetworkManager] cityFoundUsingCurrentLocation: aCity];
        }
        }];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark - Action Handlers


- (IBAction)findCity:(UIButton *)sender
{
    
    // We implement the delegate method, findCoordinatesForCity
    // to populated the lat and lon attributes of the city object.
    
    if (![self.zipCodeTextField.text isEqualToString:@""])
    {
        City *aCity = [[City alloc] initWithZipCode:self.zipCodeTextField.text];
        [[NetworkManager sharedNetworkManager] findCoordinatesForCity:aCity];
    }
}

- (IBAction)cancel:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)findACityWithCurrentLocation:(UIButton *)sender

{

   [self configureLocationManager];
}

@end
