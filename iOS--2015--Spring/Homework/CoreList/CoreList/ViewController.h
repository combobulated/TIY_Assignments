//
//  ViewController.h
//  CoreList
//
//  Created by Jim on 3/31/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataStack.h"
#import "ListitemTableViewController.h"


@interface ViewController : UIViewController

@property (strong, nonatomic)   CoreDataStack *cdStack;
//@property (strong, nonatomic)   NSMutableArray *listitems;

@end

