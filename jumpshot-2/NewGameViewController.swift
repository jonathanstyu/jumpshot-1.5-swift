//
//  NewGameViewController.swift
//  jumpshot-2
//
//  Created by Jonathan Yu on 2/10/15.
//  Copyright (c) 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit
import Realm

class NewGameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var playersTable: UITableView!
    var players: RLMResults!
    var selectedPlayer: Player!
    var teamBadge: UILabel!
    
    var startGameButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        players = Player.allObjects()
        setupPlayersTable()
        setupUIElements()
    }
    
    func setupPlayersTable() {
        self.playersTable = UITableView()
        self.playersTable.frame = CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: self.view.bounds.width, height: self.view.bounds.height)
        self.playersTable.delegate = self
        self.playersTable.dataSource = self
        self.playersTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(playersTable)
    }
    
    func setupUIElements() {
        var startGameButton = UIBarButtonItem(title: "Start", style: .Plain, target: self, action: "startGame:")
        self.navigationItem.rightBarButtonItem = startGameButton
    }
    
//    Required for table
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(players.count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = playersTable.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        let selectedPlayer = self.players.objectAtIndex(UInt(indexPath.row)) as! Player
        cell.textLabel?.text = selectedPlayer.name
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        var teamBadge = UILabel()
        teamBadge.textColor = UIColor.blackColor()
        teamBadge.font = UIFont(name: "Lato-Regular", size: 16)
        teamBadge.textAlignment = NSTextAlignment.Center
        teamBadge.layer.cornerRadius = 4
        teamBadge.clipsToBounds = true
        teamBadge.frame = CGRectMake(0, 0, 50, 20)

        
        let team1SelectClosure = { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            
            var selectedPlayer = players.objectAtIndex(UInt(indexPath.row)) as! Player
            println("Hello from \(selectedPlayer.name)")
            
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryView = nil
            teamBadge.text = "1"
            teamBadge.backgroundColor = UIColor.yellowColor()
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryView = teamBadge
            
            tableView.setEditing(false, animated: true)
        }
        
        let team2SelectClosure = { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            
            var selectedPlayer = players.objectAtIndex(UInt(indexPath.row)) as! Player
            println("Hello from \(selectedPlayer.name)")
            
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryView = nil
            teamBadge.text = "2"
            teamBadge.backgroundColor = UIColor.blueColor()
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryView = teamBadge
            
            tableView.setEditing(false, animated: true)
        }
        
        var team1action = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Team 1", handler: team1SelectClosure)
        
        var team2action = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Team 2", handler: team2SelectClosure)
        
        team1action.backgroundColor = UIColor.greenColor()
        team2action.backgroundColor = UIColor.blueColor()
        
        return [team1action, team2action]
    }
    
    
//    IBActions
    
    func startGame(sender: UIBarButtonItem) {
        println("Hello")
    }

}