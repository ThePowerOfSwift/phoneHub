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
		nameLabel = UILabel(frame: CGRectMake(140, 75, 150, 50))
		nameLabel.text = contact.name
//		nameLabel.textColor = UIColor.whiteColor()
		//phoneLabel
		phoneLabel = UILabel(frame: CGRectMake(140, 125, 150, 50))
		phoneLabel.text = contact.phone
//		phoneLabel.textColor = UIColor.whiteColor()
		//addSubview
		self.view.addSubview(nameLabel)
		self.view.addSubview(phoneLabel)
		
		self.view.addSubview(completeButton)
		self.view.addSubview(callBackButton)
		self.view.addSubview(leftMessageButton)
		self.view.addSubview(textedInsteadButton)

	}
}