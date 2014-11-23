//
//  Entry.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/18/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import Foundation
import UIKit

class Entry{
	var name: String!
	var photo: UIImage!
	var phone: String!
	var phoneType: String!
	var status: String!
	var created: NSDate!
	var memo: String
	var called: NSDate?
	var latitude: Double?
	var longitude: Double?
	
	init(name: String, photo: UIImage, phone: String, phoneType:String, status: String, created: NSDate, called:NSDate, memo: String, latitude: Double, longitude: Double){
		self.name = name
		self.photo = photo
		self.phone = phone
		self.phoneType = phoneType
		self.status = status
		self.created = created
		self.memo = memo
		self.called = called
		self.latitude = latitude
		self.longitude = longitude
	}

	init(name: String, photo: UIImage, phone: String, phoneType:String, status: String, created: NSDate, memo: String){
		self.name = name
		self.photo = photo
		self.phone = phone
		self.phoneType = phoneType
		self.status = status
		self.created = created
		self.memo = memo
		self.called = nil
		self.latitude = nil
		self.longitude = nil
	}
	
}