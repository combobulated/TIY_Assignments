//
//  main.m
//  The Iron Yard
//
//  Created by Jim on 3/4/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Car.h"
#import "Car+Extras.h"




int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
       
        Car *aCar = [[Car alloc] initWithMake:@"Toyota"
                                        model:@"Camry"
                                     andColor:@"Red"];
        
   //     aCar.make = @"Toyota";
   //     aCar.model = @"Camry";
   //     aCar.color = @"Red";

        
//        for ( int i = 0; i < 6; i++)
//        {
//            driveCar(aCar);
//        }

        NSLog (@"%@  %@ is  %@", aCar.make, aCar.model, aCar.color);
        [aCar drive];
        [aCar paint:@"Blue"];
        NSLog (@"%@  %@ is  %@", aCar.make, aCar.model, aCar.color);
        
    }
    
    return 0;
}


