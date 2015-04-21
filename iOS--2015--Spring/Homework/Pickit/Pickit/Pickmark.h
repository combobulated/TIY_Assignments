//
//  Pickmark.h
//  Pickit
//
//  Created by Jim on 4/7/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@import MapKit;
@import CloudKit;
@import CoreLocation;


@interface Pickmark : NSObject <MKAnnotation>

- (instancetype) initWithLocation:(CLLocation *)aLocation andImage:(UIImage *)image;
- (instancetype) initWithRecord:(CKRecord *)record;
- (UIImage *)image;
- (NSString *) uuid;


@end
