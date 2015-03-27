//
//  WeatherDetailViewController.m
//  Forecaster
//
//  Created by Ben Gohlke on 3/22/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "WeatherDetailViewController.h"

// add map STEP #?
// import the MapKit framework

@import MapKit;

// add map STEP 12
// define the size of maps box
// set scale to half a mile in meters

#define MAP_DISPLAY_SCALE 0.5 * 1609.344

@interface WeatherDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *actualTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *apparentTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *dewPointLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *rainChanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

//add map STEP 9 (continued from city.m step 9)
// add the IBoutlet for the map
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

// add map STEP 10
// go to story board
// click on view controller icon
// drag connections inspector outlets empty circle to
// map view on screen

@end

@implementation WeatherDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.city.name;
    self.summaryLabel.text = self.city.currentWeather.summary;
    self.actualTemperatureLabel.text = [self.city.currentWeather currentTemperature];
    self.iconImageView.image = [UIImage imageNamed:self.city.currentWeather.icon];
    self.apparentTemperatureLabel.text = [self.city.currentWeather feelsLikeTemperature];
    self.dewPointLabel.text = [self.city.currentWeather dewPointTemperature];
    self.humidityLabel.text = [self.city.currentWeather humidityPercentage];
    self.rainChanceLabel.text = [self.city.currentWeather chanceOfRain];
    self.windSpeedLabel.text = [self.city.currentWeather windSpeedMPH];
    
    //add map STEP 11A
    
    //run configuration method for mapview
    
    [self configureMapView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// add map STEP 11B
// configure map view (called from viewdidload)

- (void)configureMapView
{
    // what portion of map should be on screen.. ie coordinate region
    // define how big of an area to display
    //  we set center of map with our coordinates
    //  we set box height (lat) and width (lng) in meters
    // we define size in meters ( see STEP 12 up top) #define scale
   
    // create the viewRegion.. note MKCCoord.. is a function
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance([self.city coordinate], MAP_DISPLAY_SCALE, MAP_DISPLAY_SCALE);
    
    // and set it
   [self.mapView setRegion:viewRegion];
   
    
   // add map STEP 13
   // display the city name on the map marker
    // note: addAnnotation accepts any obect
    // that implements the MkAnnotation protocol
    // city object implements the MKAnnotation protocol
    
   [self.mapView addAnnotation:self.city];
    
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
     
   if( [annotation isKindOfClass:[City class]] )
       
   {
       // annotation object is a City object
       // create an annotation view
      
       // first create and identification
       // const means value will not change
       // static means pointer will not vanish
       
        static NSString * const identifier = @"CityAnnotation";
       
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
