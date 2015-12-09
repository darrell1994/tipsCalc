//
//  TipCalculator.swift
//  tipsCalc
//
//  Created by Darrell Shi on 12/9/15.
//  Copyright © 2015 Darrell Shi. All rights reserved.
//

class TipCalculator {
    var bill_ori: Float //bill before tip and split
    var splits: Int //number of people for splits
    var percentage: Float
    
    var totalTips: Float
    var totalBill: Float
    var totalTipsAfterSplit: Float
    var totalBillAfterSplit: Float
    
    init() {
        bill_ori = 0.0
        splits = 1
        percentage = 0.15
        
        totalTips = 0.0
        totalBill = 0.0
        totalTipsAfterSplit = 0.0
        totalBillAfterSplit = 0.0
    }
    
    private func updateTotalValues() {
        totalTips = bill_ori * percentage
        totalBill = bill_ori + totalTips
    }
    
    private func updateSplitValues() {
        totalTipsAfterSplit = totalTips / Float(splits)
        totalBillAfterSplit = totalBill / Float(splits)
    }

    
    func changeBill(bill: Float) {
        bill_ori = bill
        updateTotalValues()
        updateSplitValues()
    }
    
    func changeSplits(splits: Int) {
        self.splits = splits
        updateSplitValues()
    }
    
    func changePercentage(percentage: Float) {
        self.percentage = percentage
        updateTotalValues()
        updateSplitValues()
    }
    
    func getTotalTips()->Float {
        return totalTips
    }
    
    func getTotalBill()->Float {
        return totalBill
    }
    
    func getTotalTipsAfterSplit()->Float {
        return totalTipsAfterSplit
    }
    
    func getTotalBillAfterSplit()->Float {
        return totalBillAfterSplit
    }
}