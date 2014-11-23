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

	override func viewDidLoad() {
		super.viewDidLoad()
		
		//nameLabel
		nameLabel = UILabel(frame: CGRectMake(20, 50, 150, 50))
		nameLabel.text = contact.name

		
		//addSubview
		self.view.addSubview(nameLabel)
		
		
	}
	
}
