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
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        
        contentView.addSubview(nameLabel)
    }
    
}