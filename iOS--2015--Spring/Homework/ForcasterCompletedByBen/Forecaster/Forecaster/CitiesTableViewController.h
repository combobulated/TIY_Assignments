//
//  CitiesTableViewController.h
//  Forecaster
//
//  Created by Ben Gohlke on 3/21/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"

@protocol CitiesTableViewControllerDelegate

- (void)cityWasFound:(City *)aCity;
- (void)weatherWasFoundForCity:(City *)aCity;
- (void) saveCityData;// add data step E  needed for appdelegate
@end

@interface CitiesTableViewController : UITableViewController <CitiesTableViewControllerDelegate>

@end
