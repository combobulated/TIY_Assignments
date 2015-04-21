//
//  SearchViewController.m
//  Venue Menu
//
//  Created by Jim on 4/3/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "SearchViewController.h"
#import "POITableViewController.h"

#import "JMDLocationServices.h"

@interface SearchViewController () <UITextFieldDelegate, NSURLSessionDataDelegate>
{
    NSMutableArray *venuesOfInterest;
//  NSMutableArray *resultsArray;
    NSMutableData *receivedData;
//  NSMutableArray *searchObjectArray;
    double lat;
    double lng;
    
    
    JMDLocationServices *usersLocationManager;
}


@property (weak, nonatomic) IBOutlet UITextField *searchItemTextField;

- (IBAction)searchButton:(UIButton *)sender;
- (IBAction)cancelButton:(UIButton *)sender;

@end


@implementation SearchViewController

- (void)viewDidLoad

{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
//  searchObjectArray = [[NSMutableArray alloc] init];
//  resultsArray = [[NSMutableArray alloc] init];
//  self.navigationItem.prompt = @"Enter a Business";
//    geoCoder = [[CLGeocoder alloc] init];
//    [self configureLocationManager];
   
    usersLocationManager = [[JMDLocationServices alloc]init];
    
    venuesOfInterest = [[NSMutableArray alloc]init];
    
//  this is inited below  receivedData = [[NSMutableData alloc]init];
    
    
    usersLocationManager.delegate = self;
    
    
    if ( ! [usersLocationManager configureLocationManager] )
    {
        NSLog(@"Yelp! Location Manager not available" );
    }
   
   // now, wait for 
   // lat lng is received below in the delegate method
    

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
        NSLog(@"prepare to go to venue of interest segue");
}
*/


#pragma mark -- Action Handlers

- (IBAction)cancelButton:(UIButton *)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)searchButton:(UIButton *)sender
{
    
 // fetch lat lng of current location.. all ready done in viewdidload
    
 // prep API to download JSON data from foursquare.com with lat/lng radius and query term
    NSLog(@"current latitude  = %f", lat);
    NSLog(@"current longitude = %f", lng);
    
    if (lat <= 0.0)
    {
        NSLog(@"NO LOCATION DATA!  Try Search again!");
    }
    
   // NSString *search = self.searchVenueSearchBar.text; //pulling the text from username
    NSString *search = self.searchItemTextField.text;
    NSLog(@"search term = %@",search);
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_id=G0K02JSFAEWIPRC1FMKR5WOCRADZEDSM22GKOVFILQ5FMCUI&client_secret=IYKPDTC4A5EDESMHB3G3ZMN3ZLLOC51QQUYBWEJL05ZZLCDH&v=20130815&ll=%f,%f&query=%@&radius=800",lat,lng, search];
    
    NSURL *url = [NSURL URLWithString:urlString]; //proper URL object
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration //used more than once keep it around
                                                          delegate:self
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url]; //similar to above URLRequest ^
    
    [dataTask resume]; //starts at a paused state - have to resume it
    
}

#pragma mark - Location Manager
// see JMDLocationServices


#pragma mark - NSURLsession delegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow); //block or a closure - anon function - returns void
    
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data //blob of bytes - download in pieces - recieved data but not all the data - more to come...maybe
{
    if (!receivedData)
    {
        receivedData = [[NSMutableData alloc] initWithData:data];
    }//only create an object if we need one/alloc init - don't load stuff until you need to load it
    else
    {
        [receivedData appendData:data];
    }
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error //if it didn't complete this will point to error
{
    if (!error)
    {
        
        NSLog(@"Download Successful.");
        
       
        // grab venue info as a dictionary
//      NSDictionary *userInfo = [NSJSONSerialization JSONObjectWithData:receivedData
        NSDictionary *venueInfo = [NSJSONSerialization JSONObjectWithData:receivedData
                                                                  options:0
                                                                   error:nil];
        
        //        NSArray *response = [userInfo objectForKey:@"response"];
        
        receivedData = nil;  //added so we can search again 
        
        NSDictionary *response = [venueInfo objectForKey:@"response"];
        
        // inside the response dictionary, we have an array of venues.
        // Ill call the data venuesOfInterest rather than venues, which
        // ill save as an array for my favorite venue list in main view.
        
//      NSMutableArray *venuesOfInterest = [response objectForKey:@"venues"];
        
        venuesOfInterest = [response objectForKey:@"venues"];
        
       // we can pass the array on to the next view, the POITableViewController,
        // using call by reference.
     
//        POITableViewController *pointsOfInterestTVC = [[POITableViewController alloc]init];
//        pointsOfInterestTVC.venuesOfInterest = venuesOfInterest;
       
        NSLog(@"Venue list loaded");
        
        NSLog(@"%@",venuesOfInterest);
        
        NSLog(@"end of Venue list from search view controller ");
        
    
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        POITableViewController *pOITVC = [storyboard
                                                       instantiateViewControllerWithIdentifier:@"VenueOfInterestStoryBoardID" ];
                                                       
        pOITVC.venuesOfInterest = venuesOfInterest;
       
        pOITVC.cdStack = self.cdStack;
        
        
       [self.navigationController pushViewController:pOITVC animated:YES];

        
        
       // Then close up searchViewController
       // ( is this handeled by the storyboard segue to POITableViewController ?)
        
        
      /*
       // Randalls and Richards sorting of JSON API database
        NSArray *venues = [response objectForKey:@"venues"];
        
//        for (int i = 0; i < [venues count]; i++)  see video one on 4-6-2015 at 27 minutes
        // for rework of this jason section
        for (int i = 0; i < [venues count]; i++)
        {
            VenueTransfer *aSearchResult = [[VenueTransfer alloc] init];
            
            firstLocation = [venues objectAtIndex:i];
            
            
            resultsArray[i] = [firstLocation objectForKey:@"name"];
            aSearchResult.venueName = [firstLocation objectForKey:@"name"];
            
            NSDictionary *location = [firstLocation objectForKey:@"location"];
            
            //            resultsArray[1] = [location objectForKey:@"address"]; // need to put address on search view
            aSearchResult.venueAddress = [location objectForKey:@"address"];
            aSearchResult.venueCity = [location objectForKey:@"city"];
            
            
            NSDictionary *contact = [firstLocation objectForKey:@"contact"];
            aSearchResult.venuePhone = [contact objectForKey:@"formattedPhone"];
            
            NSDictionary *stats = [firstLocation objectForKey:@"stats"];
            aSearchResult.venueTipCount = [[stats objectForKey:@"tipCount"] intValue];
            aSearchResult.venueCheckins = [[stats objectForKey:@"checkinsCount"] intValue];
            
            NSArray *categories = [firstLocation objectForKey:@"categories"];
            NSDictionary *category = [categories objectAtIndex:0];
            aSearchResult.venueCategory = [category objectForKey:@"shortName"];
            
            
            [searchObjectArray addObject:aSearchResult];
            
        }
        
        
        [self.tableView reloadData];
    */
        
    }
}


#pragma mark - Location Services Delegate

- (void) locationWasFound:(CLLocation *)location
{
    lat = location.coordinate.latitude;
    lng = location.coordinate.longitude;
    
}

@end
    
