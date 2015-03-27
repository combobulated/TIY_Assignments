//
//  CounterItem.m
//  Counters on Table View
//
//  Created by Jim on 3/17/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CounterItem.h"

@implementation CounterItem

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _done = NO;
        _accumulatorString = @"";
    }
    
    return self;
}

- (NSMutableString *)incrementOneToCounter
{
    NSInteger count;
    NSMutableString *str = [[NSMutableString alloc]init];
    
    count = count + 1;
    
    [str appendString:[NSString stringWithFormat:@"%ld",(long)count]];
    
    return str;
    
}

- (NSMutableString *)decrementOneToCounter
{
    NSInteger count;
    NSMutableString *str = [[NSMutableString alloc]init];
   
    if (count > 0)
    {
        count = count - 1;
    }
    
    [str appendString:[NSString stringWithFormat:@"%ld",(long)count]];
    
    return str;
    
}



@end
