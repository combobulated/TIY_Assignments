//
//  TodoItem.m
//  HW 13 In Due Time Part 1
//
//  Created by Jim on 3/16/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "TodoItem.h"

@implementation TodoItem

// TODO: overide init so priority can be initially set to none
// init will return an instancetype. an instancetype is
// an instance of a class... (similar to id, but preferred)

-(instancetype) init
{
    
    // super is a reference to our parent class
    //  call the init method of the parent class
    //  when object is returned, assign it to self, a pointer
    // to self.  an instance of NSObject class.
    
    self = [super init];
    
    // verify self exists
    // and set task priority enumeration to default to none
    if ( self)
    {
//        _priority = TaskPriorityNone;  // _priority is an instance variable name
        self.taskName = @"";
    }
    
    return self;
}


@end
