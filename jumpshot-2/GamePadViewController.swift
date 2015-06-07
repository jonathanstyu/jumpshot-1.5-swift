//
//  GamePadViewController.swift
//  jumpshot-2
//
//  Created by Jonathan Yu on 2/28/15.
//  Copyright (c) 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit
import Realm

class GamePadViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var currentGame: Game!
    
    var scoreBarView: UIView!
    var team1View: UIView!
    var team2View: UIView!

    var gameTitleLabel: UILabel!
    var team1Label: UILabel!
    var team2Label: UILabel!
    var team1ScoreLabel: UILabel!
    var team2ScoreLabel: UILabel!

    var restartButton: UIButton!
    var stopButton: UIButton!
    var pauseButton: UIButton!
    
    var feedTable: UITableView!

    let kMargin: CGFloat = (1.0/12.0)
    
    var statlineToModify: Statline!
    
    var playerButtonArray: [PlayerSelectSquare]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        UINavigationBar.appearance().barStyle = UIBarStyle.Default
        
        self.playerButtonArray = []
        
        setUpElements()
        createButtons()
        updateViewElements()
        
    }
    
    func setUpElements() {
        var visibleHeight: CGFloat = self.view.bounds.height - self.navigationController!.navigationBar.frame.height
        var yOrigin: CGFloat = self.navigationController!.navigationBar.bounds.height + UIApplication.sharedApplication().statusBarFrame.size.height
        
        navigationItem.title = currentGame.datePlayed.toString()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "dismissModal")

//        Container view for the scores
        self.scoreBarView = UIView()
        self.scoreBarView.frame = CGRectMake(0, yOrigin, self.view.bounds.width, (visibleHeight / 8.0))
        self.scoreBarView.backgroundColor = UIColor(rgba: "#bdc3c7")
        self.view.addSubview(self.scoreBarView)

        self.team1ScoreLabel = UILabel()
        self.team1ScoreLabel.frame = CGRectMake(0, 0, (self.scoreBarView.frame.width / 2.0), self.scoreBarView.frame.height * 0.65)
        self.team1ScoreLabel.font = UIFont(name: "Futura-CondensedMedium", size: 40.0)
        self.team1ScoreLabel.textAlignment = NSTextAlignment.Center
        self.team1ScoreLabel.text = "0"
        self.scoreBarView.addSubview(self.team1ScoreLabel)
        
        self.team1Label = UILabel()
        self.team1Label.frame = CGRectMake(0, self.team1ScoreLabel.frame.size.height, self.team1ScoreLabel.frame.size.width, self.scoreBarView.frame.height * 0.35)
        self.team1Label.font = UIFont(name: "Futura-CondensedMedium", size: 20.0)
        self.team1Label.textAlignment = NSTextAlignment.Center
        self.team1Label.text = "Team 1"
        self.scoreBarView.addSubview(self.team1Label)
        
        self.team2ScoreLabel = UILabel()
        self.team2ScoreLabel.frame = CGRectMake(self.scoreBarView.frame.size.width / 2.0, 0, self.team1ScoreLabel.frame.size.width, self.team1ScoreLabel.frame.size.height)
        self.team2ScoreLabel.font = UIFont(name: "Futura-CondensedMedium", size: 40.0)
        self.team2ScoreLabel.textAlignment = NSTextAlignment.Center
        self.team2ScoreLabel.text = "0"
        self.scoreBarView.addSubview(self.team2ScoreLabel)
        
        self.team2Label = UILabel()
        self.team2Label.frame = CGRectMake(self.scoreBarView.frame.size.width / 2.0, self.team2ScoreLabel.frame.size.height, self.team2ScoreLabel.frame.size.width, self.team1Label.frame.size.height)
        self.team2Label.font = UIFont(name: "Futura-CondensedMedium", size: 20.0)
        self.team2Label.textAlignment = NSTextAlignment.Center
        self.team2Label.text = "Team 2"
        self.scoreBarView.addSubview(self.team2Label)
        
