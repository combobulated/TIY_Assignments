//
//  TodoItem.h
//  Todo
//
//  Created by Jim on 3/12/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum
{
    TaskPriorityNone,
    TaskPriorityLow,
    TaskPriorityMedium,
    TaskPriorityHigh
} TaskPriority;

@interface TodoItem : NSObject


@property (strong,nonatomic) NSString *taskName;
@property (assign) TaskPriority priority;


+ (NSArray *) allPriorityTypes;   // returns a string of our priority types

- (NSString *)priorityAsString;   // returns a string value of a given priority enumeration.
                                  // note that priority is initialized to None till
                                  // the enumeration is somewhere else in code base


@end
