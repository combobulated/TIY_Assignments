//
//  CalculatorBrain.h
//  CalculatorBrain
//
//  Created by Jim on 3/10/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//


#import <Foundation/Foundation.h>


typedef enum
{
    OperatorTypeNone,
    OperatorTypeAddition,
    OperatorTypeSubtraction,
    OperatorTypeMultiplication,
    OperatorTypeDivision,
    OperatorTypePercent,
    OperatorTypePlusMinus
    
} OperatorType;

@interface CalculatorBrain : NSObject



@property (strong, nonatomic) NSMutableString *operand1String;
@property (strong, nonatomic) NSMutableString *operand2String;
@property (strong, nonatomic) NSString *resultString;


@property (assign) float operand1;
@property (assign) float operand2;
@property (assign) float result;
@property (assign) OperatorType operatorType;
@property (assign) BOOL userIsTypingANumber;

- (void) completeEquate;

//- (void) plusMinusOperand:(BOOL)firstOperandSelected;
- (void) plusMinusOperand;
- (void) percentOperand;

//- (void) subtractOperands;


@end
