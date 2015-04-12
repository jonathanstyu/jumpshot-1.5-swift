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
        
        let playerNames = ["jenny", "audrey", "libby", "daniel", "sydney", "Luis"]
        
        if players.count == 0 {
            realm.beginWriteTransaction()
            for playerName in playerNames {
                let newPlayer = Factory.createRandoPlayer(playerName)
                realm.addObject(newPlayer)
            }
            realm.commitWriteTransaction()
        }
        
        if games.count == 0 {
            for var i = 0; i < 3; ++i {
                let newGame = Factory.createGame(team1: [players.objectAtIndex(0) as! Player, players.objectAtIndex(2) as! Player], team2: [players.objectAtIndex(1) as! Player, players.objectAtIndex(3) as! Player])
            }
        }
    }
    
//    For setting up test datas
    
    class func createGame(team1 t1: [Player], team2 t2: [Player]) -> Game {
        let newGame = Game()
        let realm = RLMRealm.defaultRealm()
        
        realm.beginWriteTransaction()
        
        for player in t1 {
            let newStatline = Factory.createRandoStatline()
            newStatline.owner = player
            newStatline.game = newGame
            player.playerStatLines.addObject(newStatline)
            newGame.team1_players.addObject(newStatline)
            
            realm.addObject(newStatline)
        }
        
        for player in t2 {
            let newStatline = Factory.createRandoStatline()
            newStatline.owner = player
            newStatline.game = newGame
            player.playerStatLines.addObject(newStatline)
            newGame.team2_players.addObject(newStatline)
            
            realm.addObject(newStatline)
        }
        realm.addObject(newGame)
        realm.commitWriteTransaction()
        
        return newGame
    }
    
    class func createNewPlayer(name: String) -> Void {
        let newPlayer = Player()
        let realm = RLMRealm.defaultRealm()
        
        newPlayer.name = name
        newPlayer.age = Int(arc4random_uniform(UInt32(56)))
        newPlayer.height = "\(Int(arc4random_uniform(UInt32(2)))+5)'\(Int(arc4random_uniform(UInt32(2)))+9)"
        
        realm.beginWriteTransaction()
        realm.addObject(newPlayer)
        realm.commitWriteTransaction()
    }
    
//    For creating Randos
    
    class func createRandoStatline() -> Statline {
        let line = Statline()

        line.points = Int(arc4random_uniform(UInt32(30)))
        line.rebounds = Int(arc4random_uniform(UInt32(15)))
        line.assists = Int(arc4random_uniform(UInt32(15)))
        line.steals = Int(arc4random_uniform(UInt32(10)))
        line.blocks = Int(arc4random_uniform(UInt32(10)))
        line.turnovers = Int(arc4random_uniform(UInt32(10)))
        
        return line
    }
    
    class func createRandoPlayer(name: String) -> Player {
        let newPlayer = Player()
        
        newPlayer.name = name
        newPlayer.age = Int(arc4random_uniform(UInt32(56)))
        newPlayer.height = "\(Int(arc4random_uniform(UInt32(2)))+5)'\(Int(arc4random_uniform(UInt32(2)))+9)"
        
        return newPlayer
    }
    
    
}