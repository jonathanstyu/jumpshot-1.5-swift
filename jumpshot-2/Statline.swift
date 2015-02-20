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
    dynamic var id = Int(arc4random_uniform(UInt32(999999)))
    
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
    
    dynamic var owner: Player?
    dynamic var game: Game?
}