//
//  GamesViewController.swift
//  jumpshot-2
//
//  Created by Jonathan Yu on 2/8/15.
//  Copyright (c) 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit
import Realm

class GamesViewController: UITableViewController, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    
    var games: RLMResults!
    var selectedGame: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Games"
        self.games = Game.allObjects()
        
        self.tableView.emptyDataSetDelegate = self
        self.tableView.emptyDataSetSource = self
        self.tableView.registerClass(GameTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.tableFooterView = UIView.new()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.games = Game.allObjects()
        self.tableView.reloadData()
    }
    
    deinit {
        self.tableView.emptyDataSetSource = nil
        self.tableView.emptyDataSetDelegate = nil
    }
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "No Games Here.", attributes: nil)
    }
    
    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "Confused")
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "When you play a game, it will appear here.", attributes: nil)
    }
    
    //    Required for table
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(games.count)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: GameTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! GameTableViewCell
        
        let selectedGame = self.games.objectAtIndex(UInt(indexPath.row)) as! Game
        cell.titleLabel?.text = "Game played at \(selectedGame.datePlayed.toString())"
        cell.team1Score.text = "\(selectedGame.tallyTeamScore(1))"
        cell.team2Score.text = "\(selectedGame.tallyTeamScore(2))"
        
        if selectedGame.tallyTeamScore(1) > selectedGame.tallyTeamScore(2) {
            cell.team1Score.backgroundColor = UIColor(rgba: "#27ae60")
        } else if selectedGame.tallyTeamScore(1) < selectedGame.tallyTeamScore(2) {
            cell.team2Score.backgroundColor = UIColor(rgba: "#27ae60")
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let actionsheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        actionsheet.addAction(cancelAction)
        
        let continueGameAction = UIAlertAction(title: "Continue Game", style: .Default) { (action) -> Void in
            
            var gameToContinue = self.games[UInt(indexPath.row)] as! Game
            
            let gameNavigation = NavigationController()
            let newGame: GamePadViewController = GamePadViewController()
            
            newGame.currentGame = gameToContinue
            tableView.setEditing(false, animated: true)
            
            gameNavigation.viewControllers = [newGame]
            self.navigationController?.presentViewController(gameNavigation, animated: true, completion: nil)
        }
        
        actionsheet.addAction(continueGameAction)
        
        let viewGameAction = UIAlertAction(title: "View Game Stats", style: .Default) { (action) -> Void in
            
            var gameToContinue = self.games[UInt(indexPath.row)] as! Game
            
        }
        
        actionsheet.addAction(viewGameAction)
        
        self.presentViewController(actionsheet, animated: true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65.0
    }

    
}