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
    var containerView: UIView!
    
    var gameTitleLabel: UILabel!
    var team1Label: UILabel!
    var team2Label: UILabel!
    
    var games: RLMResults!
    var selectedGame: Game!
    
    let kMargin: CGFloat = (1.0/12.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Games"
        self.games = Game.allObjects()
        setupViews()
    }
    
    func setupViews() {
        let visibleHeight = self.view.bounds.height - self.navigationController!.navigationBar.frame.height - self.tabBarController!.tabBar.frame.height

//        self.containerView = UIView()
//        self.containerView.frame = CGRect(x: 0, y: self.navigationController!.navigationBar.frame.height, width: self.view.bounds.width, height: (visibleHeight * 0.4))
//        self.containerView.backgroundColor = UIColor.whiteColor()
        
        self.gamesTable = UITableView()
        self.gamesTable.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        self.gamesTable.delegate = self
        self.gamesTable.dataSource = self
        self.gamesTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
//        self.gameTitleLabel = UILabel()
//        self.gameTitleLabel.frame = CGRect(x: containerView.bounds.height * kMargin, y: containerView.bounds.height * (0.1), width: containerView.bounds.width - (containerView.bounds.height * 2 * kMargin), height: containerView.bounds.height * 0.2)
//        self.gameTitleLabel.font = UIFont(name: "Futura-CondensedMedium", size: 25.0)
//        self.gameTitleLabel.textAlignment = NSTextAlignment.Center
//        self.gameTitleLabel.text = "No Game Selected"
//        
//        self.team1Label = UILabel()
//        self.team1Label.frame = CGRect(x: containerView.bounds.height * kMargin, y: containerView.bounds.height * (0.1) + gameTitleLabel.bounds.height, width: (containerView.bounds.width - (containerView.bounds.height * 2 * kMargin)) * 0.5, height: containerView.bounds.height * 0.2)
//        self.team1Label.font = UIFont(name: "Futura-CondensedMedium", size: 16.0)
//        self.team1Label.textAlignment = NSTextAlignment.Center
//        self.team1Label.text = "Team 1"
//        
//        self.team2Label = UILabel()
//        self.team2Label.frame = CGRect(x: containerView.bounds.height * kMargin, y: containerView.bounds.height * (0.1) + gameTitleLabel.bounds.height, width: (containerView.bounds.width - (containerView.bounds.height * 2 * kMargin)) * 0.5, height: containerView.bounds.height * 0.2)
//        self.team2Label.font = UIFont(name: "Futura-CondensedMedium", size: 16.0)
//        self.team2Label.textAlignment = NSTextAlignment.Center
//        self.team2Label.text = "Team 2"

//        view.addSubview(containerView)
        view.addSubview(gamesTable)
//        containerView.addSubview(gameTitleLabel)
//        containerView.addSubview(team1Label)
//        containerView.addSubview(team2Label)
    }
    
    
    //    Required for table
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(games.count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = gamesTable.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        
        let selectedGame = self.games.objectAtIndex(UInt(indexPath.row)) as! Game
        cell.textLabel?.text = "Game played at \(selectedGame.datePlayed.toString())"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedGame = self.games.objectAtIndex(UInt(indexPath.row)) as! Game
        
    }
    
}