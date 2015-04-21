//
//  SearchViewController.h
//  Venue Menu
//
//  Created by Jim on 4/3/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataStack.h"


@import CoreLocation;  // for CLLocation

@protocol LocationServicesDelegate

// this will be called by thelocationservices class
// and implemented by this class.
- (void) locationWasFound:(CLLocation *)location;



@end

@interface SearchViewController : UIViewController <LocationServicesDelegate> // this is a contract that says must implement all required delgate methods ...

@property (nonatomic) NSMutableArray *venues;
@property  (nonatomic) CoreDataStack *cdStack;

@end
