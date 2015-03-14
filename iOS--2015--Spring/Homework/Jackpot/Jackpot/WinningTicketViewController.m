//
//  WinningTicketViewController.m
//  Jackpot
//
//  Created by Jim on 3/4/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "WinningTicketViewController.h"

@interface WinningTicketViewController ()



@property (weak, nonatomic) IBOutlet UITextField *nameTextField_1;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField_2;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField_3;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField_4;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField_5;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField_6;


- (IBAction)buttonTapped:(id)sender;


@end


@implementation WinningTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Action Handlers

- (IBAction)buttonTapped:(id)sender
{
    NSLog(@"Button pressed");
  
    [self testButtonField: _nameTextField_1.text
                         : (NSString *)_nameTextField_2.text
                         : (NSString *)_nameTextField_3.text
                         : (NSString *)_nameTextField_4.text
                         : (NSString *)_nameTextField_5.text
                         : (NSString *)_nameTextField_6.text];
   
    
   // convert text fields to integers

    
    
    
   // verify text fields to be numbers between 1 and 52
    
    
    
}

- (void) testButtonField:(NSString *)text1 :(NSString *)text2
                                           :(NSString *)text3
                                           :(NSString *)text4
                                           :(NSString *)text5
                                           :(NSString *)text6
{
   
    NSMutableArray *textInput = [[NSMutableArray alloc]init];
                    
    [textInput addObject:text1];
    [textInput addObject:text2];
    [textInput addObject:text3];
    [textInput addObject:text4];
    [textInput addObject:text5];
    [textInput addObject:text6];
    
    NSMutableArray *WinningNumbers = [[NSMutableArray alloc]init];
   
    
    
    
 //   NSString *text5 = @"funny stuff this is";
    NSLog(@"%@ %@ %@ %@ %@ %@",text1, text2, text3, text4, text5, text6);
   
   //sample string to int
   // NSString *string = /* Assume this exists. */;
   // int value = [string intValue];
  
    
    for (int i=0; i < [textInput count]; i++ ) {
       
        NSLog(@"%@", [textInput objectAtIndex:i ]);
        
        
        
    }
    
    
    return;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
