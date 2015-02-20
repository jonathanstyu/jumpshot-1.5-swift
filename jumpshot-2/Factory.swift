//
//  Factory.swift
//  jumpshot-2
//
//  Created by Jonathan Yu on 2/12/15.
//  Copyright (c) 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit
import Realm

class Factory {
    
    class func createTestData() {
        
        let realm = RLMRealm.defaultRealm()
        let players = Player.allObjects()
        let games = Game.allObjects()
        
        let playerNames = ["jenny", "audrey", "libby", "daniel", "sydney"]
        
        if players.count == 0 {
            realm.beginWriteTransaction()
            for playerName in playerNames {
                let newPlayer = Factory.createRandoPlayer(playerName)
                realm.addObject(newPlayer)
            }
            realm.commitWriteTransaction()
        }
    }
    
    class func createGame(team1: [Player], team2: [Player]) -> Game {
        let newGame = Game()
        newGame.datePlayed = NSDate(fromString: "Fri, 09 Sep 2011 15:26:08 +0200", format: .RSS)

        return newGame
    }
    
    class func createRandoPlayer(name: String) -> Player {
        let newPlayer = Player()
        
        newPlayer.name = name
        newPlayer.age = Int(arc4random_uniform(UInt32(56)))
        newPlayer.height = "\(Int(arc4random_uniform(UInt32(2)))+5)'\(Int(arc4random_uniform(UInt32(2)))+9)"
        
        
//        var numberOfGamesPlayed = Int(arc4random_uniform(UInt32(7))) + 1
//        
//        for var statNumber = 0; statNumber < numberOfGamesPlayed; ++statNumber {
//            let line = Statline()
//            
//            line.points = Int(arc4random_uniform(UInt32(56)))
//            line.rebounds = Int(arc4random_uniform(UInt32(20)))
//            line.assists = Int(arc4random_uniform(UInt32(20)))
//            line.steals = Int(arc4random_uniform(UInt32(10)))
//            line.blocks = Int(arc4random_uniform(UInt32(10)))
//            line.turnovers = Int(arc4random_uniform(UInt32(10)))
//            
//            newPlayer.playerStatLines.addObject(line)
//            line.owner = newPlayer
//        }
        
        return newPlayer
    }
    
    
}