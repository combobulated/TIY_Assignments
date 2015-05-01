//
//  TicketOfPicksCell.m
//  JackPot3_delegate
//
//  Created by Jim on 4/22/15.
//  Copyright (c) 2015 JMD. All rights reserved.
//

#import "TicketOfPicksCell.h"

@implementation TicketOfPicksCell

- (void)awakeFromNib {
    // Initialization code
    firstPick.label.text = @"";
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
