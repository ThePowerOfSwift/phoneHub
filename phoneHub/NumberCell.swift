//
//  NumberCell.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/11/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit

class NumberCell: UITableViewCell {

	@IBOutlet weak var typeLabel: UILabel!
	@IBOutlet weak var numLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
