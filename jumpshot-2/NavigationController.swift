//
//  NavigationController.swift
//  jumpshot-2
//
//  Created by Jonathan Yu on 5/31/15.
//  Copyright (c) 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit

class NavigationController: UINavigationController, UIViewControllerTransitioningDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var nav = self.navigationBar
        
        nav.barTintColor = UIColor(rgba: "#2A2D34")
        nav.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor(rgba: "#A0DDE6")
        ]
        nav.tintColor = UIColor(rgba: "#30C5FF")
    }
}