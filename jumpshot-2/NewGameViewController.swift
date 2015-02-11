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
        self.playersTable.registerClass(PlayerTableViewCell.self, forCellReuseIdentifier: "Cell")
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
        var cell: PlayerTableViewCell = playersTable.dequeueReusableCellWithIdentifier("Cell") as! PlayerTableViewCell
        
        let selectedPlayer = self.players.objectAtIndex(UInt(indexPath.row)) as! Player
        cell.nameLabel?.text = selectedPlayer.name
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        var team1action = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Team 1", handler: { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            println("Hello from \(indexPath.row)")
            tableView.setEditing(false, animated: true)
        })
        return [team1action]
    }
    
    
//    IBActions
    
    func startGame(sender: UIBarButtonItem) {
        println("Hello")
    }

}