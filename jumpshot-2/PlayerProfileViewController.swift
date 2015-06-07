//
//  PlayerProfileViewController.swift
//  jumpshot-2
//
//  Created by Jonathan Yu on 2/22/15.
//  Copyright (c) 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit
import Realm

class PlayerProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var containerView: UIView!
    
    var nameLabel: UILabel!
    var selectedPlayer: Player!
    
    var gamesTable: UITableView!
    
    var backButton: UIButton!
    
    var headerLabelTitles: [String] = ["points", "rebounds", "assists", "steals", "blocks"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        UINavigationBar.appearance().barStyle = UIBarStyle.Default
        navigationItem.title = "Player Profile For \(selectedPlayer.name.capitalizedString)"
        setupViews()
        setupTableView()
    }
    
    func setupViews() {
        
        self.containerView = UIView()
        self.containerView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: (self.view.bounds.size.height * 0.33))
        self.containerView.backgroundColor = UIColor(rgba: "#31320f")
        
        nameLabel = UILabel()
        nameLabel.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 55)
        nameLabel.font = UIFont(name: "ArialRoundedMTBold", size: 24.0)
        nameLabel.backgroundColor = UIColor(rgba: "#f9f7cc")
        nameLabel.textColor = UIColor.blackColor()
        nameLabel.text = selectedPlayer.name.capitalizedString
        
        self.containerView.addSubview(nameLabel)
//        self.containerView.addSubview(dismissButton)
        view.addSubview(self.containerView)
    }
    
    func setupTableView() {
        self.gamesTable = UITableView()
        
        self.gamesTable.frame = CGRect(x: 0, y: (self.view.bounds.size.height * 0.33), width: self.view.bounds.width, height: (self.view.bounds.height * 0.67))
        self.gamesTable.delegate = self
        self.gamesTable.dataSource = self
        
        self.gamesTable.registerClass(PlayerTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(self.gamesTable)

    }    
    
//    UITableView necessary 
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: PlayerTableViewCell = gamesTable.dequeueReusableCellWithIdentifier("Cell") as! PlayerTableViewCell
        
        let gameStatline = self.selectedPlayer.playerStatLines.objectAtIndex(UInt(indexPath.row)) as! Statline
        let playedGame = gameStatline.game as Game!
        
        cell.nameLabel?.numberOfLines = 0
        cell.nameLabel?.text = "Game Played On: \(playedGame.datePlayed.toString()) \n Team 1: \(playedGame.tallyTeamScore(1)) || Team 2: \(playedGame.tallyTeamScore(2))"
        
        cell.gamesCountLabel?.text = "\(gameStatline.points)"
        cell.pointsAveragelabel?.text = "\(gameStatline.rebounds)"
        cell.reboundsAverageLabel?.text = "\(gameStatline.assists)"
        cell.assistsAveragelabel?.text = "\(gameStatline.steals)"
        cell.blocksAveragelabel?.text = "\(gameStatline.blocks)"

        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var indexBar = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        indexBar.backgroundColor = UIColor(rgba: "#f0f0d0")
        
        for var i = 0; i < 5; ++i {
            var headerContainView = UIView()
            var headerLabel = UILabel()
            
            
            headerContainView.frame = CGRect(x: (indexBar.bounds.size.width / 5.0) * CGFloat(i), y: 0, width: (indexBar.bounds.size.width / 5.0), height: indexBar.frame.size.height)
            headerLabel.frame = CGRectMake(0, 0, headerContainView.bounds.size.width, headerContainView.bounds.size.height)
            
            headerLabel.text = headerLabelTitles[i].uppercaseString
            headerLabel.textColor = UIColor.blackColor()
            headerLabel.font = UIFont(name: "ArialRoundedMTBold", size: 12.0)
            headerLabel.textAlignment = NSTextAlignment.Center
            
            headerContainView.tag = i
            headerContainView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("headerTapped:")))
            
            headerContainView.addSubview(headerLabel)
            indexBar.addSubview(headerContainView)
        }
        
        return indexBar
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(self.selectedPlayer.playerStatLines.count)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}