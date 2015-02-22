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

class PlayerProfileVC: UIViewController {
    var nameLabel: UILabel!
    
    var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        setupViews()
    }
    
    func setupViews() {
        nameLabel = UILabel()
        nameLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 59)
        nameLabel.text = "Hello World"
        
        backButton = UIButton()
//        backButton.center = CGPoint(x: view.bounds.width * 0.5, y: view.bounds.height * 0.5)
        backButton.frame = CGRect(x: 0, y: 100, width: 100, height: 25)
        backButton.setTitle("Dismiss", forState: UIControlState.Normal)
        backButton.backgroundColor = UIColor.blueColor()
        backButton.addTarget(self, action: "dismissModal", forControlEvents: UIControlEvents.TouchUpInside)
        
        view.addSubview(backButton)
        view.addSubview(nameLabel)
    }
    
    func dismissModal() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}