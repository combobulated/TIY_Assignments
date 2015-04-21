//
//  VenueNameTableViewCell.m
//  LoopAmerica
//
//  Created by Jim on 4/19/15.
//  Copyright (c) 2015 JMD. All rights reserved.
//

#import "VenueNameTableViewCell.h"

@implementation VenueNameTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.venueNameLabel.text = @"";
    self.cityOfVenueLabel.text=@"";
    self.milesFromCurrentLocationLabel.text=@"";
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end