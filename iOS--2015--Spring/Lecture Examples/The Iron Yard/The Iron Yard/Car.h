//
//  Car.h
//  The Iron Yard
//
//  Created by Jim on 3/4/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject
// this is the car class!

// here, we will define the car class methods
// For a car dealership data base,  lets model
// odometer, fuel, color make and model.


@property (copy) NSString *make;
@property (copy) NSString *model;
@property (copy) NSString *color;

- (instancetype)initWithMake:(NSString *)make model:(NSString *)model andColor:(NSString *)Color;


// performs drive action, and returns success or failure

- (BOOL)drive;



@end
