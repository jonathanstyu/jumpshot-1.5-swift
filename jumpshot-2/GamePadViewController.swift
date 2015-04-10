//
//  GamePadViewController.swift
//  jumpshot-2
//
//  Created by Jonathan Yu on 2/28/15.
//  Copyright (c) 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit

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
        self.scoreBarView.frame = CGRectMake(0, yOrigin, self.view.bounds.width / 2.0, (visibleHeight / 5.0))
        self.scoreBarView.backgroundColor = UIColor.greenColor()
        self.view.addSubview(self.scoreBarView)

        self.team1ScoreLabel = UILabel()
        self.team1ScoreLabel.frame = CGRectMake(0, 0, (self.scoreBarView.frame.width / 2.0), self.scoreBarView.frame.height * 0.75)
        self.team1ScoreLabel.font = UIFont(name: "Futura-CondensedMedium", size: 34.0)
        self.team1ScoreLabel.textAlignment = NSTextAlignment.Center
        self.team1ScoreLabel.text = "0"
        self.scoreBarView.addSubview(self.team1ScoreLabel)
        
        self.team1Label = UILabel()
        self.team1Label.frame = CGRectMake(0, self.team1ScoreLabel.frame.size.height, self.team1ScoreLabel.frame.size.width, self.scoreBarView.frame.height * 0.25)
        self.team1Label.font = UIFont(name: "Futura-CondensedMedium", size: 20.0)
        self.team1Label.textAlignment = NSTextAlignment.Center
        self.team1Label.text = "Team 1"
        self.scoreBarView.addSubview(self.team1Label)
        
        self.team2ScoreLabel = UILabel()
        self.team2ScoreLabel.frame = CGRectMake(self.scoreBarView.frame.size.width / 2.0, 0, (self.scoreBarView.frame.width / 2.0), self.scoreBarView.frame.height * 0.75)
        self.team2ScoreLabel.font = UIFont(name: "Futura-CondensedMedium", size: 34.0)
        self.team2ScoreLabel.textAlignment = NSTextAlignment.Center
        self.team2ScoreLabel.text = "0"
        self.scoreBarView.addSubview(self.team2ScoreLabel)
        
        self.team2Label = UILabel()
        self.team2Label.frame = CGRectMake(self.scoreBarView.frame.size.width / 2.0, self.team2ScoreLabel.frame.size.height, self.team2ScoreLabel.frame.size.width, self.scoreBarView.frame.height * 0.25)
        self.team2Label.font = UIFont(name: "Futura-CondensedMedium", size: 20.0)
        self.team2Label.textAlignment = NSTextAlignment.Center
        self.team2Label.text = "Team 2"
        self.scoreBarView.addSubview(self.team2Label)
        
//        Container views for the first and second teams
        self.team1View = UIView()
        self.team1View.frame = CGRectMake(0, yOrigin + self.scoreBarView.frame.size.height, self.view.frame.width / 2.0, visibleHeight / 3.0)
        self.team1View.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.team1View)
        
        self.team2View = UIView()
        self.team2View.frame = CGRectMake(self.view.frame.width / 2.0, yOrigin + self.scoreBarView.frame.height, self.view.frame.width / 2.0, visibleHeight / 3.0)
        self.team2View.backgroundColor = UIColor.yellowColor()
        self.view.addSubview(self.team2View)
       
//        self.pauseButton = self.view.viewWithTag(9) as! UIButton
//        self.stopButton = self.view.viewWithTag(10) as! UIButton
//        
////        set up buttons 
//        self.restartButton.sizeToFit()
//        self.restartButton.addTarget(self, action: "restartButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
//        self.restartButton.center = CGPoint(x: <#CGFloat#>, y: <#CGFloat#>)
//        self.scoreView.addSubview(self.restartButton)
//        
//        self.stopButton.addTarget(self, action: "stopButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
//        self.pauseButton.addTarget(self, action: "pauseButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func createButtons() {
        
//      Add buttons to the players view
        var buttonMargin: CGFloat = 5.0
        
        for var i = 0; i < Int(self.currentGame.team1_players.count); ++i {
            var playerButtonLeft = UIButton()
            var statline = self.currentGame.team1_players.objectAtIndex(UInt(i)) as! Statline
            
            playerButtonLeft.tag = i + 200
            playerButtonLeft.setTitle(statline.owner?.name, forState: UIControlState.Normal)
            playerButtonLeft.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            playerButtonLeft.backgroundColor = UIColor.blackColor()
            playerButtonLeft.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            playerButtonLeft.layer.borderWidth = 1
            playerButtonLeft.layer.borderColor = UIColor.redColor().CGColor
            
            var playerCount = self.currentGame.team1_players.count
            var playerButtonLeftHeight = (self.team1View.frame.size.height - buttonMargin * CGFloat(playerCount + 1)) / CGFloat(playerCount)
            
            playerButtonLeft.frame = CGRect(x: buttonMargin, y: buttonMargin + playerButtonLeftHeight * CGFloat(i), width: (self.view.frame.width / 2.0) - buttonMargin * 2, height: playerButtonLeftHeight)
            
            self.team1View.addSubview(playerButtonLeft)
        }
        
        for var i = 0; i < Int(self.currentGame.team2_players.count); ++i {
            
            var playerButtonRight = UIButton()
            var statline = self.currentGame.team2_players.objectAtIndex(UInt(i)) as! Statline
            
            playerButtonRight.tag = i + 300
            playerButtonRight.setTitle(statline.owner?.name, forState: UIControlState.Normal)
            playerButtonRight.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            playerButtonRight.backgroundColor = UIColor.redColor()
            playerButtonRight.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            playerButtonRight.layer.borderWidth = 1
            playerButtonRight.layer.borderColor = UIColor.redColor().CGColor
            
            var playerCount = self.currentGame.team2_players.count
            var playerButtonRightHeight = (self.team2View.frame.size.height - buttonMargin * CGFloat(playerCount + 1)) / CGFloat(playerCount)
            
            playerButtonRight.frame = CGRect(x: buttonMargin, y: buttonMargin + playerButtonRightHeight * CGFloat(i), width: (self.view.frame.width / 2.0) - buttonMargin * 2, height: playerButtonRightHeight)
            
            self.team2View.addSubview(playerButtonRight)
        }
        
    }
    
    func updateViewElements() {
        self.team1ScoreLabel.text = "\(self.currentGame.tallyTeamScore(1))"
        self.team2ScoreLabel.text = "\(self.currentGame.tallyTeamScore(2))"
    }
    
    func dismissModal() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func buttonPressed(sender: UIButton) {
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
            self.statlineToModify = self.currentGame.team1_players.objectAtIndex(UInt(sender.tag - 300)) as! Statline
            frostedSideBar.showFromRight = false
        } else {
//            Team 2
            self.statlineToModify = self.currentGame.team2_players.objectAtIndex(UInt(sender.tag - 200)) as! Statline
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
