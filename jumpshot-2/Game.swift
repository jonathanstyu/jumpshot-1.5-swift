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
    
    func tallyTeamScore(team: Int) -> Int {
        var totalScore: Int = 0
        
        if team == 1 {
            for var i = 0; i < Int(self.team1_players.count); ++i {
                let stat = self.team1_players.objectAtIndex(UInt(i)) as! Statline
                totalScore += stat.points
            }
        } else {
            for var i = 0; i < Int(self.team2_players.count); ++i {
                let stat = self.team2_players.objectAtIndex(UInt(i)) as! Statline
                totalScore += stat.points
            }
        }
        
        return totalScore
    }
}