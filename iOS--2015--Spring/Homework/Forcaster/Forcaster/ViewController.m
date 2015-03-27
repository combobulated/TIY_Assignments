//
//  ViewController.m
//  Forcaster
//
//  Created by Jim on 3/19/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ViewController.h"
#import "Weather.h"



@interface ViewController () <NSURLSessionDataDelegate,UITextFieldDelegate>

{
    NSMutableData *receivedData;
}

- (IBAction)cancelTapped:(UIBarButtonItem *)sender;
- (IBAction)findCity:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *zipcodeTextField;


@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Action Handlers


- (IBAction)findCity:(UIBarButtonItem *)sender
{
   
    (City *) aCity
    
    [NetworkManger findCoordinatesForCity:aCity]
    
//  This is the API call to use to get coordinates from a zip code: http://maps.googleapis.com/maps/api/geocode/json?address=santa+cruz&components=postal_code:12345&sensor=false (Where 12345 is the zipcode. The address field has a city name in it, which is ignored by the API server for this request)
    
    // Use zipcode in http url to fetch json data from google.
    
    NSString *zipcode = self.zipcodeTextField.text;
    NSLog(@"zipcode is %@",zipcode);

    NSString *urlString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=santa+cruz&components=postal_code:%@&sensor=false", zipcode];
   
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    /*  synchronous web tansfer
     NSURLRequest *request = [NSURLRequest requestWithURL:url];
     // api will return json data in "blob of bits"
     // synchronous request
     NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
     
     // turn the data into usefull format  // json to dictionary
     
     NSDictionary *userInfo = [ NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
     
     // add data to friends array
     
     [self.friends addObject:userInfo];
     */
    
    // asynchronous transfer.. via iOS 7 enhancmentsa
    
    NSURLSessionConfiguration *configuration =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession
                             sessionWithConfiguration:configuration delegate:self
                             delegateQueue:[NSOperationQueue mainQueue ]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    
    [dataTask resume];
   
}

- (IBAction)cancelTapped:(UIButton *)sender
{
    [self cancel];
}

- (void) cancel
{
    //close the modal view controller NewFriendViewController
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - NSURLSession Delegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler

{    // note completionHandler is a block (varaible that acts like function)
    completionHandler(NSURLSessionResponseAllow);
}

//  assume data is chunky and incomplete... so we park and run multiple times
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data

// park data

{
    if (!receivedData)
    {
        receivedData = [[NSMutableData alloc] initWithData:data];
    }
    else
    {
        [receivedData appendData:data];
    }
}
// task finished, or finished with error, if error, point to NSError object, or no error,
// point to nil
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (!error)
    {
        // for developer testing
        NSLog(@"Download Successful");
        
       //filter through json data
        
//      NSDictionary *zipcodeInfo = [ NSJSONSerialization
        NSDictionary *googleJSON = [ NSJSONSerialization
                                  JSONObjectWithData:receivedData options:0 error:nil];
      
        Weather *weatherItem = [[Weather alloc] init];
        
        // The first set of [ ] of JSON google data are dictionary
        // markers.  
        
        NSArray *results = [googleJSON objectForKey:@"results"];
        
        NSDictionary *locationInfo = [results objectAtIndex:0];
        
        NSArray *addressComps = [locationInfo objectForKey:@"address_components"];
        
        NSDictionary *city = [addressComps objectAtIndex:1];
        
        NSString *cityName = [city objectForKey:@"long_name"];
        
        weatherItem.weatherCity = cityName;
        
        NSDictionary *geometry  = [locationInfo objectForKey:@"geometry"];
        NSDictionary *location  = [geometry objectForKey:@"location"];
        NSString *lat  = [ location objectForKey:@"lat"];
        NSString *lng  = [ location objectForKey:@"lng"];
        
        weatherItem.weatherLat  = lat;
        weatherItem.weatherLng  = lng;

        
        NSLog(@" Lat: %@",lat);
        NSLog(@" Lat: %@",lng);

        
        
//        [self.cityInfo addObject:cityName];
        [self.cityInfo addObject:weatherItem];
        
        [self cancel];
        
    }
}

@end
