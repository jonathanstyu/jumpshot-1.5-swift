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
    
    var scoreView: UIView!
    var team1View: UIView!
    var team2View: UIView!

    var gameTitleLabel: UILabel!
    var team1Label: UILabel!
    var team2Label: UILabel!
    
    var restartButton: UIButton!
    var stopButton: UIButton!
    var pauseButton: UIButton!

    let kMargin: CGFloat = (1.0/12.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        UINavigationBar.appearance().barStyle = UIBarStyle.Default
        setUpElements()
        updateViewElements()
    }
    
    override func viewDidLayoutSubviews() {
        for var i = 0; i < Int(self.currentGame.team1_players.count); ++i {
            var playerButtonLeft = UIButton()
            var statline = self.currentGame.team1_players.objectAtIndex(UInt(i)) as! Statline

            playerButtonLeft.tag = i + 200
            playerButtonLeft.setTitle(statline.owner?.name, forState: UIControlState.Normal)
            playerButtonLeft.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            playerButtonLeft.backgroundColor = UIColor.blackColor()
            playerButtonLeft.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchUpInside)

            playerButtonLeft.frame = CGRectMake(0, ((self.team1View.frame.height * 0.8) / CGFloat(self.currentGame.team1_players.count)) * CGFloat(i), self.team1View.frame.size.width, 100)

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
            
            playerButtonRight.frame = CGRectMake(0, ((self.team2View.frame.height * 0.8) / CGFloat(self.currentGame.team2_players.count)) * CGFloat(i), self.team2View.frame.size.width, 100)
            
            self.team2View.addSubview(playerButtonRight)
        }

    }
    
    func setUpElements() {
        var visibleHeight: CGFloat = self.view.bounds.height - self.navigationController!.navigationBar.frame.height
        
        navigationItem.title = currentGame.datePlayed.toString()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "dismissModal")

        self.scoreView = self.view.viewWithTag(1)! as UIView
        self.team1Label = self.view.viewWithTag(2) as! UILabel
        self.team2Label = self.view.viewWithTag(3) as! UILabel
        
//        To prevent finding nil optionals, click on the "installed" 
        self.team1View = self.view.viewWithTag(4) as UIView!
        self.team2View = self.view.viewWithTag(5) as UIView!
        self.restartButton = self.view.viewWithTag(8) as! UIButton
        self.pauseButton = self.view.viewWithTag(9) as! UIButton
        self.stopButton = self.view.viewWithTag(10) as! UIButton
        
//        set up buttons 
        self.restartButton.addTarget(self, action: "restartButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.stopButton.addTarget(self, action: "stopButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.pauseButton.addTarget(self, action: "pauseButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func updateViewElements() {
        self.team1Label.text = "\(self.currentGame.tallyTeamScore(1))"
        self.team2Label.text = "\(self.currentGame.tallyTeamScore(2))"
    }
    
    func dismissModal() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func buttonPressed(sender: UIButton) {
        var frostedSideBar: FrostedSidebar = FrostedSidebar(itemImages: [UIImage(named: "MAKE.png")!], colors: nil, selectedItemIndices: NSIndexSet(index: 0))
        
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
