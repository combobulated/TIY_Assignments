//
//  NetworkManager.m
//  Forecaster
//
//  Created by Ben Gohlke on 3/21/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "NetworkManager.h"

typedef enum {
    DataFetchTypeCoordinates,
    DataFetchTypeWeather
} DataFetchType;

@interface NetworkManager () <NSURLSessionDataDelegate>
{
//    add data step f
//    id returnObject; //delete
//    NSMutableData *receivedData;
    NSURLSessionConfiguration *configuration;
    NSURLSession *session;
 // add
    NSMutableDictionary *citiesForActiveTasks;
    NSMutableDictionary *receivedDataRepos;
    
}
// add data g delete
//@property (assign) DataFetchType dataFetchType;

@end

@implementation NetworkManager

static NSString *gMapsBaseURL = @"http://maps.googleapis.com/maps/api/geocode/json?address=santa+cruz&components=postal_code:%@&sensor=false";
static NSString *forecastIoBaseURL = @"https://api.forecast.io/forecast/b9f65ac761fd049357ce0af9961972ed/%f,%f";


+ (NetworkManager *)sharedNetworkManager
{
    static NetworkManager *sharedNetworkManager = nil;
    if (sharedNetworkManager)
        return sharedNetworkManager;
    
    // Use Grand Central Dispatch to only init one instance of NetworkManager, makes the singleton thread-safe
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNetworkManager = [[NetworkManager alloc] init];
    });
    
    return sharedNetworkManager;
}

// add data g
- (instancetype) init
{
    self = [super init];
    if (self) {
        configuration = [NSURLSessionConfiguration
                         defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:
                   configuration delegate:self delegateQueue:
                   [NSOperationQueue mainQueue]];
        citiesForActiveTasks = [[NSMutableDictionary alloc] init];
        receivedDataRepos   = [[NSMutableDictionary alloc] init];
        
    }
    
    return self;
}


- (void)findCoordinatesForCity:(City *)aCity
{
// add data h
    
  //  self.dataFetchType = DataFetchTypeCoordinates;
  ////  returnObject = nil;
  //  returnObject = aCity;
    
    NSString *googleMapsUrlString = [NSString stringWithFormat:gMapsBaseURL, aCity.zipCode];
    NSURL *url = [NSURL URLWithString:googleMapsUrlString];

    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    [self startDataTask:dataTask forCity:aCity];
}

- (void)fetchCurrentWeatherForCity:(City *)aCity
{
//    add data i
  //  self.dataFetchType = DataFetchTypeWeather;
  //  returnObject = nil;
  //  returnObject = aCity;
    
    NSString *forecastIoUrlString = [NSString stringWithFormat:forecastIoBaseURL, aCity.latitude, aCity.longitude];
    NSURL *url = [NSURL URLWithString:forecastIoUrlString];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    [self startDataTask:dataTask forCity:aCity];
    
}

//- (void)launchUrlSessionWithUrl:(NSURL *)url
- (void) startDataTask:(NSURLSessionDataTask *)dataTask forCity:(City *)aCity
{  // add data j
/*    if (!configuration)
    {
        configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    }
    if (!session)
    {
        session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
*/
//   receivedData = nil;
   //
    [citiesForActiveTasks setObject:aCity forKey:[NSNumber numberWithInteger:dataTask.taskIdentifier]];
    
    [receivedDataRepos setObject:[[NSMutableData alloc]init] forKey:[NSNumber numberWithInteger:dataTask.taskIdentifier]];
    
    [dataTask resume];
}

- (void) fetchCurrentWeatherForCities:(NSArray *)cities
{
    for (City *aCity in cities) {
        [self fetchCurrentWeatherForCity:aCity];
    }
}

-(void)cityFoundUsingCurrentLocation:(City *)aCity
{
    [self.delegate cityWasFound:aCity];
    
}

#pragma mark - NSURLSession delegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    
    NSMutableData *receivedData = receivedDataRepos[[NSNumber numberWithInteger:dataTask.taskIdentifier]];
    
    [receivedData appendData:data];
    
/*
    if (!receivedData)
    {
        receivedData = [[NSMutableData alloc] initWithData:data];
    }
    else
    {
        [receivedData appendData:data];
    }
 */
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (!error)
    {
        
    NSMutableData *receivedData = receivedDataRepos[[NSNumber numberWithInteger:task.taskIdentifier]];
        
        NSDictionary *aDictionary = [NSJSONSerialization JSONObjectWithData:receivedData options:0 error:nil];
        
        City *aCity = citiesForActiveTasks[[NSNumber numberWithInteger:task.taskIdentifier]] ;
        
        DataFetchType fetchType;
        if ([aDictionary objectForKey:@"results"])
        {
            // hack
            fetchType = DataFetchTypeCoordinates;
            
        }
        else
        {
            fetchType = DataFetchTypeWeather;
        }
        
        BOOL coordinatesSuccess = NO;
        BOOL weatherSuccess = NO;
        
        switch (fetchType)
        {
            case DataFetchTypeCoordinates:
              //  aCity = returnObject;
                coordinatesSuccess = [aCity parseCoordinateInfo:aDictionary];
                break;
            case DataFetchTypeWeather:
             //   aCity = returnObject;
                weatherSuccess = [aCity.currentWeather parseWeatherInfo:aDictionary];
                break;
                
            default:
                break;
        }
        
        if (coordinatesSuccess)
        {
//            [self.delegate cityWasFound:returnObject];
            
            // cityWasFound appends a city to the cities array
            // and inserts the city into a table view cell.
            
            [self.delegate cityWasFound:aCity];
        }
        if (weatherSuccess)
        {
            [self.delegate weatherWasFoundForCity:aCity];
        }
    }
}

@end
