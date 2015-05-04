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

class SettingsViewController: UITableViewController {
    
    var items: [[String]]!
    var defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Set Preferences"
        self.items = [["3 Pointers Allowed", "Uneven Teams Allowed"],["Blue/Black [default]","Purple/Gold", "Blue/White", "Black/White"], ["Created with love by Jonathan Yu. This app uses the following plugins:", "FrostedSideBar", "AFDateExtension", "UIColorExtension"]]
        tableView = UITableView(frame: tableView.frame, style: .Grouped)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
//        self.view.addSubview(self.settingsTable)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case 0: return "Game Play Settings"
        case 1: return "Color Themes"
        case 2: return "Credits"
        default: fatalError("unknown section")
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0 {
            handleGameSettings(indexPath)
        } else if indexPath.section == 1 {
            handleColorSettings(indexPath)
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        cell.textLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 14.0)
        
        if indexPath.section == 0 {
            if (indexPath.row == 1 && self.defaults.objectForKey("threepoints") != nil) {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
        } else if indexPath.section == 1 {
            if (indexPath.row == self.defaults.integerForKey("colortheme")) {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            } else {
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
        } else if indexPath.section == 2 {
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
            cell.sizeToFit()
        }
        
        cell.textLabel?.text = self.items[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func handleGameSettings(indexPath: NSIndexPath) {
        var cell = self.tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!
        
        if indexPath.row == 0 {
            if cell.accessoryType == UITableViewCellAccessoryType.None {
                self.defaults.setBool(true, forKey: "threepoints")
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            } else {
                self.defaults.setBool(false, forKey: "threepoints")
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
        } else if indexPath.row == 1 {
            if cell.accessoryType == UITableViewCellAccessoryType.None {
                self.defaults.setBool(true, forKey: "uneventeams")
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            } else {
                self.defaults.setBool(false, forKey: "uneventeams")
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
        }
        
    }
    
    func handleColorSettings(indexPath: NSIndexPath) {
        var cell = self.tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!
        self.defaults.setInteger(indexPath.row, forKey: "colortheme")
        self.tableView.reloadData()
    }
    
}