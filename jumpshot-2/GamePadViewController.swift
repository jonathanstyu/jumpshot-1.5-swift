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

class GamePadViewController: UIViewController {
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

    let kMargin: CGFloat = (1.0/12.0)
    
    var statlineToModify: Statline!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        UINavigationBar.appearance().barStyle = UIBarStyle.Default
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
        self.scoreBarView.frame = CGRectMake(0, yOrigin, self.view.bounds.width / 2.0, (visibleHeight / 6.0))
        self.scoreBarView.backgroundColor = UIColor.greenColor()
        self.view.addSubview(self.scoreBarView)

        self.team1ScoreLabel = UILabel()
        self.team1ScoreLabel.frame = CGRectMake(0, 0, (self.scoreBarView.frame.width / 2.0), self.scoreBarView.frame.height * 0.65)
        self.team1ScoreLabel.font = UIFont(name: "Futura-CondensedMedium", size: 34.0)
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
        self.team2ScoreLabel.font = UIFont(name: "Futura-CondensedMedium", size: 34.0)
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
        self.team1View.frame = CGRectMake(0, yOrigin + self.scoreBarView.frame.size.height, self.view.frame.width / 2.0, visibleHeight / 2.5)
        self.team1View.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.team1View)
        
        self.team2View = UIView()
        self.team2View.frame = CGRectMake(self.view.frame.width / 2.0, yOrigin + self.scoreBarView.frame.height, self.view.frame.width / 2.0, self.team1View.frame.size.height)
        self.team2View.backgroundColor = UIColor.yellowColor()
        self.view.addSubview(self.team2View)
       
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
                var playerButton = UIView()
                var playerStatline = roster.objectAtIndex(UInt(i)) as! Statline
                var nameLabel = UILabel()
                
                var playerButtonHeight = (rosterView.frame.size.height - buttonMargin * CGFloat(roster.count + 1)) / CGFloat(roster.count)
                
                playerButton.frame = CGRect(x: buttonMargin, y: buttonMargin + playerButtonHeight * CGFloat(i), width: (self.view.frame.width / 2.0) - buttonMargin * 2, height: playerButtonHeight)
                playerButton.tag = i + tagAdd
                playerButton.backgroundColor = UIColor.whiteColor()
                playerButton.userInteractionEnabled = true
                playerButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("buttonPressed:")))
                playerButton.layer.borderWidth = 1
                playerButton.layer.borderColor = UIColor.redColor().CGColor
                
                nameLabel.frame = CGRect(x: 0, y: 0, width: playerButton.bounds.size.width, height: playerButton.bounds.size.height * 0.4)
                nameLabel.text = playerStatline.owner?.name
                
                playerButton.addSubview(nameLabel)
                rosterView.addSubview(playerButton)
            }
        }
    }
    
    func updateViewElements() {
        self.team1ScoreLabel.text = "\(self.currentGame.tallyTeamScore(1))"
        self.team2ScoreLabel.text = "\(self.currentGame.tallyTeamScore(2))"
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
                println(self.statlineToModify)
                self.statlineToModify.statChange("3fgMiss")
                self.updateViewElements()
                
            },
            3: {
                self.statlineToModify.statChange("assist")
                self.updateViewElements()
            },
            4: {
                self.statlineToModify.statChange("steal")
                self.updateViewElements()
            },
            5: {
                self.statlineToModify.statChange("block")
                self.updateViewElements()
            }
        ]
        
        frostedSideBar.showInViewController(self, animated: true)
    }
    
//    2nd Level Make-Miss Bar
//    func generateMakeMissBar(showRight: Bool, twoShot: Bool) -> FrostedSidebar {
//        
//    }
    
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
}
