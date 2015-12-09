//
//  TableViewController.swift
//  tipsCalc
//
//  Created by Darrell Shi on 12/4/15.
//  Copyright © 2015 Darrell Shi. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    override func viewDidLoad() {
        navigationItem.title = "Settings"
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("settingsCell", forIndexPath: indexPath)
        cell.textLabel?.text = "Change Percentages"
        return cell
    }
}