//
//  CurrentWeatherTableViewCell.m
//  Forcaster
//
//  Created by Jim on 3/21/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CurrentWeatherTableViewCell.h"

@implementation CurrentWeatherTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

/*
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:default reuseIdentifier:"CurrentWeaherCell"];
            
            if (self){
                //create subview
                
                cityNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
                // Put in on the content view of the cell
                [[self contentView] addSubview:cityNameLabel];
                
               // it is being retained by its superview
  //              [cityNameLabel release];   // forbiden by ARC
                
                currentTempLabel = [[UILabel alloc] initWithFrame:CGRectZero];
                // Put in on the content view of the cell
                [[self contentView] addSubview:currentTempLabel];
               
                
                
                currentWeatherLabel = [[UILabel alloc] initWithFrame:CGRectZero];
                
                // Put in on the content view of the cell
                [[self contentView] addSubview:currentWeatherLabel];
                
                
                weatherImage = [[UIImageView alloc] initWithFrame:CGRectZero];
                // Put in on the content view of the cell
                [[self contentView] addSubview:weatherImage];
                
                // tell the imageview to center its image inside its frame
                [weatherImage setContentMode:UIViewContentModeCenter];
                
            }
    
}
*/

@end