//        Container views for the first and second teams
        self.team1View = UIView()
        self.team1View.frame = CGRectMake(0, yOrigin + self.scoreBarView.frame.size.height, self.view.frame.width / 2.0, visibleHeight / 2)
        self.team1View.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.team1View)
        
        self.team2View = UIView()
        self.team2View.frame = CGRectMake(self.view.frame.width / 2.0, yOrigin + self.scoreBarView.frame.height, self.view.frame.width / 2.0, self.team1View.frame.size.height)
        self.team2View.backgroundColor = UIColor.yellowColor()
        self.view.addSubview(self.team2View)
        
//        Set up the UITable for the Feed
        self.feedTable = UITableView()
        self.feedTable.frame = CGRectMake(0, yOrigin + self.scoreBarView.frame.size.height + self.team1View.frame.size.height, self.view.frame.width, visibleHeight/4.0)
        self.feedTable.dataSource = self
        self.feedTable.delegate = self
        self.feedTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.feedTable)
       
    }
    
    func createButtons() {
        
//      Add buttons to the players view
        var buttonMargin: CGFloat = 5.0
        
        for var j = 0; j < 2; ++j {
            var tagAdd: Int
            var roster: RLMArray
            var rosterView: UIView
            
            if j == 0 {
                roster = self.currentGame.team1_players
                tagAdd = 200
                rosterView = self.team1View
            } else {
                roster = self.currentGame.team2_players
                tagAdd = 300
                rosterView = self.team2View
            }
            
            for var i = 0; i < Int(roster.count); ++i {
                var playerButtonHeight = (rosterView.frame.size.height - buttonMargin * CGFloat(roster.count + 1)) / CGFloat(roster.count)
                var playerStatline = roster.objectAtIndex(UInt(i)) as! Statline
                var playerButton = PlayerSelectSquare(frame: CGRect(x: buttonMargin, y: buttonMargin + playerButtonHeight * CGFloat(i), width: (self.view.frame.width / 2.0) - buttonMargin * 2, height: playerButtonHeight), statline: playerStatline)
                
                playerButton.tag = i + tagAdd // tagAdd variable prevents confusion with other tags in the view
                playerButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("buttonPressed:")))
                playerButton.layer.borderColor = UIColor.redColor().CGColor
                
                if tagAdd == 200 {
                    playerButton.teamBadge.text = "Team 1"
                    playerButton.teamBadge.backgroundColor = UIColor(rgba: "#8e44ad")
                    playerButton.teamBadge.textColor = UIColor.whiteColor()
                } else {
                    playerButton.teamBadge.text = "Team 2"
                    playerButton.teamBadge.backgroundColor = UIColor(rgba: "#e74c3c")
                    playerButton.teamBadge.textColor = UIColor.whiteColor()
                }
                
                playerButton.updateDataLabels()
                self.playerButtonArray.append(playerButton)
                rosterView.addSubview(playerButton)
            }
        }
    }
    
