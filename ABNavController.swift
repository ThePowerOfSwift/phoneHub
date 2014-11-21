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
		let index = ABMultiValueGetIndexForIdentifier(ABRecordCopyValue(person, kABPersonPhoneProperty).takeRetainedValue(), identifier)
		let record: AnyObject = ABRecordCopyValue(person, property).takeRetainedValue()
		let label = ABMultiValueCopyLabelAtIndex(record, index).takeRetainedValue()
		let profilePic = UIImage(named: "152 - iPad")
		let name = ABRecordCopyCompositeName(person).takeRetainedValue() as String
		let phone = ABMultiValueCopyValueAtIndex(record,index).takeRetainedValue() as String
		let phoneType = ABAddressBookCopyLocalizedLabel(label).takeRetainedValue() as String
		let newEntry:Contacts = Contacts(
			name: name,
			phone: phone,
			phoneType: phoneType,
			photo: UIImageJPEGRepresentation(profilePic, 1),
			status: "newCall",
			context: managedObjectContext
		)
	}
}