//
//  TodoItem.m
//  Todo
//
//  Created by Jim on 3/12/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "TodoItem.h"

@implementation TodoItem


+ (NSArray *)allPriorityTypes
{
    //note we have class method... method works on class
    // no instanciation of an object required
    
    return @[@"Low", @"Medium", @"High" ];
}



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
        _priority = TaskPriorityNone;  // _priority is an instance variable name
    }
   
    return self;
}

 - (NSString *)priorityAsString
    {
        NSString *rc;
        
        switch (self.priority)
        {
            case TaskPriorityLow:
                
                rc = @"Low";
                
                break;
                
            case TaskPriorityMedium:
                
                rc = @"Medium";
                
                break;
                
            case TaskPriorityHigh:
                
                rc = @"High";
                
                break;
                
            default:
                
                rc = @"";
                
                break;
        }
        
        return rc;
    }


@end
