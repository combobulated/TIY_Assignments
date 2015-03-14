//
//  Car+Extras.m
//  The Iron Yard
//
//  Created by Jim on 3/11/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "Car+Extras.h"

@implementation Car (Extras)



- (BOOL)paint:(NSString *)color;
{
    BOOL rc = NO;
   
    
   // lets add color
    if(color)
    {
        if( ![color isEqualToString:@""])
        {
            rc = YES;  // we have a requested paint color
            
            // now, lets paint the color
            // of the car in the class
            
            self.color = color;
        }
    }
    
    return rc;
    
}


- (BOOL)wash
{
    
    BOOL rc = NO;
    
    return rc;
    
}


@end
