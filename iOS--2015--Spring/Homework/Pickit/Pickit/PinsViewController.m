//
//  ViewController.m
//  Pickit
//
//  Created by Jim on 4/7/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "PinsViewController.h"
#import "ImageDetailViewController.h"

#import "Pickmark.h"

@import MapKit;
@import CoreLocation;
@import CloudKit;


//step 5
#define LAT_LNG_DEGREES 0.2



@interface PinsViewController () <CLLocationManagerDelegate,
MKMapViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate >

-(void) addPhotoTapped:(UIBarButtonItem *)sender;

@end

@implementation PinsViewController
{
    
    MKMapView *_mapView;
    CLLocationManager *_locationManager;
    CLLocation *_currentLocation;
    
    NSMutableArray *_picmarks;
   
    CKContainer *_container;
    CKDatabase *_publicDB;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self checkLocationAuthorization];
    
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    _mapView.delegate = self;
    
    [self.view addSubview:_mapView];
    
    _picmarks = [[NSMutableArray alloc] init];  // pin storage
    
    _container = [CKContainer defaultContainer];  //container for each app
    
    // our database will be public, we could also make a private database.
    // in this app, we will be sharing pictures
    //
    _publicDB = _container.publicCloudDatabase;
    
    [self refreshPickmarks];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPhotoTapped:)];
   
}

    - (void)refreshPickmarks
    {
        if (_currentLocation)
        {
            CGFloat radius = 10000.0; //meters
            CKQuery *query = [[CKQuery alloc] initWithRecordType:@"Pickmark" predicate:[NSPredicate predicateWithFormat:@"distanceToLocation:fromLocation:(%K,%@) < %f", @"Location", _currentLocation, radius]];
            
            [_publicDB performQuery:query inZoneWithID:nil completionHandler:^(NSArray *results, NSError *error)
             {
                [_mapView removeAnnotations:_picmarks];
                [_picmarks removeAllObjects];
                for (CKRecord *aRecord in results)
                {
                    Pickmark *aPicmark = [[Pickmark alloc] initWithRecord:aRecord];
                    
                    [_picmarks addObject:aPicmark];
                }
                 
                [_mapView addAnnotations:_picmarks];
            }];
        }
    }
    
    


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocation related methods

- (void)checkLocationAuthorization
{
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusRestricted)
    {
        if (!_locationManager)
        {
            _locationManager = [[CLLocationManager alloc] init];
            _locationManager.delegate = self;
            _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
            if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
            {
                [_locationManager requestWhenInUseAuthorization];
            }
            else
            {
                [self enableLocationManager:YES];
            }
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        [self enableLocationManager:YES];
    }
}

- (void)enableLocationManager:(BOOL)enable
{
    if (_locationManager)
    {
        [_locationManager stopUpdatingLocation];
        if (enable)
            [_locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (error != kCLErrorLocationUnknown)
    {
        [self enableLocationManager:NO];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    [self enableLocationManager:NO];
    MKCoordinateRegion mapRegion = MKCoordinateRegionMake(currentLocation.coordinate, MKCoordinateSpanMake(LAT_LNG_DEGREES, LAT_LNG_DEGREES));
    [_mapView setRegion:mapRegion];
    
    _currentLocation = currentLocation;  // store our current location.
    
    [self refreshPickmarks];
}



// next add tp plist... project target  info

// now we ad mapview delegate methods

#pragma mark - MKMapView delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
       // we want to turn on maps current location
        return nil;
    }
   
    // standard red pin
    
    MKPinAnnotationView *pinAnnotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"mapAnnotation"];
    
    if (pinAnnotationView)
    {
        [pinAnnotationView prepareForReuse];  // reuse pin
    }
    else
    {
        pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"mapAnnotation"];  //  make new pin old one not available
    }
    
    pinAnnotationView.canShowCallout = YES;
    
    Pickmark *aPicmark = (Pickmark *)annotation;  // custom model of pin
    
    // thumb nail of image in call out
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32.0, 32.0)];
    [imageView setImage:[aPicmark image]];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    pinAnnotationView.leftCalloutAccessoryView = imageView;
    
    // add button for full size image  //left side image right side button
    UIButton *disclosureButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    pinAnnotationView.rightCalloutAccessoryView = disclosureButton;
    
    [disclosureButton addTarget:self action:@selector(showFullSizeImage) forControlEvents:UIControlEventTouchUpInside];
   
  // return view of configured window
    return pinAnnotationView;
}

#pragma mark - Action handlers

- (void)addPhotoTapped:(UIBarButtonItem *)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
         // we want to take a new picture
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        // modal view ... presented from stack as a modal
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

- (void)showFullSizeImage
{
    Pickmark *annotation = [_mapView selectedAnnotations][0];  // annotation we just picked on
    
    ImageDetailViewController *imageDetailVC = [[ImageDetailViewController alloc] init];
    imageDetailVC.image = annotation.image;
    
    [self.navigationController pushViewController:imageDetailVC animated:YES];
    
}

#pragma mark - UIImagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        Pickmark *aPickmark = [[Pickmark alloc] initWithLocation:_currentLocation andImage:image];
        
        [_picmarks addObject:aPickmark];
        [_mapView addAnnotation:aPickmark];
        
       // create path to our image
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = paths[0];
        NSString *fullPath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", aPickmark.uuid]];
        NSData *imageData = UIImagePNGRepresentation(image);
        
        // write bits of image datat out to file at fullPath, the doc folder on phone/app
        [imageData writeToFile:fullPath atomically:YES];
        
        CKRecord *aRecord = [[CKRecord alloc] initWithRecordType:@"Pickmark"]; // must match cloudkit dashboard
        
        [aRecord setObject:_currentLocation forKey:@"Location"]; //matches cloudkit dashboard
       
        // we need to state where the file is sitting..with fileURL.
        CKAsset *anAsset = [[CKAsset alloc] initWithFileURL:[NSURL fileURLWithPath:fullPath]];
        
        [aRecord setObject:anAsset forKey:@"Image"];
        [aRecord setObject:@"A picmark" forKey:@"Title"];
       
        // push record up to cloud kit
        // skip error handling for now
        
        [_publicDB saveRecord:aRecord completionHandler:^(CKRecord *record, NSError *error) {
            
        }];
        
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
