//
//  Factory.swift
//  jumpshot-2
//
//  Created by Jonathan Yu on 2/12/15.
//  Copyright (c) 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit

class Factory {
    
    class func createRandoPlayer(name: String) -> Player {
        let newPlayer = Player()
        
        newPlayer.name = name
        newPlayer.age = Int(arc4random_uniform(UInt32(56)))
        newPlayer.height = "\(Int(arc4random_uniform(UInt32(2)))+5)'\(Int(arc4random_uniform(UInt32(2)))+9)"
        
        
        var numberOfGamesPlayed = Int(arc4random_uniform(UInt32(7)))
        
        for var statNumber = 0; statNumber < numberOfGamesPlayed; ++statNumber {
            let line = Statline()
            
            line.points = Int(arc4random_uniform(UInt32(56)))
            line.rebounds = Int(arc4random_uniform(UInt32(20)))
            line.assists = Int(arc4random_uniform(UInt32(20)))
            line.steals = Int(arc4random_uniform(UInt32(10)))
            line.blocks = Int(arc4random_uniform(UInt32(10)))
            
            newPlayer.playerStatLines.addObject(line)
        }
        
        return newPlayer
    }
    
}