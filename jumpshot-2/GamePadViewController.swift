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

        self.scoreBarView = UIView()
        self.scoreBarView.frame = CGRectMake(0, yOrigin, self.view.bounds.width / 2.0, (visibleHeight / 4.0))
        self.scoreBarView.backgroundColor = UIColor.greenColor()
        self.view.addSubview(self.scoreBarView)

        self.team1ScoreLabel = UILabel()
        self.team1ScoreLabel.frame = CGRectMake(0, 0, (self.scoreBarView.frame.width / 2.0), self.scoreBarView.frame.height * 0.75)
        self.team1ScoreLabel.font = UIFont(name: "Futura-CondensedMedium", size: 30.0)
        self.team1ScoreLabel.textAlignment = NSTextAlignment.Center
        self.team1ScoreLabel.text = "0"
        self.scoreBarView.addSubview(self.team1ScoreLabel)
        
        self.team1Label = UILabel()
        self.team1Label.frame = CGRectMake(0, self.team1ScoreLabel.frame.size.height, self.team1ScoreLabel.frame.size.width, self.scoreBarView.frame.height * 0.25)
        self.team1Label.font = UIFont(name: "Futura-CondensedMedium", size: 15.0)
        self.team1Label.textAlignment = NSTextAlignment.Center
        self.team1Label.text = "Team 1"
        self.scoreBarView.addSubview(self.team1Label)
        
        self.team2ScoreLabel = UILabel()
        self.team2ScoreLabel.frame = CGRectMake(self.scoreBarView.frame.size.width / 2.0, 0, (self.scoreBarView.frame.width / 2.0), self.scoreBarView.frame.height * 0.75)
        self.team2ScoreLabel.font = UIFont(name: "Futura-CondensedMedium", size: 30.0)
        self.team2ScoreLabel.textAlignment = NSTextAlignment.Center
        self.team2ScoreLabel.text = "0"
        self.scoreBarView.addSubview(self.team2ScoreLabel)
        
        self.team2Label = UILabel()
        self.team2Label.frame = CGRectMake(self.scoreBarView.frame.size.width / 2.0, self.team2ScoreLabel.frame.size.height, self.team2ScoreLabel.frame.size.width, self.scoreBarView.frame.height * 0.25)
        self.team2Label.font = UIFont(name: "Futura-CondensedMedium", size: 15.0)
        self.team2Label.textAlignment = NSTextAlignment.Center
        self.team2Label.text = "Team 2"
        self.scoreBarView.addSubview(self.team2Label)
        
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
            
            var playerButtonLeftHeight = (self.team1View.frame.size.height / CGFloat(self.currentGame.team1_players.count))
            playerButtonLeft.frame = CGRect(x: buttonMargin, y: buttonMargin + playerButtonLeftHeight * CGFloat(i), width: (self.view.frame.width / 2.0) - buttonMargin * 2, height: 40)
            
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
            
            var playerButtonRightHeight = (self.team1View.frame.size.height / CGFloat(self.currentGame.team1_players.count))
            playerButtonRight.frame = CGRect(x: buttonMargin, y: buttonMargin + playerButtonRightHeight * CGFloat(i), width: (self.view.frame.width / 2.0) - buttonMargin * 2, height: 40)
            
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
        var frostedSideBar: FrostedSidebar = FrostedSidebar(itemImages: [UIImage(named: "slide-make")!, UIImage(named: "slide-miss")!, UIImage(named: "slide-3make")!, UIImage(named: "slide-3miss")!], colors: nil, selectedItemIndices: NSIndexSet(index: 0))
        
        println(sender.tag % 200)
        if Int(sender.tag % 200) >= 100 {
            frostedSideBar.showFromRight = false
        } else {
            frostedSideBar.showFromRight = true
        }
        
        frostedSideBar.showInViewController(self, animated: true)
    }
    
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
