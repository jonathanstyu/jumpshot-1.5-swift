//
//  Player.swift
//  jumpshot-2
//
//  Created by Jonathan Yu on 2/8/15.
//  Copyright (c) 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit
import Realm

class Player: RLMObject {
    dynamic var name = ""
    dynamic var age = 0
    dynamic var height = ""
    dynamic var playerStatLines = RLMArray(objectClassName: Statline.className())
    dynamic var id = Int(arc4random_uniform(UInt32(999999)))
    
    func sumStatistic(statistic: String) -> Int {
        
        var sum: Int = 0
        
        for var lineIndex = 0; lineIndex < Int(self.playerStatLines.count); ++lineIndex {
            var selectedStatLine = self.playerStatLines.objectAtIndex(UInt(lineIndex)) as! Statline
            
//            println(sum)
//            println(selectedStatLine.statCall("points"))
            
            switch statistic {
                case "points":
                sum += selectedStatLine.points
                case "rebounds":
                sum += selectedStatLine.rebounds
                case "assists":
                sum += selectedStatLine.assists
                case "steals":
                sum += selectedStatLine.steals
                case "blocks":
                sum += selectedStatLine.blocks
                case "turnovers":
                sum += selectedStatLine.turnovers
            default:
                sum = 0
            }
        }
        return sum
    }
    
    func averageStatistic(statistic: String) -> Double {
        if self.playerStatLines.count > 0 {
            return Double(sumStatistic(statistic)) / Double(self.playerStatLines.count)
        } else {
            return 0.0
        }
    }
    
    
}