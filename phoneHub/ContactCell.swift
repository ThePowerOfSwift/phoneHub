//
//  ContactCell.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/2/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import Foundation
import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var memoLabel: UILabel!
	@IBOutlet weak var phoneType: UILabel!
	
	var phone: String!
	var status: String!
	var created: NSDate!
	
	var called: NSDate!
	var latitude: Double!
	var longitude: Double!
	
	func load(name:String, phoneType:String, memo:String, pic:UIImage, phone:String, status: String, created: NSDate){
		self.nameLabel.text = name
		self.phoneType.text = phoneType
		self.memoLabel.text = memo
		self.pic.image = pic
		self.phone = phone
		self.status = status
		self.created = created
		self.called = nil
		self.latitude = nil
		self.longitude = nil
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
