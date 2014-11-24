//
//  TapCallViewController.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/22/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class TapCallViewController: BaseCallerViewController {

	var nameLabel:UILabel!
	var phoneLabel:UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//nameLabel
		nameLabel = UILabel(frame: CGRectMake(140, 70, 150, 50))
		nameLabel.text = contact.name

		//phoneLabel
		phoneLabel = UILabel(frame: CGRectMake(140, 120, 150, 50))
		phoneLabel.text = contact.phone
		
		//addSubview
		self.view.addSubview(nameLabel)
		self.view.addSubview(phoneLabel)
	}
}