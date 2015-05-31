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

class NewGameViewController: UITableViewController, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {

    var playersRaw: RLMResults!
    var selectedPlayer: Player!
    
    var startGameButton: UIBarButtonItem!
    var resetButton: UIBarButtonItem!
    
    var team1View: UIView!
    var team2View: UIView!
        
    var team1: [Player]!
    var team2: [Player]!
    var allPlayers: [Player]!
    
    var tableSections: [[Player]]!
    
    var headerLabelTitles: [String] = ["points", "rebounds", "assists", "steals", "blocks"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Game"
        
//        Take all the Player objects out of the RLMResults Object
        self.allPlayers = []
        self.playersRaw = Player.allObjects()
        
        for var i = 0; i < Int(playersRaw.count); ++i {
            self.allPlayers.append(playersRaw.objectAtIndex(UInt(i)) as! Player)
        }
        
        self.team1 = []
        self.team2 = []
        
        self.tableView.emptyDataSetDelegate = self
        self.tableView.emptyDataSetSource = self
//        self.tableView.tableFooterView = UIView.new()
        
        self.tableSections = [self.team1, self.team2, self.allPlayers]
        
        setupUIElements()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    func setupUIElements() {
        let visibleHeight = self.view.bounds.height - self.navigationController!.navigationBar.frame.height
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addPlayer")
        var startGameButton = UIBarButtonItem(title: "Start", style: .Plain, target: self, action: "startGame:")
        var resetButton = UIBarButtonItem(title: "Reset", style: .Plain, target: self, action: "resetGame:")
        
        self.navigationItem.rightBarButtonItems = [startGameButton, resetButton]
        
//        Set up the index bar and the headers
        var indexBar = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: self.navigationController!.navigationBar.frame.height, width: self.view.frame.width, height: 40))
        indexBar.backgroundColor = UIColor(rgba: "#f0f0d0")
        
        var headerLabelTitles = ["POINTS", "REBOUNDS", "ASSISTS", "STEALS", "BLOCKS"]
        for var i = 0; i < 5; ++i {
            var headerLabel = UILabel()
            headerLabel.frame = CGRect(x: (indexBar.bounds.size.width / 5.0) * CGFloat(i), y: 0, width: (indexBar.bounds.size.width / 5.0), height: indexBar.frame.size.height)
            headerLabel.text = headerLabelTitles[i]
            headerLabel.textColor = UIColor.blackColor()
            headerLabel.font = UIFont(name: "ArialRoundedMTBold", size: 12.0)
            headerLabel.textAlignment = NSTextAlignment.Center
            indexBar.addSubview(headerLabel)
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(PlayerTableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
        
    }
    
//    Required for table
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.tableSections.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(self.tableSections[section].count)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: PlayerTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! PlayerTableViewCell
        
        let section = self.tableSections[indexPath.section]
        let selectedPlayer = section[indexPath.row] as Player
        
//        cell.bottomBar.backgroundColor = UIColor(rgba: "#8e44ad")
        cell.nameLabel?.text = selectedPlayer.name.uppercaseString
        
        cell.gamesCountLabel?.text = "\(selectedPlayer.playerStatLines.count)"
        cell.pointsAveragelabel?.text = String(format: "%.1f", selectedPlayer.averageStatistic("points"))
        cell.reboundsAverageLabel?.text = String(format: "%.1f", selectedPlayer.averageStatistic("rebounds"))
        cell.assistsAveragelabel?.text = String(format: "%.1f", selectedPlayer.averageStatistic("assists"))
        cell.blocksAveragelabel?.text = String(format: "%.1f", selectedPlayer.averageStatistic("blocks"))
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45.0
    }
    
//    For initializing and presenting the PlayerProfile Controller
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
//    Handles the swipe and the team selection process
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        let team1SelectClosure = { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            
            var selectedPlayer = self.tableSections[indexPath.section][indexPath.row] as Player
            for var i = 0; i < self.tableSections[2].count; ++i {
                if self.tableSections[2][i] == selectedPlayer {
                    self.tableSections[2].removeAtIndex(i)
                    self.tableSections[0].append(selectedPlayer)
                }
            }
            
            tableView.setEditing(false, animated: true)
            tableView.reloadData()
        }
        
