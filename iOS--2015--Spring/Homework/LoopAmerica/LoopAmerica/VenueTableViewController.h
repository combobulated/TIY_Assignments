//
//  VenueTableViewController.h
//  LoopAmerica
//
//  Created by Jim on 4/18/15.
//  Copyright (c) 2015 JMD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataStack.h"
#import "JMDLocationServices.h"


@import CoreLocation;  // for CLLocation

@interface VenueTableViewController : UIViewController  <LocationServicesDelegate> // this is a contract that says must implement all required delgate methods ...

@property (strong, nonatomic)   CoreDataStack *cdStack;
@property (strong, nonatomic) UITableView *tableView;

@end

//@protocol LocationServicesDelegate

// this will be called by thelocationservices class
// and implemented by this class.
//- (void)locationWasFound:(CLLocation *)location;

//@end