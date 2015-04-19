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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = true
        
        self.layer.borderWidth = 1
        
        headerBar = UIView()
        headerBar.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height * 0.3)
        headerBar.backgroundColor = UIColor(rgba: "#2c3e50")
        
        nameLabel = UILabel()
        nameLabel.font = UIFont(name: "ArialRoundedMTBold", size: 18.0)
        nameLabel.textColor = UIColor.whiteColor()
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.5
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
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
}