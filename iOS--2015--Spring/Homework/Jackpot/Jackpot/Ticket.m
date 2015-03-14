//
//  Ticket.m
//  Jackpot
//
//  Created by Jim on 3/3/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "Ticket.h"

@interface Ticket ()
{
    NSMutableArray *numbers;
}
@end



@implementation Ticket


+ (instancetype)ticketUsingQuickPick
{
    Ticket *aTicket = [[Ticket alloc] init];
    for(int i = 0; i<6; i++)
    {
        [aTicket pickAndAddANumber ];
    }
    return aTicket;
}


// override init method

- (instancetype)init
{
    if (self = [super init])
    {
        numbers = [[NSMutableArray alloc] init];
    }
    
    return self;
}


- (NSString *)description
{
   // add code like this
//    NSString string = stringWithformat ... numbers
    
    NSString *string = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@", numbers[0], numbers[1], numbers[2], numbers[3], numbers[4], numbers[5] ];

    return string;
    
}

// generate a random whole number between 1 and 52
// return an NSNmber object for NSarray. NSarray requires objects.
                        
- ( void )pickAndAddANumber
{
//    int pickInt = rand();
//    
    
    int anInt = rand() % 52;   //% is modulus
   // [ numbers addObject:[NSNumber numberWithInt:anInt ];  // add without sort
    
    // add number
    NSNumber *aNumber = [NSNumber numberWithInt:anInt];
    [ numbers addObject:aNumber];
    
    // sort
    NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    
    [numbers sortUsingDescriptors:@[lowestToHighest]];
    
}

@end
