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
    
    var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        UINavigationBar.appearance().barStyle = UIBarStyle.Default
        setUpElements()
    }
    
    func setUpElements() {
        navigationItem.title = currentGame.datePlayed.toString()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "dismissModal")
        
        self.button = UIButton()
        self.button.setTitle("Activate", forState: UIControlState.Normal)
        self.button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.button.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.button.backgroundColor = UIColor.greenColor()
        self.button.sizeToFit()
        self.button.center = CGPoint(x: 50, y: 100)
        self.button.addTarget(self, action: "buttonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(self.button)
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
