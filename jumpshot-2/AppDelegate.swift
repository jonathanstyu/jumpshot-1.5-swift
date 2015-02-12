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


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        var nav1 = UINavigationController()
        var playersScreen = PlayersViewController()
        nav1.viewControllers = [playersScreen]
        nav1.tabBarItem = UITabBarItem(title: "Players", image: nil, tag: 1)
        
        var nav2 = UINavigationController()
        var gamesScreen = GamesViewController()
        nav2.viewControllers = [gamesScreen]
        nav2.tabBarItem = UITabBarItem(title: "Games", image: nil, tag: 2)

        var nav3 = UINavigationController()
        var newGameScreen = NewGameViewController()
        nav3.viewControllers = [newGameScreen]
        nav3.tabBarItem = UITabBarItem(title: "New Game", image: nil, tag: 2)

        
        var tabs = UITabBarController()
        tabs.viewControllers = [nav1, nav3, nav2]
        tabs.tabBar.barTintColor = UIColor.whiteColor()
        
        self.window!.rootViewController = tabs
        self.window?.makeKeyAndVisible()
        
        createTestData()
        
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
    
    func createTestData() {
        
        let players = Player.allObjects()
        let realm = RLMRealm.defaultRealm()
        let playerNames = ["jenny", "audrey", "libby", "daniel"]
        
        if players.count == 0 {
            realm.beginWriteTransaction()
            for playerName in playerNames {
                let newPlayer = Factory.createRandoPlayer(playerName)
                realm.addObject(newPlayer)
            }
            realm.commitWriteTransaction()
        }
    }


}

