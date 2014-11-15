//
//  ArchTableViewCell.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/14/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit

class ArchTableViewCell: UITableViewCell {
	
	@IBOutlet weak var pic: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var memoLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
