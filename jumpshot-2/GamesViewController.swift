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
        setupGamesTable()
    }
    
    func setupGamesTable() {
        
        self.gamesTable = UITableView()
        self.gamesTable.frame = CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.x, width: self.view.bounds.width, height: self.view.bounds.height)
        self.gamesTable.delegate = self
        self.gamesTable.dataSource = self
        self.gamesTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(gamesTable)
    }
    
    func setupUIElements() {
        
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
        cell.textLabel?.text = selectedGame.datePlayed.toString()
        
        return cell
    }
    
}