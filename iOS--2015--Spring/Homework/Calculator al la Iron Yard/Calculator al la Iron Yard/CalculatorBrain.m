//
//  CalculatorBrain.m
//  Calculator al la Iron Yard
//
//  Created by Jim on 3/5/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CalculatorBrain.h"

@implementation CalculatorBrain


- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        
        _operand1String = [[NSMutableString alloc] init];
        _operand2String = [[NSMutableString alloc] init];
       
        
        _operand1 = 0.0f;
        _operand2 = 0.0f;
        _result = 0.0f;
        
        _operatorType = OperatorTypeNone;  // an enum!
        
        _userIsTypingANumber = NO;
    
        
    }
    return self;
}


- (void) addOperands
{
    
    // 1. convert operand strings to floats
   //
    
   self.operand1 = [self.operand1String floatValue];
   self.operand2 = [self.operand2String floatValue];
    
   
    // for localization proper, ie europeans use "," in place of decimal point
    
//    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
//    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    
//    float _operand1 = [numberFormatter numberFromString:_operand1String].floatValue;
   
//    float _operand2 = [numberFormatter numberFromString:_operand2String].floatValue;
   
    
   // 2. add operators
    
    self.result = self.operand1 + self.operand2;

    
    
    // 3. convert result back to a string
    
//    self.resultString = [ NSString stringWithFormat:@" %f",self.result ];
    self.resultString = [ NSString stringWithFormat:@" %g",self.result ];
    
    
}

- (void) subtractOperands
{
    self.operand1 = [self.operand1String floatValue];
    self.operand2 = [self.operand2String floatValue];

    // for localization proper, ie europeans use "," in place of decimal point

    //    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    //    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;

    //    float _operand1 = [numberFormatter numberFromString:_operand1String].floatValue;

    //    float _operand2 = [numberFormatter numberFromString:_operand2String].floatValue;


    // 2. add operators

    self.result = self.operand1 - self.operand2;


    // 3. convert result back to a string

//    self.resultString = [NSString stringWithFormat:@" %f",self.result];
    self.resultString = [NSString stringWithFormat:@" %g",self.result];
}

- (void) multiplyOperands
{
    self.operand1 = [self.operand1String floatValue];
    self.operand2 = [self.operand2String floatValue];
    
    self.result = self.operand1 * self.operand2;
    
//    self.resultString = [NSString stringWithFormat:@" %f",self.result];
    self.resultString = [NSString stringWithFormat:@" %g",self.result];
    
}

- (void) divideOperands
{
    self.operand1 = [self.operand1String floatValue];
    self.operand2 = [self.operand2String floatValue];
    
    if (self.operand2 != 0)
    {
       self.result = self.operand1 / self.operand2;
//    self.resultString = [NSString stringWithFormat:@" %f",self.result];
       self.resultString = [NSString stringWithFormat:@" %g",self.result];
    }
    
    else
                
    {
        // we have a divide by zero error
//    self.resultString = [NSString stringWithFormat:@" %g",self.result];
        self.resultString = [NSString stringWithFormat:@" Error "];
    }
}

//- (void) plusMinusOperand:(BOOL)firstOperandSelected
- (void) plusMinusOperand
{
    if(self.operatorType == OperatorTypeNone)
    {
        self.operand1 = [self.operand1String floatValue];
        self.result = self.operand1 * -1.0;
        self.resultString = [NSString stringWithFormat:@" %f",self.result];
       [self.operand1String  setString:self.resultString];
    }
    else
    {
        self.operand2 = [self.operand2String floatValue];
        self.result = self.operand2 * -1.0;
        self.resultString = [NSString stringWithFormat:@" %f",self.result];
       [self.operand2String  setString:self.resultString];
    }
}


- (void) percentOperand
{
//    if (brain.operand operand) operand / 100;
    
    if(self.operatorType == OperatorTypeNone)
    {
        self.operand1 = [self.operand1String floatValue];
        self.result = self.operand1 / 100;
        self.resultString = [NSString stringWithFormat:@" %f",self.result];
       [self.operand1String  setString:self.resultString];
        
        
    }
    else
    {
        self.operand1 = [self.operand1String floatValue];
        self.result = self.operand2 / 100;
        self.resultString = [NSString stringWithFormat:@" %f",self.result];
       [self.operand2String  setString:self.resultString];
    }
}


- (void) completeEquate
{
    
    switch (self.operatorType)
    {
            
        case OperatorTypeAddition:
            [self addOperands];
            break;
           
        case OperatorTypeSubtraction:
            [self subtractOperands];
            break;
            
        case OperatorTypeMultiplication:
            [self multiplyOperands];
            break;
            
        case OperatorTypeDivision:
            [self divideOperands];
            break;
            
        default:
            break;
            
    }
    
}

@end
