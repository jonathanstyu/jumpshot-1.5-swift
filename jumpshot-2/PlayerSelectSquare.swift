//
//  PlayerSelectSquare.swift
//  jumpshot-2
//
//  Created by Jonathan Yu on 4/18/15.
//  Copyright (c) 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit

class PlayerSelectSquare: UIView {
    
    var nameLabel: UILabel!
    var teamBadge: UILabel!
    
    var headerBar: UIView!
    
    var playerStatline: Statline!
    
    internal init(frame: CGRect, statline: Statline) {
        super.init(frame: frame)
        self.userInteractionEnabled = true
        
        self.playerStatline = statline
        self.layer.borderWidth = 1
        
//        Header bar, first row of the cell
        
        headerBar = UIView()
        headerBar.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height * 0.33)
        headerBar.backgroundColor = UIColor(rgba: "#2c3e50")
        
        nameLabel = UILabel()
        nameLabel.font = UIFont(name: "ArialRoundedMTBold", size: 18.0)
        nameLabel.textColor = UIColor.whiteColor()
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.5
        nameLabel.text = self.playerStatline.owner?.name.uppercaseString
        nameLabel.frame = CGRect(x: 5, y: 0, width: (headerBar.bounds.size.width - 5) * 0.67, height: headerBar.bounds.size.height)
        
        teamBadge = UILabel()
        teamBadge.font = UIFont(name: "ArialRoundedMTBold", size: 12.0)
        teamBadge.adjustsFontSizeToFitWidth = true
        teamBadge.minimumScaleFactor = 0.5
        teamBadge.textAlignment = NSTextAlignment.Center
        teamBadge.layer.cornerRadius = 4
        teamBadge.clipsToBounds = true
        teamBadge.frame = CGRectMake(nameLabel.bounds.size.width + 5, 0, (headerBar.bounds.size.width - 5) * 0.33, headerBar.bounds.size.height * 0.5)
        
        headerBar.addSubview(teamBadge)
        headerBar.addSubview(nameLabel)
        self.addSubview(headerBar)
        
//        Second and third row of the cell
        for var z = 0; z < 2; ++z {
            var containerView: UIView
            
            containerView = UIView()
            containerView.frame = CGRectMake(0, headerBar.bounds.size.height + (self.bounds.size.height * 0.33 * CGFloat(z)), self.bounds.size.width, self.bounds.size.height * 0.33)
            containerView.backgroundColor = UIColor.whiteColor()
            
            for var i = 0; i < 3; ++i {
                var contentLabel: UILabel
                var labelArray: Array = [["POINTS", "REBS", "AST"], ["STL", "BLK", "FGM"]]
                
                contentLabel = UILabel()
                contentLabel.font = UIFont(name: "ArialRoundedMTBold", size: 12.0)
                contentLabel.textColor = UIColor.blackColor()
                contentLabel.adjustsFontSizeToFitWidth = true
                contentLabel.minimumScaleFactor = 0.5
                
                contentLabel.text = labelArray[z][i]
                contentLabel.textAlignment = NSTextAlignment.Center
                
                contentLabel.frame = CGRect(x: (containerView.bounds.size.width / 3.0) * CGFloat(i), y: 0, width: (containerView.bounds.size.width / 3.0), height: containerView.bounds.size.height * (1/3))
                
                containerView.addSubview(contentLabel)
            }
            
            for var i = 0; i < 3; ++i {
                var dataLabel: UILabel
                
                dataLabel = UILabel()
                dataLabel.font = UIFont(name: "ArialRoundedMTBold", size: 14.0)
                dataLabel.textColor = UIColor.blackColor()
                dataLabel.adjustsFontSizeToFitWidth = true
                dataLabel.minimumScaleFactor = 0.5
                dataLabel.textAlignment = NSTextAlignment.Center
                dataLabel.text = "34.9"
                dataLabel.tag = (i + 900) * (z + 1)
                
                dataLabel.frame = CGRect(x: (containerView.bounds.size.width / 3.0) * CGFloat(i), y: containerView.bounds.size.height * (1/3), width: (containerView.bounds.size.width / 3.0), height: containerView.bounds.size.height * (2/3))
                
                containerView.addSubview(dataLabel)
            }
            
            self.addSubview(containerView)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func updateDataLabels() {
        
        var ptLabel: UILabel = self.viewWithTag(900) as! UILabel
        var rebLabel: UILabel = self.viewWithTag(901) as! UILabel
        var astLabel: UILabel = self.viewWithTag(902) as! UILabel
        
        var stLabel: UILabel = self.viewWithTag(1800) as! UILabel
        var blkLabel: UILabel = self.viewWithTag(1802) as! UILabel
        var fgLabel: UILabel = self.viewWithTag(1804) as! UILabel
        
        ptLabel.text = "\(self.playerStatline.points)"
        rebLabel.text = "\(self.playerStatline.rebounds)"
        astLabel.text = "\(self.playerStatline.assists)"
        
        stLabel.text = "\(self.playerStatline.steals)"
        blkLabel.text = "\(self.playerStatline.blocks)"
        fgLabel.text = "\(self.playerStatline.fieldGoalsMade)/\(self.playerStatline.fieldGoalsMade + self.playerStatline.fieldGoalsMissed)"
        
    }
    
}