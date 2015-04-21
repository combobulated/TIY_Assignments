//
//  VenueNameTableViewCell.h
//  LoopAmerica
//
//  Created by Jim on 4/19/15.
//  Copyright (c) 2015 JMD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VenueNameTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *venueNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityOfVenueLabel;
@property (weak, nonatomic) IBOutlet UILabel *milesFromCurrentLocationLabel;

@end
