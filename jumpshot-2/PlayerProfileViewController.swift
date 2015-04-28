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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.whiteColor()
        UINavigationBar.appearance().barStyle = UIBarStyle.Default
        navigationItem.title = "Player Profile For \(selectedPlayer.name.capitalizedString)"
        setupViews()
        setupTableView()
    }
    
    func setupViews() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "dismissModal")
        
        self.containerView = UIView()
        self.containerView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: (self.view.bounds.size.height * 0.33))
        self.containerView.backgroundColor = UIColor(rgba: "#31320f")
        
        nameLabel = UILabel()
        nameLabel.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 55)
        nameLabel.font = UIFont(name: "ArialRoundedMTBold", size: 24.0)
        nameLabel.backgroundColor = UIColor(rgba: "#f9f7cc")
        nameLabel.textColor = UIColor.blackColor()
        nameLabel.text = selectedPlayer.name.capitalizedString

//        Removing the dimiss button for now. Not necessary
//        let dismissButton = UIButton()
//        dismissButton.frame = CGRect(x: self.view.bounds.size.width * 0.6, y: nameLabel.bounds.size.height + 5, width: self.view.bounds.size.width * 0.38, height: 35)
//        dismissButton.backgroundColor = UIColor(rgba: "#e74c3c")
//        dismissButton.layer.cornerRadius = 5
//        dismissButton.setTitle("Dismiss", forState: UIControlState.Normal)
//        dismissButton.addTarget(self, action: "dismissModal", forControlEvents: UIControlEvents.TouchUpInside)
        
//        Index bar + the composition texts
        var indexBar = UIView(frame: CGRect(x: 0, y: self.containerView.frame.size.height - 40, width: self.view.frame.width, height: 40))
        indexBar.backgroundColor = UIColor(rgba: "#f0f0d0")
        
        var headerLabelTitles = ["POINTS", "REBOUNDS", "ASSISTS", "STEALS", "BLOCKS"]
        for var i = 0; i < 5; ++i {
            var headerLabel = UILabel()
            headerLabel.frame = CGRect(x: (indexBar.bounds.size.width / 5.0) * CGFloat(i), y: 0, width: (indexBar.bounds.size.width / 5.0), height: indexBar.frame.size.height)
            headerLabel.text = headerLabelTitles[i]
            headerLabel.textColor = UIColor.blackColor()
            headerLabel.font = UIFont(name: "Futura-CondensedMedium", size: 15.0)
            headerLabel.textAlignment = NSTextAlignment.Center
            indexBar.addSubview(headerLabel)
        }
        
        self.containerView.addSubview(indexBar)
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
    
    func dismissModal() {
        self.dismissViewControllerAnimated(true, completion: nil)
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