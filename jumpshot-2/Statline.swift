//
//  Statline.swift
//  jumpshot-2
//
//  Created by Jonathan Yu on 2/9/15.
//  Copyright (c) 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import Realm

class Statline: RLMObject {
    
    dynamic var points = 0
    dynamic var rebounds = 0
    dynamic var assists = 0
    dynamic var steals = 0
    dynamic var blocks = 0
    dynamic var turnovers = 0
    dynamic var minutes = 0
    dynamic var fieldGoalsMade = 0
    dynamic var fieldGoalsMissed = 0
    dynamic var freeThrowsMade = 0
    dynamic var freeThrowsMissed = 0
    dynamic var threeFieldGoalsMade = 0
    dynamic var threeFieldGoalsMissed = 0
    
    dynamic var id = Int(arc4random_uniform(UInt32(999999)))
    dynamic var owner: Player?
    dynamic var game: Game?
    dynamic var game_id = 0    
    
    func statCall(requestedStat: String) -> Int {
        var statMap = ["points": 0, "rebounds": 1, "assists": 2, "steals": 3, "blocks": 4, "turnovers": 5, "minutes": 6, "fieldGoalsMade": 7, "fieldGoalsMissed": 8, "freeThrowsMade": 9, "freeThrowsMissed": 10, "threeFieldGoalsMade": 11, "threeFieldGoalsMissed": 12]
        
        if (statMap[requestedStat] != nil) {
            return reflect(self)[statMap[requestedStat]!].1.value as! Int
        } else {
            return 0
        }
    }
    
    func statChange(event: String) -> Void {
        let realm = RLMRealm.defaultRealm()
        
        realm.beginWriteTransaction()
        switch event {
        case "fgMade":
            self.points += 2
            self.fieldGoalsMade += 1
        case "fgMiss":
            self.fieldGoalsMissed += 1
        case "3fgMade":
            self.points += 3
            self.threeFieldGoalsMade += 1
        case "3fgMiss":
            self.threeFieldGoalsMissed += 1
        case "rebound":
            self.rebounds += 1
        case "assist":
            self.assists += 1
        case "steals":
            self.steals += 1
        case "block":
            self.blocks += 1
        case "turnover":
            self.turnovers += 1
        default:
            self.points += 0
        }
        realm.commitWriteTransaction()
    }
    
}