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
    dynamic var datePlayed = NSDate(timeIntervalSince1970: 1)
}