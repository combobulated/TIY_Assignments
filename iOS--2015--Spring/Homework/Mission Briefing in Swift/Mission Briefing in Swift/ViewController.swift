//
//  ViewController.swift
//  Mission Briefing in Swift
//
//  Created by Jim on 4/1/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

import UIKit

// step 1 add UITextFieldDelegate, also make sure storyboard text fields
// link to "delegate"  

class ViewController: UIViewController, UITextFieldDelegate
{

// step 2, the storyboard instance variable outlet
    
    @IBOutlet var agentNameTextField: UITextField!
    @IBOutlet var agentPasswordTextField: UITextField!
    @IBOutlet var greetingLabel: UILabel!
    @IBOutlet var missionBriefingTextView: UITextView!
  
  
   //----
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        agentNameTextField.delegate = self    //set delegate to textfile
        agentPasswordTextField.delegate = self
        
        agentNameTextField.text = ""
        greetingLabel.text = ""
        missionBriefingTextView.text = ""
        
    }
    
   // any model constructors can go here

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func authenticateAgentButton(sender : AnyObject)
    {
        authenticateAgent()
    }
    
    func authenticateAgent()
    {
        // Dismiss keyboard when the authenticate button is tapped
        
        if agentNameTextField.isFirstResponder()
        {
            agentNameTextField.resignFirstResponder()
        }
       
//      If BOTH name and password textfields not empty,
        
        
        var textInputCompleted = false
        
        if ( !(agentNameTextField.text.isEmpty) && !(agentPasswordTextField.text.isEmpty ))
        {
            textInputCompleted = true
        }
        
        
       if textInputCompleted
       {
        
           self.view.backgroundColor = UIColor.greenColor()
        
           var fullName = agentNameTextField.text
           var fullNameArray = agentNameTextField.text.componentsSeparatedByString(" ")
        
           var lastName: String
        
           if fullNameArray.count <= 1
           {
             lastName = fullNameArray[0]
           }
           else
           {
              lastName = fullNameArray[1]
           }

           // var lastName: String? = fullNameArr.count > 1 ? fullNameArr[1] : nil
           greetingLabel.text = "Good evening Agent, \(lastName)"
        
           missionBriefingTextView.text = "This mission will be an arduous one, fraught with peril. You will cover much strange and unfamiliar territory. Should you choose to accept this mission, Agent \(lastName), you will certainly be disavowed, but you will be doing your country a great service. This message will self destruct in 5 seconds. "
       }
       else
       {
        self.view.backgroundColor = UIColor.redColor()
       }
        
        
    }

    func textFieldShouldReturn(textField: UITextField!) -> Bool        //delegate method
    {
        textField.resignFirstResponder()
        
        println("entered textFieldShouldReturn")
        
        var agentTextCompleted = false
        var pwdTextCompleted = false
        
        if !agentNameTextField.text.isEmpty
        {
            agentTextCompleted = true
        }
        if !agentPasswordTextField.text.isEmpty
        {
            pwdTextCompleted = true
        }
        
        
        if !pwdTextCompleted && agentTextCompleted
        {
            agentNameTextField.resignFirstResponder()
            agentPasswordTextField.becomeFirstResponder()
        }
        
        if !pwdTextCompleted
        {
            agentNameTextField.resignFirstResponder()
            authenticateAgent()
        }
        
        return true
    }
    
}

        

    
    


