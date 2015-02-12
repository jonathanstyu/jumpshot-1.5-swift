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
    
    func sumStatistic(statistic: String) -> Int {
        
        var sum: Int = 0
        
        for var lineIndex = 0; lineIndex < Int(self.playerStatLines.count); ++lineIndex {
            var selectedStatLine = self.playerStatLines.objectAtIndex(UInt(lineIndex)) as! Statline
            
            switch statistic {
                case "points":
                sum += selectedStatLine.points
                case "rebounds":
                sum += selectedStatLine.rebounds
            default:
                sum = 0
            }
        }
        
        return sum
    }
    
}