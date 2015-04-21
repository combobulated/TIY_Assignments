//
//  POITableViewController.h
//  Venue Menu
//
//  Created by Jim on 4/5/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataStack.h"


@interface POITableViewController : UITableViewController


// an array of dictionarys containing the venues returned by
//  the foursquare JASON API
@property (strong, nonatomic) NSMutableArray *venuesOfInterest;
@property  (nonatomic) CoreDataStack *cdStack;


@end
