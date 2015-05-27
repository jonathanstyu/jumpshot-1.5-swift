//
//  StatsViewController.swift
//  jumpshot-2
//
//  Created by Jonathan Yu on 4/28/15.
//  Copyright (c) 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit
import Realm

class StatsViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var containerView: UIView!
    var pageViewController: UIPageViewController?
    var viewControllersArray: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Statistics"
        self.pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        
        var playerRankVC = PlayerRankViewController()
        var chartVC = ChartsViewController()
        
        self.viewControllersArray = [playerRankVC, chartVC]
        self.pageViewController!.setViewControllers([self.viewControllersArray[0]], direction: .Forward, animated: false, completion: nil)
        self.pageViewController!.dataSource = self
        
        self.containerView = UIView()
        self.containerView.frame = CGRectMake(0, self.view.bounds.size.height * (1/8), self.view.bounds.size.width, self.view.bounds.size.height * (7/8))
        
        self.view.addSubview(self.containerView)
        self.containerView.addSubview(self.pageViewController!.view)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
}