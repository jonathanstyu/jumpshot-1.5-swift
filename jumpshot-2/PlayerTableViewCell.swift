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
    var pointsTotallabel: UILabel!
    
    var colorBar: UIView!
    
    var kMargin: CGFloat = 1.0/8.0
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        colorBar = UIView(frame: CGRect(x: 0, y: self.contentView.bounds.height * (kMargin), width: 20.0, height: self.contentView.bounds.height * (1-kMargin)))
        
        colorBar.backgroundColor = UIColor.blueColor()
        
        nameLabel = UILabel(frame: CGRect(x: self.contentView.bounds.width * (1.0/10.0), y: 0, width: self.contentView.bounds.width * (1.0/2.0), height: self.contentView.bounds.height * (1.0/2.0)))
        pointsTotallabel = UILabel(frame: CGRect(x: self.contentView.bounds.width * (1.0/10.0), y: self.contentView.bounds.height - nameLabel.bounds.height, width: self.contentView.bounds.width * (1.0/2.0), height: self.contentView.bounds.height * (1.0/2.0)))
        
        self.contentView.addSubview(pointsTotallabel)
        self.contentView.addSubview(colorBar)
        self.contentView.addSubview(nameLabel)
    }
    
}