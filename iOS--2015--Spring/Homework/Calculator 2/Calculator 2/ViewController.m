//
//  ViewController.m
//  Calculator al la Iron Yard
//
//  Created by Jim on 3/5/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain+Extras.h"




@interface ViewController ()


{
    CalculatorBrain *brain;  // instantiate brain object
    //    BOOL firstOperandSelected;
    
}


@property (weak,nonatomic) IBOutlet UILabel *displayLabel;
@property(nonatomic) BOOL showsTouchWhenHighlighted;

// operator and operand button will activate an ction
- (IBAction)operandTapped:(UIButton *)sender;
- (IBAction)additionTapped:(UIButton *)sender;
- (IBAction)subtractionTapped:(UIButton *)sender;
- (IBAction)multiplicationTapped:(UIButton *)sender;
- (IBAction)divisionTapped:(UIButton *)sender;
- (IBAction)equalsTapped:(UIButton *)sender;
- (IBAction)allClearTapped:(UIButton *)sender;
- (IBAction)plusMinusTapped:(UIButton*)sender;
- (IBAction)percentTapped:(UIButton*)sender;
- (IBAction)squareRootTapped:(UIButton*)sender;
- (IBAction)squaredTapped:(UIButton*)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    // set calculator display panel to display a "0"
    
    self.displayLabel.text = @"0";   //note displayLabel is UILabel
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// operand tapped


// We have an operand button press , lets pull in numbers from operand buttons
// and instanciate "brain"

- (IBAction) operandTapped:(UIButton *)sender
{
    
    _showsTouchWhenHighlighted = NO;
    
    if (!brain)
    {
        brain = [[CalculatorBrain alloc] init];
        //          firstOperandSelected = YES;
    }
    
    
    
    //    if (brain.operatorType == OperatorTypeNone)
    
    // first operand picked
    //    {
    
    // operator (+ , -, * etc ) yet chosen
    // load first operand
    
    //        firstOperandSelected = YES;
    
    // fetch the string from the button, append the string
    // to the nsmutableString
    
    //        [brain.operand1String appendString:sender.titleLabel.text];  //mutableString
    
    //        (NSString *) addOperandDigit:(NSString *)digit;
    
    //        [brain addOperandDigit:sender.titleLabel.text]
    
    //        self.displayLabel.text = brain.operand1String;               //mutableString
    self.displayLabel.text =
    [brain addOperandDigit:sender.titleLabel.text];
    
    // brain.operand1String;               //mutableString
    
    //    }
    
    //    else
    
    //second operand picked
    //    {
    //       firstOperandSelected = NO;
    //        [brain.operand2String appendString:sender.titleLabel.text];
    
    //        self.displayLabel.text = brain.operand2String;
    //    }
    
}



//- (IBAction)periodTapped:(UIButton *)sender
//{ if (brain)
//    {
//
//    }
//
//}


// operator button tapped

- (IBAction)plusMinusTapped:(UIButton *)sender
{
    if (brain)
    {
        
        //        [brain plusMinusOperand];
        [brain changeSign ];
        self.displayLabel.text = brain.resultString;
        //
        //        if (firstOperandSelected  )
        //        {
        //            [brain plusMinusOperand:firstOperandSelected ];
        //        }
        //        else
        //        {
        //            [brain plusMinusOperand:firstOperandSelected ];
        //        }
        //  self.displayLabel.text = brain.resultString;
    }
    
}

- (IBAction)percentTapped:(UIButton *)sender
{
    if (brain)
    {
        self.displayLabel.text = [ brain percentConversion ];
        //self.displayLabel.text = brain.resultString;
        
    }
}


- (IBAction)additionTapped:(UIButton *)sender
{
    
    // (just in case user taps operator first,
    //  we must not process operator. Allow initializing brain
    //  to an operand press.)
    //
    
    // place square or highlight around operator button
    // ( highlite will vanish when any operand button pressed
    // or equal button pressed.
    
    _showsTouchWhenHighlighted = YES;
    
    
    if (brain)
    {
        
        // do this in calculator brain
        //[brain addOperands ];
        
        brain.operatorType = OperatorTypeAddition;
        
    }
    
}



- (IBAction)subtractionTapped:(UIButton *)sender
{
    _showsTouchWhenHighlighted = YES;
    
    if (brain)
    {
        brain.operatorType = OperatorTypeSubtraction;
    }
    
    
}



- (IBAction)multiplicationTapped:(UIButton *)sender
{
    
    _showsTouchWhenHighlighted = YES;
    
    if (brain)
    {
        brain.operatorType = OperatorTypeMultiplication;
    }
}



- (IBAction)divisionTapped:(UIButton *)sender
{
    
    _showsTouchWhenHighlighted = YES;
    
    if (brain)
    {
        brain.operatorType = OperatorTypeDivision;
    }
}



- (IBAction)equalsTapped:(UIButton *)sender
{
    _showsTouchWhenHighlighted = NO;
    
    //    - (float) preformCalculation
    self.displayLabel.text = [ NSString stringWithFormat:@"%g",[brain preformCalculation ] ];
    //    self.displayLabel.text = brain.resultString;
    brain = nil;
    
    
    //  - (void)setString:(NSString *)aString
    
    
}


- (IBAction)allClearTapped:(UIButton *)sender
{
    _showsTouchWhenHighlighted = NO;
    
    self.displayLabel.text = @"0";
    
    brain = nil;
    
}


- (IBAction)squareRootTapped:(UIButton *)sender
{
    if (brain)
    {
        self.displayLabel.text = [ brain squareRootOperand ];
        //self.displayLabel.text = brain.resultString;
        
    }
    
}


- (IBAction)squaredTapped:(UIButton *)sender
{
    if (brain)
    {
        self.displayLabel.text = [ brain squareOperand ];
        
    }
    
}


@end
