//
//  DetailViewController.h
//  Venue Menu
//
//  Created by Jim on 4/5/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataStack.h"

@interface DetailViewController : UIViewController
// add selectedVenue
@property (strong, nonatomic) NSDictionary *selectedVenue;
@property  (nonatomic) CoreDataStack *cdStack;

@end

