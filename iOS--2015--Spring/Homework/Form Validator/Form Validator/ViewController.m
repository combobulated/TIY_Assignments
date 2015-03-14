//
//  ViewController.m
//  Form Validator
//
//  Created by Jim on 3/9/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate >

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *addressTextField;
@property (strong, nonatomic) IBOutlet UITextField *stateTextField;
@property (strong, nonatomic) IBOutlet UITextField *zipCodeTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@end

@implementation ViewController




-(BOOL) textFieldShouldReturn:(UITextField *)textField

{
    
    __block BOOL rc = NO;
    
    if (![textField.text isEqualToString:@" "])
    {
        // text field not empty
        //  Which text field picked?
        //   we test pointer locations to find out.
        
        if (textField == self.nameTextField)   // note comparing pointers ok
        {
          
           // call a checkNameField method with nameTextField.text as argument.
            // retuns a boolean Yes if field passes formatting test.
           
            
            // here we use detect for address, for example. Detector filters
            // and screens text input
            
            NSError *error = nil;
            NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeAddress error:&error ];
            [ detector enumerateMatchesInString:textField.text
                                        options:kNilOptions     // no options
                                          range:NSMakeRange(0,[textField.text length]) // text len
                                     usingBlock:
             ^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop)
             
             {
                 rc = YES;  //note: this is a block
             } ];
        }
    }
    
    
    if (rc)
    {
        [textField resignFirstResponder];  //keyboard will hide!
    }
    
    return rc;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


/*  bens sample code:
 - (BOOL)validateZipCode:(NSString *)zipCode
 {
 BOOL rc = NO;
 NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
 
 if ([zipCode length] == 5 && [zipCode rangeOfCharacterFromSet:set].location != NSNotFound)
 {
 rc = YES;
 }
 
 return rc;
 }

*/