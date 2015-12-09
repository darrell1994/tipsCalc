//
//  ViewController.swift
//  tipsCalc
//
//  Created by Darrell Shi on 12/2/15.
//  Copyright © 2015 Darrell Shi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let array = defaults.arrayForKey("percentages") as? [Int] {
            Percentages.tipPercent = array
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        tipSegment.removeAllSegments()
        for var i = Percentages.tipPercent.count-1; i > -1; i-- {
            tipSegment.insertSegmentWithTitle(String(Percentages.tipPercent[i])+"%", atIndex: 0, animated: false)
        }
        tipSegment.selectedSegmentIndex = 0
    }

    private func updateDisplay() {
        var bill = 0.0
        if (billTextField.text != "") { bill = Double(billTextField.text!)! }
        let tip = bill * Double(Percentages.tipPercent[tipSegment.selectedSegmentIndex]) / 100
        tipLabel.text = String(format: "$%.2f", tip)
        let total = bill + tip
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func billAmountEditingChanged(sender: AnyObject) {
        updateDisplay()
        sliderValueChanged(sender)
    }
    
    @IBOutlet weak var splitsSlider: UISlider!
    @IBOutlet weak var splitsLabel: UILabel!
    @IBOutlet weak var splitTipLabel: UILabel!
    @IBOutlet weak var splitTotalLabel: UILabel!
    @IBAction func sliderValueChanged(sender: AnyObject) {
        splitsLabel.text = String(Int(splitsSlider.value))
        var bill: Float = 0.0
        if (billTextField.text != "") { bill = Float(billTextField.text!)! }
        let tip = bill * Float(Percentages.tipPercent[tipSegment.selectedSegmentIndex]) / 100
        let total = bill + tip
        let splits = Int(splitsSlider.value)
        let eachTip = tip / Float(splits)
        let eachTotal = total / Float(splits)
        splitTipLabel.text = String(format: "$%.2f", eachTip)
        splitTotalLabel.text = String(format: "$%.2f", eachTotal)
    }
    
    @IBAction func backgroundTapped(sender: AnyObject) {
        billTextField.endEditing(true)
    }
    
    @IBAction func percentageChanged(sender: AnyObject) {
        updateDisplay()
        sliderValueChanged(sender)
    }
}