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

class GamesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var gamesTable: UITableView!
    
    var games: RLMResults!
    var selectedGame: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Games"
        self.games = Game.allObjects()
        setupViews()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.games = Game.allObjects()
        self.gamesTable.reloadData()
    }
    
    func setupViews() {
        
        self.gamesTable = UITableView()
        self.gamesTable.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        self.gamesTable.delegate = self
        self.gamesTable.dataSource = self
        self.gamesTable.registerClass(GameTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(gamesTable)
    }
    
    
    //    Required for table
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(games.count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: GameTableViewCell = gamesTable.dequeueReusableCellWithIdentifier("Cell") as! GameTableViewCell
        
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let actionsheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        actionsheet.addAction(cancelAction)
        
        let continueGameAction = UIAlertAction(title: "Continue Game", style: .Default) { (action) -> Void in
            
            var gameToContinue = self.games[UInt(indexPath.row)] as! Game
            
            let gameNavigation = UINavigationController()
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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65.0
    }

    
}