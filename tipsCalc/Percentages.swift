//
//  Percentages.swift
//  tipsCalc
//
//  Created by Darrell Shi on 12/4/15.
//  Copyright © 2015 Darrell Shi. All rights reserved.
//

import Foundation
import UIKit

struct Percentages {
    static var tipPercent = [10, 15, 18, 20, 23, 25]
    
    static func insert(percent: Int, index: Int) {
        tipPercent.insert(percent, atIndex: index)
        tipPercent.sortInPlace()
    }
    
    static func remove(index: Int) {
        tipPercent.removeAtIndex(index)
    }
    
    static func printAll() {
        let length = tipPercent.count
        for var i = 0; i < length; i++ {
            print("\(tipPercent[i]), ")
        }
    }
}