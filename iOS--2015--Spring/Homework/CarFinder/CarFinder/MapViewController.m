//
//  MapViewController.m
//  CarFinder
//
//  Created by Jim on 3/25/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "MapViewController.h"
#import "Pin.h"

@import CoreLocation;
@import MapKit;
@import AddressBook;

#define MAP_DISPLAY_SCALE 0.5 * 1609.344 // half mile in meters

//add restore data step A
#define kPinsKey @"pins"

@import MapKit;


@interface MapViewController () <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;   // lat lng to address
    BOOL markCar;
    BOOL positionCurrent;
}

@property (strong, nonatomic) Pin *pin;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *aButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *aDeleteButton;

- (IBAction)markLocationOfCar:(UIBarButtonItem *)sender;
- (IBAction)deletePin:(UIBarButtonItem *)sender;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // add data restore step B
    
    [self loadPinData];
    
    if(self.pin)
    {
        [self configureMapView];
    }
    else
    {
        [self configureLocationManager];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Action Handlers

- (IBAction)markLocationOfCar:(UIBarButtonItem *)sender
{
   // configure location manager
   // this should have already been done [self configureLocationManager];
    
   // fetch current location
   
   // create new pin and drop ita
    
    if (!self.pin) {
        // display the pin name on the map marker
        // note: addAnnotation accepts any obect
        // that implements the MkAnnotation protocol
        // city object implements the MKAnnotation protocol
        
       // add a new pin by turning on location manager
       // if (locationManager) {
       //     [self enableLocationManager:YES];
       //}
       // else
       // {
            [self configureLocationManager];
       // }
    }
    [self.mapView addAnnotation:self.pin];
}

- (IBAction)deletePin:(UIBarButtonItem *)sender {
   
    if (self.pin) {
        [self.mapView removeAnnotation:self.pin];
    }
    self.pin = nil;
    locationManager = nil;
    
}

#pragma mark - Map View

// configure map view (called from viewdidload)

- (void)configureMapView
{
    // what portion of map should be on screen.. ie coordinate region
    // define how big of an area to display
    //  we set center of map with our coordinates
    //  we set box height (lat) and width (lng) in meters
    // we define size in meters ( see STEP 12 up top) #define scale

    // create the viewRegion.. note MKCCoord.. is a function
    // but first lets pull in current user location
    //-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance( [ self.pin coordinate] , MAP_DISPLAY_SCALE, MAP_DISPLAY_SCALE);
    
    // and set it
    [self.mapView setRegion:viewRegion];
    
    
    // add map STEP 13
    // display the pin name on the map marker
    // note: addAnnotation accepts any obect
    // that implements the MkAnnotation protocol
    // city object implements the MKAnnotation protocol
    
 //   [self.mapView addAnnotation:self.pin];

    
        // note:
        // you can also use "addAnnotations" and feed
        // it an array of pins. But, the size of the
        // map would have to be adjusted first.
    
        // next, add map STEP 14, the create the pins view.

    
}

//  add map STEP 14 (Last Step)
//  the mapView method
//  returns the view of the pin, or MKAnnotationView
//  we override so that we can screen the loosly typed annotation.
//  This method is called automatically by the map

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    
    // annotation object, what kind of class are you?
    
    if( [annotation isKindOfClass:[Pin class]] )
        
    {
        // annotation object is a Pin object
        // create an annotation view
        
        // first create and identification
        // const means value will not change
        // static means pointer will not vanish
        
        static NSString * const identifier = @"PinAnnotation";
        
        // pins added to screen maybe reused
        
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        // do we have an annotation view?
        if (annotationView)
            
        {  // a view slot is open
            // view is pin on screen. It was released from que.
            annotationView.annotation = annotation;
        }
        else  //create a new one
        {  // no pins availble, instantiate a bran new annotationView
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        }
        
        
        // show the pins bubble and title
        annotationView.canShowCallout = YES;
        
        return annotationView;
        
    }
    
    return nil;
}



#pragma mark   -CLLocation related methods

- (void)configureLocationManager
{
    if ([CLLocationManager authorizationStatus] !=
        kCLAuthorizationStatusDenied && kCLAuthorizationStatusRestricted)
    {
        if   (!locationManager)
        {
            //create a location manager
            locationManager = [[CLLocationManager alloc]init];
            
            locationManager.delegate = self;
            
            // set accuracy.. note, super accuracy will drain battery fast
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
    // initialize the pin model with coordinates users
    // current location.
    [self enableLocationManager:NO];
    
    CLLocation *location = [locations lastObject];
    double lat = location.coordinate.latitude;
    double lng = location.coordinate.longitude;
  
    NSString * pinName = @"";
    self.pin = [[Pin alloc]initWithName:pinName latitude:lat longitude:lng ];
   
    
    
//  MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance([self.pin coordinate], MAP_DISPLAY_SCALE, MAP_DISPLAY_SCALE);
   
    [self configureMapView];
    
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

#pragma mark    --backup and restore from background routines
//add data Step C
- (void) loadPinData
{
    NSData *pinData = [[NSUserDefaults standardUserDefaults] objectForKey:kPinsKey];
    
    if ( pinData)
    {
        self.pin = [NSKeyedUnarchiver unarchiveObjectWithData:pinData];
    }
    else
    {
        self.pin = nil;
    }
    
}

//add data Step D

- (void)savePinData
{
    //create an NSData object from our city
    NSData *pinData = [NSKeyedArchiver archivedDataWithRootObject:self.pin];
    [[NSUserDefaults standardUserDefaults] setObject:pinData forKey:kPinsKey];
}

@end
