//
//  Power Brain.m
//  High Voltage
//
//  Created by Jim on 3/12/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//


#import "Power Brain.h"

// given two values calculate the other two values.
// values are a selection of either:
// power in watts
// volts in Volts
// current in Amps
// resistance in Ohms




@implementation Power_Brain

{
    float result;
}

// OHMS
// R = V/I
// R = V^2 / P
// R = P/I^2

// AMPS
// I = V/R
// I = P/V
// I = Square Root of (P/R)

//VOLTS
//V=IR
//V=P/I
//V=Square Root of ( P*R )

//WATTS
//P=V*I
//P=V^2/R
//P=I^2*R


//



 // pseudo code


  // function will receive two parameters
  // stored as a public string
  // the other two will be calculated and
  // and stored in a public string
  // lets make an array called

//   parm 1  parm 2
//   parm 1  parm 3
//   parm 1  parm 4
//
//   parm 2  parm 1
//   pamr 2  parm 3
//   parm 2  parm 4
//
//   parm 3  parm 1
//   parm 3  parm 2
//   parm 3  parm 4
//   parm 3  pamr 4
//
//   parm 4 parm 1
//   parm 4 parm 2
//   parm 4 parm 3
//

-(instancetype)initWithParameters:(NSMutableArray *)parameters;

{
    self = [super init];
   
    if( self )
    {
        _allParameters = parameters;
       
        _allParameters = [[ NSMutableArray alloc] init];
        
    }
    
    return self;
}



    
// sample code from todo

//+ (NSArray *)allParamaterTypes
//{
    //note we have class method... method works on class
    // no instanciation of an object required
    
//    return @[@"", @"Medium", @"High" ];
//}



    
- (BOOL) computeTwoAnswersAsString
    
{
   // for ref, our 4 parameters defined in header
    
    float volts;
    float amps;
    float ohms;
    float watts;
    

   // convert strings to floats
   
//   volts = [floatVal self.stringVolts ];
////   amps =  [floatVal self.stringAmps  ];
//   ohms =  [floatVal self.stringOhms  ];
//   watts = [floatVal self.stringWatts ];
    
    NSLog ( @"volts = %g", volts );
    NSLog ( @"amps  = %g", amps  );
    NSLog ( @"ohms  = %g", ohms  );
    NSLog ( @"watts = %g", watts );
    
    
   // this is not what i want, but a start
    
    NSString *rc;
    
    switch (self.given)
    {
        case ParameterSelectedVolts:
            
//          volts = ?
            // if I and R true
//              V=IR
            
            // if P and I true
//              V=P/I
            
            // if P and R true
//              V=Square Root of ( P*R )
            
            result = 10.0;
            [self.stringVolts appendString:[NSString stringWithFormat:@"%g",result]];
            rc = @"Volts";
            
            break;
            
        case ParameterSelectedAmps:
            
            // AMPS
            
            // if V and R True
            //    I = V/R
            
            // if P and V True
            //    I = P/V
            
            // if P and R True
            //   I = Square Root of (P/R)
            
            result = 9.0;
            [self.stringAmps appendString:[NSString stringWithFormat:@"%g",result]];
            rc = @"Amps";
            
            break;
            
        case ParameterSelectedOhms:
            
            // OHMS
            //  if V and I true
            //    R = V/I
            
            // if V and P true
            //    R = V^2 / P
            
            // if P and I true
            //    R = P/I^2
            
            
            result = 8.0;
            [self.stringOhms appendString:[NSString stringWithFormat:@"%g",result ]];
            
            rc = @"Ohms";
            
            break;

        case ParameterSelectedWatts:
            
//          WATTS
            
         // if V and I
//          P=V*I
            
         // if V and R
//          P=V^2/R
           
          // if I and R
//          P=I^2*R
            
            result = 7.0;
            [self.stringWatts appendString:[NSString stringWithFormat:@"%g",result]];
            
            rc = @"Watts";
            
        default:
            
            rc = @"";
            
            break;
    }
    
    return rc;
}

@end
