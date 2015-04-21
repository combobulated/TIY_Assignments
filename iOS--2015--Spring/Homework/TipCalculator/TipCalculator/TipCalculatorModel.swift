//
//  TipCalculator.swift
//  TipCalculator
//
//  Created by Jim on 4/1/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

import Foundation
// makeing  a class .. TipCalculator

class TipCalculatorModel
{
    var total: Double
    var taxPercent: Double
    var subTotal: Double
        {
            // note: every time subTotal is accessed,
            // this getter willl be invoked.
            
            // note get is only needed if set is required
            // return will behave the same
            //        get
            //       {
            
            return total / (taxPercent + 1)
            ////      }
    }
    
    // collections of things to do as group.. methods,
    // are now called functions
    
    
    // all vars in a class must be initialzed
    // with an init function
    
    init(total: Double, taxPercent: Double)
    {
        self.total = total
        self.taxPercent = taxPercent
        // self  refers to class vars
        // total is function vars
        //  note they are not the same
        
        //    subTotal = total / (taxPercent + 1)
        
    }
    
    // creating a genral funciton in class
    //  tip percent is an argument, Double is the return var
    
    
    func calcTipWithTipPercent(tipPercent:Double) ->
        (tipAmount:Double, total:Double)
    {
        
        let tipAmount = subtotal * tipPercent
        let finalTotal = total + tipAmount
        return (tipAmount, finalTotal)
    }
    
    func printPossibleTips()
    {
        println(" 15%: \(calcTipWithTipPercent(0.15) )")
        println(" 18%: \(calcTipWithTipPercent(0.18) )")
        println(" 20%: \(calcTipWithTipPercent(0.20) )")
    }
    
    //  defining a dictionary, here keys are ints, values are doubles
    
    //    func returnPossibleTips() -> [Int: Double]
    
    func returnPossibleTips() -> [Int: (tipAmount:Double, total:Double)]
    {
        // this is an array assignment
        // Note, all members must be same type
        // Note, everything is swift is an object
        
        // immutable array
        let possibleTipsInferred = [0.15, 0.18, 0.20]
        
        // was mutable array
        // now dictionary of tupples
        var rValue = Dictionary<Int, (tipAmount:Double,total:Double)>()
        
        for possibleTip in possibleTipsInferred
        {
            let intPct = Int(possibleTip*100)
            // key is integerPercent  Value is calcTipWithTipPercent
            rValue[intPct] = calcTipWithTipPercent(possibleTip)
        }
        
        return rValue
        
    }
}

/*
class TipCalculatorModel
{
    var total: Double
    var taxPercent: Double
    var subTotal: Double
    {
        // note: every time subTotal is accessed, 
        // this getter willl be invoked.
        get
        {
        
          return total / (taxPercent + 1)
        }
    }
    
    // collections of things to do as group.. methods,
    // are now called functions
    
    
    // all vars in a class must be initialzed
    // with an init function
    
    init(total: Double, taxPercent: Double)
    {
        self.total = total
        self.taxPercent = taxPercent
        // self  refers to class vars
        // total is function vars
        //  note they are not the same
        
    //    subTotal = total / (taxPercent + 1)
        
    }
    
    // creating a genral funciton in class
    //  tip percent is an argument, Double is the return var
    
    func calcTipWithTipPercent(tipPercent: Double) -> Double
    {
        return subTotal * tipPercent
    }
    
    
    func printPossibleTips()
    {
        println(" 15%: \(calcTipWithTipPercent(0.15) )")
        println(" 18%: \(calcTipWithTipPercent(0.18) )")
        println(" 20%: \(calcTipWithTipPercent(0.20) )")
    }
    
    //  defining a dictionary, here keys are ints, values are doubles
    
    func returnPossibleTips() -> [Int: Double]
    {
        // this is an array assignment
        // Note, all members must be same type
        // Note, everything is swift is an object
        
        // immutable array
        let possibleTips = [0.15, 0.18, 0.20]
        
        // mutable array
        var rValue = [Int: Double]()
        for possibleTip in possibleTips
        {
            let integerPercent = Int(possibleTip*100)
            // key is integerPercent  Value is calcTipWithTipPercent
            rValue[integerPercent] = calcTipWithTipPercent(possibleTip)
        }
        
        return rValue
        
    }
    */k
}