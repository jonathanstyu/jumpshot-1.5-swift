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

    var playersRaw: RLMResults!
    var selectedPlayer: Player!
    
    var playersTable: UITableView!
    
    var startGameButton: UIBarButtonItem!
    
    var team1View: UIView!
    var team2View: UIView!
        
    var team1: [Player]!
    var team2: [Player]!
    var allPlayers: [Player]!
    
    var tableSections: [[Player]]!
    
    var gameToPlay: Game!
    
    let kMargin: CGFloat = (1.0/12.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Game"
        
        self.allPlayers = []
        self.playersRaw = Player.allObjects()
        
        for var i = 0; i < Int(playersRaw.count); ++i {
            self.allPlayers.append(playersRaw.objectAtIndex(UInt(i)) as! Player)
        }
        
        self.team1 = []
        self.team2 = []
        
        self.tableSections = [self.team1, self.team2, self.allPlayers]
        
        gameToPlay = Game()
        
        setupUIElements()
    }
    
    func setupUIElements() {
        let visibleHeight = self.view.bounds.height - self.navigationController!.navigationBar.frame.height - self.tabBarController!.tabBar.frame.height
        
        var startGameButton = UIBarButtonItem(title: "Start", style: .Plain, target: self, action: "startGame:")
        self.navigationItem.rightBarButtonItem = startGameButton
        
        self.playersTable = UITableView()
        self.playersTable.frame = CGRect(x: self.view.bounds.origin.x, y: self.navigationController!.navigationBar.frame.height, width: self.view.bounds.width, height: self.view.bounds.height)
        self.playersTable.delegate = self
        self.playersTable.dataSource = self
        self.playersTable.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
        
        view.addSubview(playersTable)
    }
    
//    Required for table
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.tableSections.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(self.tableSections[section].count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = playersTable.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        let section = self.tableSections[indexPath.section]
        let selectedPlayer = section[indexPath.row] as Player
        cell.textLabel!.text = selectedPlayer.name
//        cell.detailTextLabel!.text = "AGE: \(selectedPlayer.age) HEIGHT: \(selectedPlayer.height)"
        println("team1: \(self.tableSections[0].count); team2: \(self.tableSections[1].count)")
        
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
            
            var selectedPlayer = tableSections[indexPath.section][indexPath.row] as Player
            self.tableSections[0].append(selectedPlayer)
            
//            tableView.cellForRowAtIndexPath(indexPath)?.accessoryView = nil
//            teamBadge.text = "1"
//            teamBadge.backgroundColor = UIColor.darkGrayColor()
//            teamBadge.textColor = UIColor.whiteColor()
//            tableView.cellForRowAtIndexPath(indexPath)?.accessoryView = teamBadge
            
            tableView.setEditing(false, animated: true)
            tableView.reloadData()
        }
        
        let team2SelectClosure = { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            
            var selectedPlayer = tableSections[indexPath.section][indexPath.row] as Player
            self.tableSections[1].append(selectedPlayer)
            
//            tableView.cellForRowAtIndexPath(indexPath)?.accessoryView = nil
//            teamBadge.text = "2"
//            teamBadge.backgroundColor = UIColor.blueColor()
//            teamBadge.textColor = UIColor.whiteColor()
//            tableView.cellForRowAtIndexPath(indexPath)?.accessoryView = teamBadge
            
            tableView.setEditing(false, animated: true)
            tableView.reloadData()
        }
        
        let removeSelectClosure = { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            
            var selectedPlayer = tableSections[indexPath.section][indexPath.row] as Player
            
//            tableView.cellForRowAtIndexPath(indexPath)?.accessoryView = nil
            var oldSection = tableSections[indexPath.section]
            var newSection = oldSection.filter({$0 == selectedPlayer})
            self.tableSections[indexPath.section] = newSection
            
            tableView.setEditing(false, animated: true)
            tableView.reloadData()
        }
        
        var team1action = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Team 1", handler: team1SelectClosure)
        
        var team2action = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Team 2", handler: team2SelectClosure)
        
        var removeAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Clear", handler: removeSelectClosure)
        
        team1action.backgroundColor = UIColor.darkGrayColor()
        team2action.backgroundColor = UIColor.blueColor()
        removeAction.backgroundColor = UIColor.redColor()
        
//        Check accessory. If there is one then go check its text. 
        if indexPath.section == 2 {
            return [team1action, team2action]
        } else {
            if indexPath.section == 1 {
                return [team1action, removeAction]
            } else {
                return [team2action, removeAction]
            }
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var label : UILabel = UILabel()
        
        label.backgroundColor = UIColor.blackColor()
        
        if(section == 0){
            label.textColor = UIColor.whiteColor()
            label.text = "Team 1"
        } else if (section == 1){
            label.textColor = UIColor.orangeColor()
            label.text = "Team 2"
        } else {
            label.textColor = UIColor.whiteColor()
            label.text = "Unchosen"
        }
        return label
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
//    IBActions
    
    func startGame(sender: UIBarButtonItem) {
        let gameNavigation = UINavigationController()
        let newGame: GamePadViewController = GamePadViewController()
        
        newGame.currentGame = gameToPlay
        gameNavigation.viewControllers = [newGame]
        navigationController?.presentViewController(gameNavigation, animated: true, completion: nil)
        
    }

}