//
//  CounterTableViewCell.h
//  Counters on Table View
//
//  Created by Jim on 3/17/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CounterTableViewCell : UITableViewCell

@property (weak,nonatomic) IBOutlet UIButton *downButton;
@property (weak,nonatomic) IBOutlet UIButton *upButton;
@property (weak,nonatomic) IBOutlet UILabel *countLabel;
@property (weak,nonatomic) IBOutlet UITextField *counterNameTextField;
@property (weak,nonatomic) IBOutlet UIButton *checkBoxButton;



@end
