//
//  Game.swift
//  jumpshot-2
//
//  Created by Jonathan Yu on 2/9/15.
//  Copyright (c) 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import Realm

class Game: RLMObject {
    dynamic var datePlayed = NSDate()
    dynamic var id = Int(arc4random_uniform(UInt32(999999)))
    
    dynamic var team1_players = RLMArray(objectClassName: "Statline")
    dynamic var team2_players = RLMArray(objectClassName: "Statline")
    
//    func tallySums(teamNumber tn: Int, requestedStat rs: String) -> Int {
//        
//    }
    
}