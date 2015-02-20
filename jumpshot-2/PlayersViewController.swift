//
//  PlayersViewController.swift
//  jumpshot-2
//
//  Created by Jonathan Yu on 2/8/15.
//  Copyright (c) 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit
import Realm

class PlayersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var playersTable: UITableView!
    
    var headerBar: UIView!
    
    var teamBadge: UILabel!
    var headerBarLabel1: UILabel!
    var headerBarLabel2: UILabel!
    var headerBarLabel3: UILabel!
    var headerBarLabel4: UILabel!

    var players: RLMResults!
    var selectedPlayer: Player!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Available Players"
        
        players = Player.allObjects()
        
        setupBar()
        setupPlayersTable()
    }
    
    func setupPlayersTable() {
        
        self.playersTable = UITableView()
        self.playersTable.frame = CGRect(x: self.view.bounds.origin.x, y: (headerBar.bounds.height), width: self.view.bounds.width, height: (self.view.bounds.height - headerBar.bounds.height))
        self.playersTable.delegate = self
        self.playersTable.dataSource = self
        
        self.playersTable.registerClass(PlayerTableViewCell.self, forCellReuseIdentifier: "Cell")

        view.addSubview(playersTable)
    }
    
    func setupBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addPlayer")
        
        self.headerBar = UIView(frame: CGRect(x: self.view.bounds.origin.x, y: self.navigationController!.navigationBar.frame.height, width: self.view.frame.width, height: 40))
        self.headerBar.backgroundColor = UIColor.grayColor()
        
        self.headerBarLabel1 = UILabel()
        self.headerBarLabel1.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width / 4.0, height: headerBar.frame.height)
        self.headerBarLabel1.text = "PTS"
        self.headerBarLabel1.textColor = UIColor.whiteColor()
        self.headerBarLabel1.font = UIFont(name: "Futura-CondensedMedium", size: 20.0)
        self.headerBarLabel1.textAlignment = NSTextAlignment.Center
        
        self.headerBarLabel2 = UILabel(frame: CGRect(x: self.view.bounds.width * (1.0/4.0), y: 0, width: self.view.bounds.width / 4.0, height: headerBar.bounds.height))
        self.headerBarLabel2.text = "REBS"
        self.headerBarLabel2.textColor = UIColor.whiteColor()
        self.headerBarLabel2.font = UIFont(name: "Futura-CondensedMedium", size: 20.0)
        self.headerBarLabel2.textAlignment = NSTextAlignment.Center

        self.headerBarLabel3 = UILabel(frame: CGRect(x: self.view.bounds.width * (2.0/4.0), y: 0, width: self.view.bounds.width / 4.0, height: headerBar.bounds.height))
        self.headerBarLabel3.text = "ASTS"
        self.headerBarLabel3.textColor = UIColor.whiteColor()
        self.headerBarLabel3.font = UIFont(name: "Futura-CondensedMedium", size: 20.0)
        self.headerBarLabel3.textAlignment = NSTextAlignment.Center

        self.headerBarLabel4 = UILabel(frame: CGRect(x: self.view.bounds.width * (3.0/4.0), y: 0, width: self.view.bounds.width / 4.0, height: headerBar.bounds.height))
        self.headerBarLabel4.text = "BLKS"
        self.headerBarLabel4.textColor = UIColor.whiteColor()
        self.headerBarLabel4.font = UIFont(name: "Futura-CondensedMedium", size: 20.0)
        self.headerBarLabel4.textAlignment = NSTextAlignment.Center
        
        self.navigationController!.navigationBar.addSubview(headerBar)
        headerBar.addSubview(self.headerBarLabel1)
        headerBar.addSubview(self.headerBarLabel2)
        headerBar.addSubview(self.headerBarLabel3)
        headerBar.addSubview(self.headerBarLabel4)
    }
    
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
        
        cell.pointsAveragelabel?.text = String(format: "%.1f", selectedPlayer.averageStatistic("points"))
        cell.reboundsAverageLabel?.text = String(format: "%.1f", selectedPlayer.averageStatistic("rebounds"))
        cell.assistsAveragelabel?.text = String(format: "%.1f", selectedPlayer.averageStatistic("assists"))
        cell.blocksAveragelabel?.text = String(format: "%.1f", selectedPlayer.averageStatistic("blocks"))
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75.0
    }
        
//    IBActions
    
    func addPlayer() {
        println("Hello there")
    }

    
}