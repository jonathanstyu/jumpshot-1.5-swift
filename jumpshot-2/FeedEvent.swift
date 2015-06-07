//
//  Feed.swift
//  jumpshot-2
//
//  Created by Jonathan Yu on 5/31/15.
//  Copyright (c) 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit
import Realm

class FeedEvent: RLMObject {
    dynamic var text = ""
    dynamic var time = NSDate()
    dynamic var team = 0
    
    class func newFeedEvent(event: String, statline: Statline, team: Int) -> FeedEvent {
        var feed = FeedEvent()
        var relevantPlayer: Player = statline.owner!
        
        feed.team = team
        feed.text = "\(relevantPlayer.name as String)"
        
        switch event {
        case "fgMade":
            feed.text += " made a field goal."
        case "fgMiss":
            feed.text += " missed a field goal."
        case "3fgMade":
            feed.text += " made a three point field goal."
        case "3fgMiss":
            feed.text += " missed a three point field goal."
        case "rebound":
            feed.text += " rebounded the ball."
        case "assist":
            feed.text += " assisted on a shot."
        case "steals":
            feed.text += " stole the ball."
        case "block":
            feed.text += " blocked the shot."
        case "turnover":
            feed.text += " turned the ball over."
        default:
            feed.text += "."
        }
        
        return feed
    }
    
    class func createFeedEvent(event: String, statline: Statline, team: Int) -> Void {
        var feed = FeedEvent.newFeedEvent(event, statline: statline, team: team)
        let realm = RLMRealm.defaultRealm()
        
        realm.beginWriteTransaction()
        statline.game?.eventFeed.insertObject(feed, atIndex: 0)
        realm.commitWriteTransaction()
    }
}
