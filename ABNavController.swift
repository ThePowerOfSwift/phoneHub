//
//  ABViewController.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/19/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit
import AddressBookUI

class ABNavController:ABPeoplePickerNavigationController,ABPeoplePickerNavigationControllerDelegate {
	var i :Int = 0
	var ary:[String] = []
	var image: UIImage!
    var contact: ABMultiValueRef!
	var aryLabel:String = ""
	var phoneDict = [String:String]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		peoplePickerDelegate = self
    }

	//Start AB
	func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, didSelectPerson person: ABRecordRef!) {
		
		var labelAry:[String] = []	//labelAry defined here or it needs to be cleared out for each new contact
		
		var imgData = ABPersonCopyImageDataWithFormat(person, kABPersonImageFormatThumbnail)?.takeRetainedValue()
		if imgData != nil {
			image = UIImage(data:imgData!)
		} else {
			image = UIImage(named:"152 - iPad")
		}
		contact = ABRecordCopyCompositeName(person).takeRetainedValue()
		var phones: ABMultiValueRef = ABRecordCopyValue(person, kABPersonPhoneProperty).takeRetainedValue()
		//load phone numbers into array
		ary = ABMultiValueCopyArrayOfAllValues(phones).takeRetainedValue() as [String]

		//load phone labels into array
		for i=0; i < ary.count; i++ {
			aryLabel = String(ABMultiValueCopyLabelAtIndex(phones,i).takeRetainedValue())
			aryLabel = aryLabel.substringWithRange(Range<String.Index>(start: advance(aryLabel.startIndex, 4), end: advance(aryLabel.endIndex, -4)))
			labelAry.append(aryLabel)
		}
		
		//merge labels and nums into dictionary
		for i=0; i<ary.count; i++ {
			phoneDict[labelAry[i]] = ary[i]
		}
//		performSegueWithIdentifier("showNumPicker", sender: self)
	}

//End AB

}