//    Refreshing the entire view after something happens to the viewcontroller
    func updateViewElements() {
        self.team1ScoreLabel.text = "\(self.currentGame.tallyTeamScore(1))"
        self.team2ScoreLabel.text = "\(self.currentGame.tallyTeamScore(2))"
        
        self.feedTable.reloadData()
        for button in self.playerButtonArray {
            button.updateDataLabels()
        }
    }
    
    func dismissModal() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func buttonPressed(gesture: UITapGestureRecognizer) {
        var sender: UIView = gesture.view!
        
        var frostedSideBar: FrostedSidebar = FrostedSidebar(itemImages: [
            UIImage(named: "FG")!,
            UIImage(named: "3FG")!,
            UIImage(named: "REB")!,
            UIImage(named: "AST")!,
            UIImage(named: "STL")!,
            UIImage(named: "BLK")!
            ], colors: nil, selectedItemIndices: NSIndexSet(index: 0))
        
//        Right or Left team?
        if Int(sender.tag % 200) >= 100 {
//            Team 1
            self.statlineToModify = self.currentGame.team2_players.objectAtIndex(UInt(sender.tag - 300)) as! Statline
            frostedSideBar.showFromRight = false
        } else {
//            Team 2
            self.statlineToModify = self.currentGame.team1_players.objectAtIndex(UInt(sender.tag - 200)) as! Statline
            frostedSideBar.showFromRight = true
        }
        
        frostedSideBar.actionForIndex = [
            0: {
                var fgMakeMissBar = FrostedSidebar(itemImages: [
                    UIImage(named: "make")!,
                    UIImage(named: "miss")!
                    ], colors: nil, selectedItemIndices: NSIndexSet(index: 0))
                
                if frostedSideBar.showFromRight {
                    fgMakeMissBar.showFromRight = false
                } else {
                    fgMakeMissBar.showFromRight = true
                }
                
                fgMakeMissBar.actionForIndex = [
                    0: {self.statlineToModify.statChange("fgMade")
                        fgMakeMissBar.dismissAnimated(true, completion: nil)
                        self.updateViewElements()
                    },
                    1: {self.statlineToModify.statChange("fgMiss")
                        fgMakeMissBar.dismissAnimated(true, completion: nil)
                        self.updateViewElements()
                    }
                ]
                
                fgMakeMissBar.showInViewController(self, animated: true)
            },
            1: {
                var fgMakeMissBar = FrostedSidebar(itemImages: [
                    UIImage(named: "make")!,
                    UIImage(named: "miss")!
                    ], colors: nil, selectedItemIndices: NSIndexSet(index: 0))
                
                if frostedSideBar.showFromRight {
                    fgMakeMissBar.showFromRight = false
                } else {
                    fgMakeMissBar.showFromRight = true
                }
                
                fgMakeMissBar.actionForIndex = [
                    0: {self.statlineToModify.statChange("3fgMade")
                        fgMakeMissBar.dismissAnimated(true, completion: nil)
                        self.updateViewElements()
                    },
                    1: {self.statlineToModify.statChange("3fgMiss")
                        fgMakeMissBar.dismissAnimated(true, completion: nil)
                        self.updateViewElements()
                    }
                ]
                
                fgMakeMissBar.showInViewController(self, animated: true)
            },
            2: {
                self.statlineToModify.statChange("rebound")
                frostedSideBar.dismissAnimated(true, completion: nil)
                self.updateViewElements()
                
            },
            3: {
                self.statlineToModify.statChange("assist")
                frostedSideBar.dismissAnimated(true, completion: nil)
                self.updateViewElements()
            },
            4: {
                self.statlineToModify.statChange("steal")
                frostedSideBar.dismissAnimated(true, completion: nil)
                self.updateViewElements()
            },
            5: {
                self.statlineToModify.statChange("block")
                frostedSideBar.dismissAnimated(true, completion: nil)
                self.updateViewElements()
            }
        ]
        
        frostedSideBar.showInViewController(self, animated: true)
    }
    
    
//    Timing buttons. Implement?
    func stopButtonPressed(sender: UIButton) {
        println("stop button clicked!")
    }
    
    func pauseButtonPressed(sender: UIButton) {
        println("pause button clicked!")
    }

    func restartButtonPressed(sender: UIButton) {
        println("restart button clicked!")
    }
    
//    Necessary for TableView
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(currentGame.eventFeed.count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = feedTable.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell
        var currentEventFeed: FeedEvent = currentGame.eventFeed.objectAtIndex(UInt(indexPath.row)) as! FeedEvent
        
        if (cell != nil) {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "Cell")
        }
        
        cell!.textLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 13.0)
        cell!.textLabel?.text = currentEventFeed.text
        
        cell!.detailTextLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 11.0)
        cell!.detailTextLabel?.text = currentEventFeed.time.toString(format: .Custom("HH:mm:ss"))
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var indexBar = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 35))
        indexBar.backgroundColor = UIColor(rgba: "#f0f0d0")
        
        var headerLabel = UILabel()
        headerLabel.frame = CGRect(x: 0, y: 0, width: (indexBar.bounds.size.width), height: indexBar.frame.size.height)
        headerLabel.text = "Game Feed"
        headerLabel.textColor = UIColor.blackColor()
        headerLabel.font = UIFont(name: "ArialRoundedMTBold", size: 16.0)
        headerLabel.textAlignment = NSTextAlignment.Center
        indexBar.addSubview(headerLabel)
     
        return indexBar
    }
}
