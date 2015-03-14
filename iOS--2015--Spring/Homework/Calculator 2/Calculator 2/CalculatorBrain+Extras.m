//
//  CalculatorBrain+Extras.m
//  Calculator 2
//
//  Created by Jim on 3/11/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CalculatorBrain+Extras.h"
//#include <metal_stdlib>
//using namespace metal;

@implementation CalculatorBrain (Extras)

- (NSString *) squareRootOperand
{
    float operand;
    //
    if ( self.operatorType == OperatorTypeNone )
    {
        operand = self.operand1;
    }
    else
    {
        operand = self.operand2;
    }
    
    self.result = sqrtf(operand);
    self.resultString = [NSString stringWithFormat:@"%g",self.result];
    return self.resultString;
}

- (NSString *) squareOperand
{
    float operand;
    //
    if ( self.operatorType == OperatorTypeNone )
        
    {
        operand = self.operand1;
    }
    else
    {
        operand = self.operand2;
    }
    
    self.result = operand * operand;
    self.resultString = [NSString stringWithFormat:@"%g",self.result];
    return self.resultString;
}

@end
