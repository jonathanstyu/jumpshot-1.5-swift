//
//  SettingsViewController.swift
//  jumpshot-2
//
//  Created by Jonathan Yu on 4/28/15.
//  Copyright (c) 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit
import Realm

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var settingsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Preferences"
        self.settingsTable = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height), style: .Grouped)
        self.settingsTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(self.settingsTable)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.settingsTable.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        cell.textLabel?.text = "Hello"
        
        return cell
    }
    
}