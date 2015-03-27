//
//  CounterItem.h
//  Counters on Table View
//
//  Created by Jim on 3/17/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CounterItem : NSObject

@property (strong, nonatomic) NSString *accumulatorString;
@property (strong, nonatomic) NSString *title;
@property (assign) BOOL done;

- (NSMutableString *) decrementOneToCounter;
- (NSMutableString *) incrementOneToCounter;

@end
