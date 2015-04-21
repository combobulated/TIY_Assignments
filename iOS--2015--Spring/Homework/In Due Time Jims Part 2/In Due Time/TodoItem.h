//
//  TodoItem.h
//  In Due Time
//
//  Created by Ben Gohlke on 3/16/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodoItem : NSObject

@property (strong, nonatomic) NSString *title;
//@property (strong, nonatomic) NSString *dueDate;
//@property (strong, nonatomic) NSString *eventLocation;  //later, a location object
//@property (strong, nonatomic) NSString *textNote;
@property (assign) BOOL done;

@end
