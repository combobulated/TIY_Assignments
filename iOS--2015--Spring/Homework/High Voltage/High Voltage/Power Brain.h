//
//  Power Brain.h
//  High Voltage
//
//  Created by Jim on 3/12/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>


// may not need these enums
typedef enum
{
    ParameterSelectedNone,
    ParameterSelectedVolts,
    ParameterSelectedAmps,
    ParameterSelectedOhms,
    ParameterSelectedWatts
} GivenParameter;




@interface Power_Brain : NSObject

// parameters
@property (strong, nonatomic)(NSMutableString *)stringVolts;
@property (strong, nonatomic)(NSMutableString *)tringAmps;
@property (strong, nonatomic)NSMutableString *stringOhms;
@property (strong, nonatomic)NSMutableString *stringWatts;

@property (strong, nonatomic)NSMutableArray *allParameters;

@property (assign) GivenParameter given;

//  methods go here

+ (NSArray *) allParameterTypes;  // returns a string of our parameter types

- (BOOL) computeTwoAnswersAsString;   // sets  string values of calculated param
                                    // assumes two parameters are defined
                                    // sets remaining two parameters
                                    // return Yes if successfull

/*
// sample code under interface from Todo project
@property (strong,nonatomic) NSString *taskName;
@property (assign) TaskPriority priority;


+ (NSArray *) allPriorityTypes;   // returns a string of our priority types

- (NSString *)priorityAsString;   // returns a string value of a given priority enumeration.
// note that priority is initialized to None till
// the enumeration is somewhere else in code base
*/

@end



