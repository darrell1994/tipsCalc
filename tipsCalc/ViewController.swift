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
    
    var tipCalculator = TipCalculator()
    var currencySymbol = ""
    
    @IBOutlet weak var currencySymbolLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let array = defaults.arrayForKey("percentages") as? [Int] {
            Percentages.tipPercent = array
        }
        if let billAmount = defaults.stringForKey("billAmount") {
            billTextField.text = billAmount
        }
        

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
        
        currencySymbol = getCurrencySymbol()
        currencySymbolLabel.text = currencySymbol
        billAmountEditingChanged(self)
    }
    
    @IBAction func billAmountEditingEnded(sender: AnyObject) {
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(billTextField.text, forKey: "billAmount")
    }

    private func updateDisplay() {
        tipLabel.text = String(format: "\(currencySymbol)%.2f", tipCalculator.getTotalTips())
        totalLabel.text = String(format: "\(currencySymbol)%.2f", tipCalculator.getTotalBill())
        splitTipLabel.text = String(format: "\(currencySymbol)%.2f", tipCalculator.getTotalTipsAfterSplit())
        splitTotalLabel.text = String(format: "\(currencySymbol)%.2f", tipCalculator.getTotalBillAfterSplit())
    }
    
    @IBAction func billAmountEditingChanged(sender: AnyObject) {
        if billTextField.text != nil {
            let billText = billTextField.text!
            if billText == "" {
                totalLabel.text = "\(currencySymbol)0.0"
                tipCalculator.changeBill(0.0)
            } else {
                if let bill = Float(billText) {
                    tipCalculator.changeBill(bill)
                    updateDisplay()
                }
            }
        }
    }
    
    @IBOutlet weak var splitsSlider: UISlider!
    @IBOutlet weak var splitsLabel: UILabel!
    @IBOutlet weak var splitTipLabel: UILabel!
    @IBOutlet weak var splitTotalLabel: UILabel!
    @IBAction func sliderValueChanged(sender: AnyObject) {
        splitsLabel.text = String(Int(splitsSlider.value))
        tipCalculator.changeSplits(Int(splitsSlider.value))
        updateDisplay()
    }
    
    @IBAction func backgroundTapped(sender: AnyObject) {
        billTextField.endEditing(true)
    }
    
    @IBAction func percentageChanged(sender: AnyObject) {
        let percent = Percentages.tipPercent[tipSegment.selectedSegmentIndex]
        tipCalculator.changePercentage(Float(percent) / 100)
        updateDisplay()
    }
    
    private func getCurrencySymbol()->String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        let currencyString = "\(formatter.currencyCode)"
        let locale = NSLocale(localeIdentifier: currencyString)
        let currencySymbol = locale.displayNameForKey(NSLocaleCurrencySymbol, value: currencyString)!
        return currencySymbol
    }
}