//
//  tipPercentSettingViewController.swift
//  tipsCalc
//
//  Created by Darrell Shi on 12/4/15.
//  Copyright © 2015 Darrell Shi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var tipSegment: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        tipSegment.removeAllSegments()
        for var i = Percentages.tipPercent.count-1; i > -1; i-- {
            tipSegment.insertSegmentWithTitle(String(Percentages.tipPercent[i])+"%", atIndex: 0, animated: false)
        }
        tipSegment.selectedSegmentIndex = 0
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let index = defaults.integerForKey("defaultIndex")
        tipSegment.selectedSegmentIndex = index
    }
    
    override func viewWillDisappear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(Percentages.tipPercent, forKey: "percentages")
        defaults.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func addTapped(sender: AnyObject) {
//        let prePercent = tipSegment.titleForSegmentAtIndex(tipSegment.selectedSegmentIndex)
//        let prePercentNum = Int((prePercent?.substringToIndex((prePercent?.endIndex.advancedBy(-1))!))!)
//        var newPercent: String
//        if tipSegment.selectedSegmentIndex == tipSegment.numberOfSegments-1 {
//            newPercent = "\(prePercentNum!+5)%"
//        } else {
//            let nextPercent = tipSegment.titleForSegmentAtIndex(tipSegment.selectedSegmentIndex+1)
//            let nextPercentNum = Int((nextPercent?.substringToIndex((nextPercent?.endIndex.advancedBy(-1))!))!)
//            newPercent = "\((prePercentNum!+nextPercentNum!)/2)%"
//        }
//        tipSegment.insertSegmentWithTitle(newPercent, atIndex: tipSegment.selectedSegmentIndex+1, animated: true)
//        Percentages.insert(Double(newPercent.substringToIndex(newPercent.endIndex.advancedBy(-1)))!, index: tipSegment.selectedSegmentIndex+1)
//    }
    
    @IBAction func removeTapped(sender: AnyObject) {
        let alertcontroller = UIAlertController(title: "Are you sure you want to remove \(Percentages.tipPercent[tipSegment.selectedSegmentIndex])%?", message: "", preferredStyle: .Alert)
        
        alertcontroller.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
            Percentages.remove(self.tipSegment.selectedSegmentIndex)
            self.viewWillAppear(true)
        }))
        
        alertcontroller.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alertcontroller, animated: true, completion: nil)
    }
    
    @IBAction func addTapped(sender: AnyObject) {
        var newPercent: UITextField!
        let alertcontroller = UIAlertController(title: "Add a percentage", message: "", preferredStyle: .Alert)
        alertcontroller.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            textField.placeholder = "<e.g 15>"
            textField.keyboardType = UIKeyboardType.NumberPad
            newPercent = textField
        }
        
        alertcontroller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{ (UIAlertAction)in
            print("New percentage: \(newPercent.text)")
            if let newPercentInt = Int(newPercent.text!) {
                if newPercentInt > 500 {
                    let alert = UIAlertController(title: "Error", message: "The percentages has to be less than 500%", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIKit.UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                } else {
                    Percentages.insert(newPercentInt, index: 0)
                }
            }
            self.viewWillAppear(true)
        }))
        
        self.presentViewController(alertcontroller, animated: true, completion: nil)
    }
    
    @IBAction func defaultTapped(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tipSegment.selectedSegmentIndex, forKey: "defaultIndex")
        defaults.synchronize()
    }
    
}