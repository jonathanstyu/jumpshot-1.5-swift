//
//  PlayerRankViewController.swift
//  jumpshot-2
//
//  Created by Jonathan Yu on 5/10/15.
//  Copyright (c) 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit
import Realm

class PlayerRankViewController: UITableViewController, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    var allPlayers: [Player]!
    var headerLabelTitles: [String] = ["points", "rebounds", "assists", "steals", "blocks"]
    
    override func viewDidLoad() {
        self.title = "Statistics"
        allPlayers = Player.allPlayers()
        tableView = UITableView(frame: tableView.frame, style: .Plain)
        
        self.tableView.emptyDataSetDelegate = self
        self.tableView.emptyDataSetSource = self
        self.tableView.tableFooterView = UIView.new()
        tableView.registerClass(PlayerTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: PlayerTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as! PlayerTableViewCell
        
        let selectedPlayer = self.allPlayers[indexPath.row] as Player
        
        //        cell.bottomBar.backgroundColor = UIColor(rgba: "#8e44ad")
        cell.nameLabel?.text = selectedPlayer.name.uppercaseString
        
        cell.gamesCountLabel?.text = String(format: "%.1f", selectedPlayer.averageStatistic("points"))
        cell.pointsAveragelabel?.text = String(format: "%.1f", selectedPlayer.averageStatistic("rebounds"))
        cell.reboundsAverageLabel?.text = String(format: "%.1f", selectedPlayer.averageStatistic("assists"))
        cell.assistsAveragelabel?.text = String(format: "%.1f", selectedPlayer.averageStatistic("steals"))
        cell.blocksAveragelabel?.text = String(format: "%.1f", selectedPlayer.averageStatistic("blocks"))
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let selectedPlayer = allPlayers[indexPath.row] as Player
        let vc: PlayerProfileVC = PlayerProfileVC()
        
        vc.selectedPlayer = selectedPlayer
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(self.allPlayers.count)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var indexBar = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        indexBar.backgroundColor = UIColor(rgba: "#f0f0d0")
        
        for var i = 0; i < 5; ++i {
            var headerContainView = UIView()
            var headerLabel = UILabel()
            
            
            headerContainView.frame = CGRect(x: (indexBar.bounds.size.width / 5.0) * CGFloat(i), y: 0, width: (indexBar.bounds.size.width / 5.0), height: indexBar.frame.size.height)
            headerLabel.frame = CGRectMake(0, 0, headerContainView.bounds.size.width, headerContainView.bounds.size.height)
            
            headerLabel.text = headerLabelTitles[i].uppercaseString
            headerLabel.textColor = UIColor.blackColor()
            headerLabel.font = UIFont(name: "ArialRoundedMTBold", size: 12.0)
            headerLabel.textAlignment = NSTextAlignment.Center
            
            headerContainView.tag = i
            headerContainView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("headerTapped:")))
            
            headerContainView.addSubview(headerLabel)
            indexBar.addSubview(headerContainView)
        }
        
        return indexBar
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func headerTapped(gesture: UITapGestureRecognizer) {
        var tappedHeader: UIView = gesture.view as UIView!
        var label: UILabel = tappedHeader.subviews[0] as! UILabel
        var metric: String = label.text?.lowercaseString as String!
        
        if allPlayers.count > 1 {
            if allPlayers[0].averageStatistic(metric) > allPlayers[1].averageStatistic(metric) {
                allPlayers.sort { $0.averageStatistic(metric) < $1.averageStatistic(metric) }
            } else {
                allPlayers.sort { $0.averageStatistic(metric) > $1.averageStatistic(metric) }
            }
        }
        
        tableView.reloadData()
    }
    
//    For the empty data set condition
    deinit {
        self.tableView.emptyDataSetSource = nil
        self.tableView.emptyDataSetDelegate = nil
    }
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "No Players Here.", attributes: nil)
    }
    
    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "Confused")
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: "When you add a player, they will appear here.", attributes: nil)
    }

    
}