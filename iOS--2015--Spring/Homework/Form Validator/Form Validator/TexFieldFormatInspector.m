//
//  TexFieldFormatInspector.m
//  Form Validator
//
//  Created by Jim on 3/9/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//




#import "TexFieldFormatInspector.h"

@ interface TexFieldFormatInspector ()

{
    BOOL rc;
}

@end


@implementation TexFieldFormatInspector

// methods go here


-(BOOL) verifyNameField textField
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
    
    return rc;
    
}


- (BOOL) verifyAddressField:((NSString *)textField.text)
{
            // retuns a boolean Yes if field passes formatting test.
           
       {
            // here we use detect for address, for example. Detector filters
            // and screens text input
   
            rc = NO;
    
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

    
    return rc;
    
}


- (BOOL) verifyZipCodeField:( (NSString *)zipCode )
{

        BOOL rc = NO;
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        
        if ([zipCode length] == 5 && [zipCode rangeOfCharacterFromSet:set].location != NSNotFound)
        {
            rc = YES;
        }
        
        return rc;
    
}



-(BOOL) verifyStateField
{
    
    return rc;
    
}



    


-(BOOL) verifyPhoneNumberField
{
    
    return rc;
    
}

@end