        let team2SelectClosure = { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            
            var selectedPlayer = self.tableSections[indexPath.section][indexPath.row] as Player
            
            for var i = 0; i < self.tableSections[2].count; ++i {
                if self.tableSections[2][i] == selectedPlayer {
                    self.tableSections[2].removeAtIndex(i)
                    self.tableSections[1].append(selectedPlayer)
                }
            }
            
            tableView.setEditing(false, animated: true)
            tableView.reloadData()
        }
        
        let removeSelectClosure = { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            
            var selectedPlayer = self.tableSections[indexPath.section][indexPath.row] as Player
            
            for var i = 0; i < self.tableSections[indexPath.section].count; ++i {
                if self.tableSections[indexPath.section][i] == selectedPlayer {
                    self.tableSections[indexPath.section].removeAtIndex(i)
                    self.tableSections[2].append(selectedPlayer)
                }
            }
            
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
    
//    Custom header for the individual sections
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var headerView : UIView = UIView(frame: CGRectMake(0, 0, self.view.bounds.size.width, 50.0))
        var label : UILabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, headerView.bounds.size.height / 2.0))
        
        label.font = UIFont(name: "ArialRoundedMTBold", size: 15.0)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = NSTextAlignment.Center
        
        if(section == 0){
            headerView.backgroundColor = UIColor(rgba: "#27ae60")
            label.textColor = UIColor.whiteColor()
            label.text = "Team 1"
        } else if (section == 1){
            headerView.backgroundColor = UIColor(rgba: "#34495e")
            label.textColor = UIColor.orangeColor()
            label.text = "Team 2"
        } else {
            headerView.backgroundColor = UIColor(rgba: "#95a5a6")
            label.textColor = UIColor.blackColor()
            label.text = "Unchosen"
        }
        
        headerView.addSubview(label)
        return headerView
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
//    For the empty data set state
    
    deinit {
        self.tableView.emptyDataSetSource = nil
        self.tableView.emptyDataSetDelegate = nil
    }
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "No Players Here.", attributes: nil)
    }
    
//    IBActions
    
    func startGame(sender: UIBarButtonItem) {
        let gameNavigation = UINavigationController()
        let newGame: GamePadViewController = GamePadViewController()
        
        newGame.currentGame = Factory.createGame(team1: self.tableSections[0], team2: self.tableSections[1])
        
        gameNavigation.viewControllers = [newGame]
        navigationController?.presentViewController(gameNavigation, animated: true, completion: nil)
    }
    
    func resetGame(sender: UIBarButtonItem) {
        self.tableSections[0].removeAll(keepCapacity: true)
        self.tableSections[1].removeAll(keepCapacity: true)
        self.tableSections[2] = self.allPlayers
        
        self.tableView.reloadData()
    }
    
    func addPlayer() {
        var inputTextField: UITextField?
        
        //        Initialize the UIAlertController
        let addItem: UIAlertController = UIAlertController(title: "New Player Name?", message: "Input their name below.", preferredStyle: .Alert)
        
        //        Initialize the button
        let cancelItem: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: { action -> Void in
            
        })
        addItem.addAction(cancelItem)
        
        //        Initialize the Confirm button
        let addItemButton: UIAlertAction = UIAlertAction(title: "Add", style: .Default, handler: { action -> Void in
            
            var newPlayerName: String = inputTextField!.text as String
            Factory.createNewPlayer(newPlayerName)
        })
        
        addItem.addAction(addItemButton)
        
        //        Initalize the Text Field
        addItem.addTextFieldWithConfigurationHandler { textField -> Void in
            inputTextField = textField
            textField.textColor = UIColor.blueColor()
        }
        
        self.presentViewController(addItem, animated: true, completion: nil)
        
    }


}