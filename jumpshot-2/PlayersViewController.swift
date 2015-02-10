//
//  PlayersViewController.swift
//  jumpshot-2
//
//  Created by Jonathan Yu on 2/8/15.
//  Copyright (c) 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit
import Realm

class PlayersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var playersTable: UITableView!
    var players: RLMResults!
    var selectedPlayer: Player!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        players = Player.allObjects()
        setupPlayersTable()
    }
    
    func setupPlayersTable() {
        self.playersTable = UITableView()
        self.playersTable.frame = CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: self.view.bounds.width, height: self.view.bounds.height)
        self.playersTable.delegate = self
        self.playersTable.dataSource = self
        self.playersTable.registerClass(PlayerTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(playersTable)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(players.count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: PlayerTableViewCell = playersTable.dequeueReusableCellWithIdentifier("Cell") as! PlayerTableViewCell
        
        let selectedPlayer = self.players.objectAtIndex(UInt(indexPath.row)) as! Player
        cell.nameLabel?.text = selectedPlayer.name
        
        return cell
    }

    
}