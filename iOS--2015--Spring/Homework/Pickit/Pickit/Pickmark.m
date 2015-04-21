//
//  Pickmark.m
//  Pickit
//
//  Created by Jim on 4/7/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "Pickmark.h"


@implementation Pickmark
{
    CLLocation *_theLocation;
    UIImage *_image;
    NSUUID *_identifier;
}

- (instancetype)initWithLocation:(CLLocation *)aLocation andImage:(UIImage *)image
{
    self = [super init];
    if (self)
    {
        _theLocation = aLocation;
        _image = image;
        _identifier = [NSUUID UUID];
    }
    
    return self;
}

- (instancetype)initWithRecord:(CKRecord *)record
{
    self = [super init];
    if (self)
    {
        _theLocation = [record objectForKey:@"Location"];
        _image = [record objectForKey:@"Image"];
    }
    
    return self;
}

- (NSString *)title
{
    return @"A Picmark";
}

- (CLLocationCoordinate2D)coordinate
{
    return _theLocation.coordinate;
}

- (UIImage *)image
{
    return _image;
}

- (NSString *)uuid
{
    return [NSString stringWithFormat:@"%@", _identifier];
}

@end
