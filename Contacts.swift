//
//  Contacts.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/16/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Contacts: NSManagedObject {

    @NSManaged var called: NSDate?
    @NSManaged var created: NSDate
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var memo: String
    @NSManaged var name: String
    @NSManaged var phone: String
    @NSManaged var phoneType: String
    @NSManaged var photo: NSData
    @NSManaged var status: String

//**remember to keep both initalizers updated
	
//full initializer
	convenience init(name:String, phone:String, phoneType: String, photo: NSData, status: String, called: NSDate, latitude: NSNumber, longitude: NSNumber, context: NSManagedObjectContext) {
		let entity = NSEntityDescription.entityForName("Contacts", inManagedObjectContext: context)!
		self.init(entity: entity, insertIntoManagedObjectContext: context)
		self.name = name
		self.phone = phone
		self.phoneType = phoneType
		self.photo = photo
		self.status = status
		self.created = NSDate()
		self.memo = ""
		self.called = called
		self.latitude = latitude
		self.longitude = longitude
	}

//w/o nils
	convenience init(name:String, phone:String, phoneType: String, photo: NSData, status: String, context: NSManagedObjectContext) {
		let entity = NSEntityDescription.entityForName("Contacts", inManagedObjectContext: context)!
		self.init(entity: entity, insertIntoManagedObjectContext: context)
		self.name = name
		self.phone = phone
		self.phoneType = phoneType
		self.photo = photo
		self.status = status
		self.created = NSDate()
		self.memo = ""
		self.called = nil
		self.latitude = nil
		self.longitude = nil
	}

	func update(name:String, phone:String, phoneType: String, photo: NSData, memo:String, status: String){
		let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)

		self.name = name
		self.phone = phone
		self.phoneType = phoneType
		self.photo = photo
		self.status = status
		self.memo = memo
		self.called = nil
		self.latitude = nil
		self.longitude = nil
		
		appDelegate.saveContext()
	}
	
	func update(name:String, phone:String, phoneType: String, photo: NSData, memo:String, status: String, called: NSDate, latitude: NSNumber, longitude:NSNumber){
		let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
		
		self.name = name
		self.phone = phone
		self.phoneType = phoneType
		self.photo = photo
		self.status = status
		self.memo = memo
		self.called = called
		self.latitude = latitude
		self.longitude = longitude
		
		appDelegate.saveContext()

	}
}
