//
//  GameTableViewCell.swift
//  jumpshot-2
//
//  Created by Jonathan Yu on 2/21/15.
//  Copyright (c) 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit

class GameTableViewCell: UITableViewCell {
    var headerBar: UIView!
    var bottomBar: UIView!
    
    var team1Score: UILabel!
    var team2Score: UILabel!
    var titleLabel: UILabel!
    
//    Static labels
    var team1Caption: UILabel!
    var team2Caption: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        headerBar = UIView()
        headerBar.backgroundColor = UIColor.grayColor()
        bottomBar = UIView()
        
        titleLabel = UILabel()
        titleLabel.font = UIFont(name: "ArialRoundedMTBold", size: 13.0)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        
//        Handles team 1 / 2 captions
        team1Caption = UILabel()
        team1Caption.font = UIFont(name: "ArialRoundedMTBold", size: 11.0)
        team1Caption.text = "Team 1"
        team1Caption.textAlignment = NSTextAlignment.Center
        team1Caption.adjustsFontSizeToFitWidth = true
        team1Caption.minimumScaleFactor = 0.5
        
        team2Caption = UILabel()
        team2Caption.font = UIFont(name: "ArialRoundedMTBold", size: 11.0)
        team2Caption.text = "Team 2"
        team2Caption.textAlignment = NSTextAlignment.Center
        team2Caption.adjustsFontSizeToFitWidth = true
        team2Caption.minimumScaleFactor = 0.5
        
//        Team Score Labels
        team1Score = UILabel()
        team1Score.font = UIFont(name: "ArialRoundedMTBold", size: 16.0)
        team1Score.adjustsFontSizeToFitWidth = true
        team1Score.backgroundColor = UIColor(rgba: "#bdc3c7")
        team1Score.layer.borderWidth = 2
        team1Score.minimumScaleFactor = 0.5
        team1Score.textAlignment = NSTextAlignment.Center
        team1Score.layer.cornerRadius = 4
        team1Score.clipsToBounds = true

        team2Score = UILabel()
        team2Score.font = UIFont(name: "ArialRoundedMTBold", size: 16.0)
        team2Score.adjustsFontSizeToFitWidth = true
        team2Score.backgroundColor = UIColor(rgba: "#bdc3c7")
        team2Score.layer.borderWidth = 2
        team2Score.minimumScaleFactor = 0.5
        team2Score.textAlignment = NSTextAlignment.Center
        team2Score.layer.cornerRadius = 4
        team2Score.clipsToBounds = true
        
        headerBar.addSubview(titleLabel)
        
        self.contentView.addSubview(headerBar)
        self.contentView.addSubview(bottomBar)
        self.contentView.addSubview(team1Caption)
        self.contentView.addSubview(team2Caption)
        self.contentView.addSubview(team1Score)
        self.contentView.addSubview(team2Score)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerBar.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height/2.0)
        bottomBar.frame = CGRectMake(0, self.headerBar.bounds.size.height, self.headerBar.bounds.size.width, self.headerBar.bounds.size.height)
        titleLabel.frame = CGRectMake(0, 0, self.headerBar.bounds.size.width/2.0, self.headerBar.bounds.size.height)
        
        team1Caption.frame = CGRectMake(self.contentView.bounds.size.width * (3/5), self.contentView.bounds.size.height * (2/3), self.headerBar.bounds.size.width/5.0, self.contentView.bounds.size.height * (1/3))
        team2Caption.frame = CGRectMake(self.contentView.bounds.size.width * (4/5), self.team1Caption.frame.origin.y, self.team1Caption.bounds.size.width, self.team1Caption.bounds.size.height)
        
        team1Score.frame = CGRectMake(self.contentView.bounds.size.width * (3/5), self.contentView.bounds.size.height * (1/8), self.headerBar.bounds.size.width/5.2, self.contentView.bounds.size.height * (0.5))
        team2Score.frame = CGRectMake(self.contentView.bounds.size.width * (4/5), self.team1Score.frame.origin.y, self.team1Score.bounds.size.width, self.team1Score.bounds.size.height)
        
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}