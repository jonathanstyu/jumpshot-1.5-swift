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

    var players: RLMResults!
    var selectedPlayer: Player!
    
    var playersTable: UITableView!
    
    var startGameButton: UIBarButtonItem!
    
    var containerView: UIView!
    
    var gameTitleLabel: UILabel!
    var team1Label: UILabel!
    var team2Label: UILabel!
    
    let kMargin: CGFloat = (1.0/12.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        players = Player.allObjects()
        self.title = "New Game"
        
        setupUIElements()
    }
    
    func setupUIElements() {
        let visibleHeight = self.view.bounds.height - self.navigationController!.navigationBar.frame.height - self.tabBarController!.tabBar.frame.height
        
        var startGameButton = UIBarButtonItem(title: "Start", style: .Plain, target: self, action: "startGame:")
        self.navigationItem.rightBarButtonItem = startGameButton
        
        self.containerView = UIView()
        self.containerView.frame = CGRect(x: 0, y: self.navigationController!.navigationBar.frame.height, width: self.view.bounds.width, height: (visibleHeight * 0.4))
        self.containerView.backgroundColor = UIColor.whiteColor()
        
        self.gameTitleLabel = UILabel()
        self.gameTitleLabel.frame = CGRect(x: containerView.bounds.height * kMargin, y: containerView.bounds.height * (0.1), width: containerView.bounds.width - (containerView.bounds.height * 2 * kMargin), height: containerView.bounds.height * 0.2)
        self.gameTitleLabel.font = UIFont(name: "Futura-CondensedMedium", size: 25.0)
        self.gameTitleLabel.textAlignment = NSTextAlignment.Center
        self.gameTitleLabel.text = "Adding Players ..."

        self.team1Label = UILabel()
        self.team1Label.frame = CGRect(x: containerView.bounds.height * kMargin, y: containerView.bounds.height * (0.1) + gameTitleLabel.bounds.height, width: (containerView.bounds.width - (containerView.bounds.height * 2 * kMargin)) * 0.5, height: containerView.bounds.height * 0.2)
        self.team1Label.font = UIFont(name: "Futura-CondensedMedium", size: 16.0)
        self.team1Label.textAlignment = NSTextAlignment.Center
        self.team1Label.text = "Team 1"

        self.team2Label = UILabel()
        self.team2Label.frame = CGRect(x: (containerView.bounds.height * kMargin) + team1Label.frame.width, y: containerView.bounds.height * (0.1) + gameTitleLabel.bounds.height, width: (containerView.bounds.width - (containerView.bounds.height * 2 * kMargin)) * 0.5, height: containerView.bounds.height * 0.2)
        self.team2Label.font = UIFont(name: "Futura-CondensedMedium", size: 16.0)
        self.team2Label.textAlignment = NSTextAlignment.Center
        self.team2Label.text = "Team 2"
        
        self.playersTable = UITableView()
        self.playersTable.frame = CGRect(x: self.view.bounds.origin.x, y: self.navigationController!.navigationBar.frame.height + self.containerView.frame.height, width: self.view.bounds.width, height: self.view.bounds.height)
        self.playersTable.delegate = self
        self.playersTable.dataSource = self
        self.playersTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(playersTable)
        view.addSubview(containerView)
        containerView.addSubview(gameTitleLabel)
        containerView.addSubview(team1Label)
        containerView.addSubview(team2Label)
        
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
        
        let removeSelectClosure = { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            
            var selectedPlayer = players.objectAtIndex(UInt(indexPath.row)) as! Player
            println("\(selectedPlayer.name) to remove")
            
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryView = nil
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryView = nil
            
            tableView.setEditing(false, animated: true)
        }
        
        var team1action = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Team 1", handler: team1SelectClosure)
        
        var team2action = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Team 2", handler: team2SelectClosure)
        
        var removeAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Clear", handler: removeSelectClosure)
        
        team1action.backgroundColor = UIColor.greenColor()
        team2action.backgroundColor = UIColor.blueColor()
        removeAction.backgroundColor = UIColor.redColor()
        
        return [team1action, team2action, removeAction]
    }
    
    
//    IBActions
    
    func startGame(sender: UIBarButtonItem) {
        println("Hello")
    }

}