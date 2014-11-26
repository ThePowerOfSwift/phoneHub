//
//  ABViewController.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/19/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit
import AddressBookUI
import CoreData

class ABNavController:ABPeoplePickerNavigationController, ABPeoplePickerNavigationControllerDelegate{

	let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!

	func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, didSelectPerson person: ABRecord!, property: ABPropertyID, identifier: ABMultiValueIdentifier) {
		//save AB record
		let index = ABMultiValueGetIndexForIdentifier(ABRecordCopyValue(person, kABPersonPhoneProperty).takeRetainedValue(), identifier)
		let record: AnyObject = ABRecordCopyValue(person, property).takeRetainedValue()
		let label = ABMultiValueCopyLabelAtIndex(record, index).takeRetainedValue()
		var profilePic:UIImage!
		
		//stage data for new contact entry
		var imgData = ABPersonCopyImageDataWithFormat(person, kABPersonImageFormatThumbnail)?.takeRetainedValue()
		if imgData != nil {
			profilePic = UIImage(data:imgData!)
		} else {
			profilePic = UIImage(named: "contact iconNew")?.imageWithColor(UIColor.whiteColor())
		}
		let name = ABRecordCopyCompositeName(person).takeRetainedValue() as String
		let phone = ABMultiValueCopyValueAtIndex(record,index).takeRetainedValue() as String
		let phoneType = ABAddressBookCopyLocalizedLabel(label).takeRetainedValue() as String
		
		//create new contact entry
		let newEntry:Contacts = Contacts(
			name: name,
			phone: phone,
			phoneType: phoneType,
			photo: UIImagePNGRepresentation(profilePic),
			status: "newCall",
			context: managedObjectContext
		)
	}
}