//
//  TodoDetailTableViewController.h
//  In Due Time
//
//  Created by Jim on 3/29/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "todoItem.h"

@interface TodoDetailTableViewController : UITableViewController

@property (strong, nonatomic) TodoItem *item;

@end
