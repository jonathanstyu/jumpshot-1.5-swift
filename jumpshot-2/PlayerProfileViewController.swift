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
    var selectedPlayer: Player!
    
    var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        UINavigationBar.appearance().barStyle = UIBarStyle.Default
        navigationItem.title = selectedPlayer.name.uppercaseString
        setupViews()
    }
    
    func setupViews() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "dismissModal")
        
        nameLabel = UILabel()
        nameLabel.frame = CGRect(x: 0, y: self.navigationController!.navigationBar.frame.height, width: 100, height: 59)
        nameLabel.text = selectedPlayer.name
        
        view.addSubview(nameLabel)
    }
    
    func dismissModal() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}