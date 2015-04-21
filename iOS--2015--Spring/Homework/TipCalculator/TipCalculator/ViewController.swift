//
//  ViewController.swift
//  TipCalculator
//
//  Created by Jim on 4/1/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    // note, the ! means they optional, object or nil  
    
    // hooks ups are in video at around 16 minutes
    
    @IBOutlet var totalTextField : UITextField!
    @IBOutlet var taxPercentSlider : UISlider!
    @IBOutlet var taxPercentLabel : UILabel!
//    @IBOutlet var resultsTextView : UITextView!
    @IBOutlet var tableView: UITableView!
    
    
    
    // Construct the model with data
    
    let tipCalc = TipCalculatorModel(total:42.75 , taxPct: 0.06)
    var possibleTips = Dictionary<Int, (tipAmount:Double, total:Double)>()
    var sortedKeys:[Int] = []
    
    // let tipCalc  (to make model, import a new empty source
    //               swift file class, called TipCalculator)
   
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        refreshUI()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    @IBAction func calculateTapped(sender : AnyObject)
    {
        //  Calculate button pressed, for each tip percentage, calculate
        //  the tip for the the total bill ( less tax).
        
        //  note: AnyObject means this variabel can accept any type object
        //  note: here we are converting string to a double using swift and obj c
        
        tipCalc.total = Double((totalTextField.text as NSString).doubleValue)
        
        let possibleTips = tipCalc.returnPossibleTips()
 //       var results = ""
        sortedKeys = sorted(Array(possibleTips.keys))
        tableView.reloadData()
        
        // lets order our dictionary so we can print in order
//        
//        var keys = Array(possibleTips.keys)  //fetch keys to the dictionary
//        
//        // now sort
//        
//        sort(&keys)
//        
//        for tipPercent in keys
//            
//        {
//           let tipValue = possibleTips[ tipPercent ]!  //! means not optional value.
//           let prettyTipValue = String(format: "%.2f", tipValue) // first 2 dec after period
//           results += "\(tipPercent)%: $\(prettyTipValue)\n"  //  apend the results string
//        }
//        
//        resultsTextView.text = results
//        
    }

    @IBAction func calculateTappedChanged(sender : AnyObject)
    {
        
        //This is the slider is setting the tax percentage
        
        tipCalc.taxPercent = Double(taxPercentSlider.value) / 100.0
        refreshUI()
    }
    
    
    @IBAction func viewTapped(sender : AnyObject)
    {
        // here, touching any part of screen
        // will resign the keyboard
        
        totalTextField.resignFirstResponder()
    }
   
    
    func refreshUI()
    {
        
        //Bill Total (Post Tax) text field
        
        totalTextField.text = String(format: "%02f", tipCalc.total) //Bill Total (Post Tax)
       
        
        // the slider label
        
//        taxPercentSlider.value = Float(tipCalc.taxPercent) * 100
        taxPercentSlider.value = Float(tipCalc.taxPct) * 100
        taxPercentLabel.text = "Tax Percentage (\(Int(taxPercentSlider.value))%)"
      
        
        // suggested tip amount results displayed in view
        
//        resultsTextView.text = ""
        
        
    }
    

}


func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
{
    return sortedKeys.count
}

func func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
{
    let cell = UITableViewCell(style:
        UITableViewCellStyle.Value2,
        reuseIdentifier: nil)
    
    let tipPercent = sortedKeys[indexPath.row]
    let tipAmount = possibileTips[tipPercent]!.tipAmount
    let total = possibleTips[tipPercent]!.total
    cell.textLabel?.text ="\(tipPercent)%"
    cell.detailTextLabel?.text = String(format:"Tip: $%0.2f, Total: $%0.2f", tipAmount, total)
    return cell
}