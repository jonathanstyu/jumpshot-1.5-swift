//
//  PlayerTableViewCell.swift
//  jumpshot-2
//
//  Created by Jonathan Yu on 2/10/15.
//  Copyright (c) 2015 Jonathan Yu. All rights reserved.
//

import Foundation
import UIKit

class PlayerTableViewCell: UITableViewCell {
    var nameLabel: UILabel!
    var ageLabel: UILabel!
    var heightLabel: UILabel!
    var reboundsAverageLabel: UILabel!
    var pointsAveragelabel: UILabel!
    var assistsAveragelabel: UILabel!
    var blocksAveragelabel: UILabel!
    
    var headerBar: UIView!
    var bottomBar: UIView!
    
    var kMargin: CGFloat = 1.0/8.0
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        headerBar.frame = CGRect(x: 0, y: 0, width: self.contentView.bounds.width, height: self.contentView.bounds.height * (0.7))
        bottomBar.frame = CGRect(x: 0, y: headerBar.frame.height, width: self.contentView.bounds.width, height: self.contentView.bounds.height * (0.3))
        
        nameLabel.frame = CGRect(x: self.headerBar.bounds.width * (1.0/12.0), y: 0, width: self.headerBar.bounds.width, height: self.headerBar.bounds.height)
        
        pointsAveragelabel.frame = CGRect(x: 0, y: 0, width: self.bottomBar.bounds.width * (1.0/4.0), height: self.bottomBar.bounds.height)
        reboundsAverageLabel.frame = CGRect(x: self.pointsAveragelabel.bounds.width, y: 0, width: self.bottomBar.bounds.width * (1.0/4.0), height: self.bottomBar.bounds.height)
        assistsAveragelabel.frame = CGRect(x: self.pointsAveragelabel.bounds.width + self.reboundsAverageLabel.bounds.width, y: 0, width: self.bottomBar.bounds.width * (1.0/4.0), height: self.bottomBar.bounds.height)
        blocksAveragelabel.frame = CGRect(x: self.pointsAveragelabel.bounds.width + self.reboundsAverageLabel.bounds.width + self.assistsAveragelabel.bounds.width, y: 0, width: self.bottomBar.bounds.width * (1.0/4.0), height: self.bottomBar.bounds.height)
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        headerBar = UIView()
        bottomBar = UIView()
        
        pointsAveragelabel = UILabel()
        reboundsAverageLabel = UILabel()
        blocksAveragelabel = UILabel()
        assistsAveragelabel = UILabel()
        nameLabel = UILabel()
        
        bottomBar.backgroundColor = UIColor.grayColor()
        
        nameLabel.font = UIFont(name: "ArialRoundedMTBold", size: 16.0)
        
        pointsAveragelabel.font = UIFont(name: "ArialRoundedMTBold", size: 12.0)
        pointsAveragelabel.textAlignment = NSTextAlignment.Center
        pointsAveragelabel.textColor = UIColor.whiteColor()
        
        reboundsAverageLabel.font = UIFont(name: "ArialRoundedMTBold", size: 12.0)
        reboundsAverageLabel.textAlignment = NSTextAlignment.Center
        reboundsAverageLabel.textColor = UIColor.whiteColor()
        
        assistsAveragelabel.font = UIFont(name: "ArialRoundedMTBold", size: 12.0)
        assistsAveragelabel.textAlignment = NSTextAlignment.Center
        assistsAveragelabel.textColor = UIColor.whiteColor()
        
        blocksAveragelabel.font = UIFont(name: "ArialRoundedMTBold", size: 12.0)
        blocksAveragelabel.textAlignment = NSTextAlignment.Center
        blocksAveragelabel.textColor = UIColor.whiteColor()
        
        self.contentView.addSubview(headerBar)
        self.contentView.addSubview(bottomBar)
        
        self.bottomBar.addSubview(reboundsAverageLabel)
        self.bottomBar.addSubview(pointsAveragelabel)
        self.bottomBar.addSubview(assistsAveragelabel)
        self.bottomBar.addSubview(blocksAveragelabel)
        
        self.headerBar.addSubview(nameLabel)
    }
    
}