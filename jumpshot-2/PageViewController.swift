//
//  PageViewController.swift
//  jumpshot-2
//
//  Created by Jonathan Yu on 3/21/15.
//  Copyright (c) 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit

class SwipePageViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var myViewControllers = Array(count: 3, repeatedValue: UIViewController())
    var pageViewController: UIPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        
        var nav1 = UINavigationController()
        var playersScreen = PlayersViewController()
        nav1.viewControllers = [playersScreen]
        
        var nav2 = UINavigationController()
        var gamesScreen = GamesViewController()
        nav2.viewControllers = [gamesScreen]
        
        var nav3 = UINavigationController()
        var newGameScreen = NewGameViewController()
        nav3.viewControllers = [newGameScreen]
        
        self.myViewControllers = [nav1, nav3, nav2]
        self.pageViewController!.setViewControllers([myViewControllers[1]], direction: .Forward, animated: false, completion: nil)
        
        self.pageViewController!.dataSource = self
        
        self.view.addSubview(self.pageViewController!.view)
        self.view.gestureRecognizers = self.pageViewController!.gestureRecognizers
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//        let pvc = segue.destinationViewController as! UIPageViewController
//        pvc.dataSource = self
//        pvc.setViewControllers([myViewControllers[1]], direction: .Forward, animated: true, completion: nil)
//    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var currentIndex =  find(self.myViewControllers, viewController)!+1
        if currentIndex >= self.myViewControllers.count {
            return nil
        }
        return self.myViewControllers[currentIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var currentIndex =  find(self.myViewControllers, viewController)!-1
        if currentIndex < 0 {
            return nil
        }
        return self.myViewControllers[currentIndex]
    }
    
}