//
//  AppDelegate.swift
//  jumpshot-2
//
//  Created by Jonathan Yu on 2/8/15.
//  Copyright (c) 2015 Jonathan Yu. All rights reserved.
//

import UIKit
import Realm

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var defaults = NSUserDefaults.standardUserDefaults()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        var nav2 = UINavigationController()
        var gamesScreen = GamesViewController()
        nav2.viewControllers = [gamesScreen]
        nav2.tabBarItem = UITabBarItem(title: "Games", image: UIImage(named: "Ball-Tab-Icon"), tag: 2)

        var nav3 = UINavigationController()
        var newGameScreen = NewGameViewController()
        nav3.viewControllers = [newGameScreen]
        nav3.tabBarItem = UITabBarItem(title: "New Game", image: UIImage(named: "New-Game-Tab"), tag: 2)

        var statsNav = UINavigationController()
        var statScreen = PlayerRankViewController()
        statsNav.viewControllers = [statScreen]
        statsNav.tabBarItem = UITabBarItem(title: "Stats", image: UIImage(named: "Stats-tab-icon"), tag: 2)
        
        var settingNav = UINavigationController()
        var settingScreen = SettingsViewController()
        settingNav.viewControllers = [settingScreen]
        settingNav.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.More, tag: 2)
        
        var tabs = UITabBarController()
        tabs.viewControllers = [nav3, nav2, statsNav, settingNav]
        tabs.tabBar.barTintColor = UIColor.whiteColor()
        
        UINavigationBar.appearance().barStyle = UIBarStyle.Black
        
        self.window!.rootViewController = tabs
        self.window?.makeKeyAndVisible()
        
//        Factory.createTestData()
        createDefaultSettings()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func createDefaultSettings() {
        self.defaults.setInteger(0, forKey: "colortheme")
    }


}

