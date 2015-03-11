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
    
    var playerView: UIView!
    var containerView: UIView!

    var gameTitleLabel: UILabel!
    var team1Label: UILabel!
    var team2Label: UILabel!

    let kMargin: CGFloat = (1.0/12.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        UINavigationBar.appearance().barStyle = UIBarStyle.Default
        setUpElements()
    }
    
    func setUpElements() {
        var visibleHeight: CGFloat = self.view.bounds.height - self.navigationController!.navigationBar.frame.height
        
        navigationItem.title = currentGame.datePlayed.toString()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "dismissModal")
        
        self.containerView = UIView()
        self.containerView.frame = CGRect(x: 0, y: self.navigationController!.navigationBar.frame.height, width: self.view.bounds.width, height: (visibleHeight * 0.4))
        self.containerView.backgroundColor = UIColor.darkGrayColor()
        
        self.gameTitleLabel = UILabel()
        self.gameTitleLabel.frame = CGRect(x: containerView.bounds.height * kMargin, y: containerView.bounds.height * (0.1), width: containerView.bounds.width - (containerView.bounds.height * 2 * kMargin), height: containerView.bounds.height * 0.15)
        self.gameTitleLabel.font = UIFont(name: "Futura-CondensedMedium", size: 25.0)
        self.gameTitleLabel.textAlignment = NSTextAlignment.Center
        self.gameTitleLabel.text = "Adding Players ..."
        
        self.team1Label = UILabel()
        self.team1Label.frame = CGRect(x: containerView.bounds.height * kMargin, y: containerView.bounds.height * (0.1) + gameTitleLabel.bounds.height, width: (containerView.bounds.width - (containerView.bounds.height * 2 * kMargin)) * 0.5, height: containerView.bounds.height * 0.2)
        self.team1Label.font = UIFont(name: "Futura-CondensedMedium", size: 16.0)
        self.team1Label.textAlignment = NSTextAlignment.Center
        self.team1Label.text = "Team 1"
        
        self.team2Label = UILabel()
        self.team2Label.frame = CGRect(x: (containerView.bounds.height * kMargin) + team1Label.frame.width, y: containerView.bounds.height * (0.1) + gameTitleLabel.bounds.height, width: (containerView.bounds.width - (containerView.bounds.height * 2 * kMargin)) * 0.5, height: containerView.bounds.height * 0.2)
        self.team2Label.font = UIFont(name: "Futura-CondensedMedium", size: 16.0)
        self.team2Label.textAlignment = NSTextAlignment.Center
        self.team2Label.text = "Team 2"
        
        let button = UIButton()
        button.setTitle("Activate", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        button.backgroundColor = UIColor.greenColor()
        button.sizeToFit()
        button.center = CGPoint(x: 50, y: 100)
        button.addTarget(self, action: "buttonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(button)
        
        view.addSubview(self.containerView)
        containerView.addSubview(gameTitleLabel)
        containerView.addSubview(team1Label)
        containerView.addSubview(team2Label)

    }
    
    func dismissModal() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func buttonPressed() {
        var frostedSideBar: FrostedSidebar = FrostedSidebar(itemImages: [], colors: nil, selectedItemIndices: NSIndexSet())
        frostedSideBar.showFromRight = true
        frostedSideBar.showInViewController(self, animated: true)
    }

}
