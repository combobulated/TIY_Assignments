//
//  Weather.h
//  Forcaster
//
//  Created by Jim on 3/20/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

//temp vars for preliminary tests
@property (strong, nonatomic) NSString *weatherCity;
//@property (strong, nonatomic) NSString *weatherZip;
@property (strong, nonatomic) NSString *weatherLat;  //latitude
@property (strong, nonatomic) NSString *weatherLng;  //longitude

// Bens version
// 
@property (assign) double temperature;
@property (assign) double apparentTemperature;
@property (assign) double dewPoint;
@property (assign) double humidity;
@property (assign) double precipProbability;
@property (assign) double windSpeed;

@property (strong, nonatomic) NSString *summary;
@property (strong, nonatomic) NSString *icon;

- (NSString *)currentTemperature;
- (NSString *)feelsLikeTemperature;
- (NSString *)dewPointTemperature;
- (NSString *)humidityPercentage;
- (NSString *)chanceOfRain;
- (NSString *)windSpeedMPH;

- (BOOL)parseWeatherInfo:(NSDictionary *)infoDictionary;


@end
