//
//  JMDLocationServices.h
//  Venue Menu
//
//  Created by Jim on 4/4/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchViewController.h"

@interface JMDLocationServices : NSObject

// most recent latitude and longitude

@property (assign) double latitude;
@property (assign) double longitude;
@property (assign) BOOL didUpdateLocation; //true if location recently updated

@property   (strong, nonatomic) id<LocationServicesDelegate> delegate;




// Be sure to invoke ConfigurationManager
// before enableLocationManager.

// configureLocationManager sets up location manager
// services and enables location manager to on.
// if unsuccessfull, returns NO.

- (BOOL)configureLocationManager;


//  eanbleLoactionManager allows developer
//  to turn the service off or on
//  YES for on, NO for off

- (void)enableLocationManager:(BOOL)enable;


@end
