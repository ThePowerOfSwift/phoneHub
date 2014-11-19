//
//  NumPickViewController.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/4/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit
import AddressBookUI
import CoreData

class NumPickViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ABPeoplePickerNavigationControllerDelegate {

	@IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var pic: UIImageView!
	
	var image: UIImage!
    var contact: ABMultiValueRef!
	var numbers: UIView!
	var selectedType: String = ""
	var selectedNumber: String = ""
	var i :Int = 0
	var ary:[String] = []
	var aryLabel:String! = ""
	var phoneDict = [String:String]()
	let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)

	let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
	var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()

	var tblView =  UIView(frame: CGRectZero)
	
    override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		pic.image = image
		nameLabel.text = contact as NSString
		tableView.tableFooterView = tblView
		tableView.backgroundColor = UIColor.clearColor()
		self.tableView.reloadData()
	}

	func controllerDidChangeContent(controller: NSFetchedResultsController) {
		tableView.reloadData()
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return phoneDict.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell: NumberCell = tableView.dequeueReusableCellWithIdentifier("phoneNum") as NumberCell
		cell.typeLabel.text = Array(phoneDict.keys)[indexPath.row]
		cell.numLabel.text = Array(phoneDict.values)[indexPath.row]
		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		selectedType = Array(phoneDict.keys)[indexPath.row]
		selectedNumber = Array(phoneDict.values)[indexPath.row]
		
		var newEntry = NSEntityDescription.insertNewObjectForEntityForName("Contacts", inManagedObjectContext: managedObjectContext) as Contacts
		
		newEntry.name = contact as NSString
		newEntry.phone = selectedNumber
		newEntry.phoneType = selectedType
		newEntry.memo = ""
		newEntry.photo = UIImageJPEGRepresentation(image, 1)
		
		appDelegate.saveContext()
		self.navigationController?.popToRootViewControllerAnimated(true)
	}

//Start AB
    
    @IBAction func bktoAB(sender: UIBarButtonItem) {
		//going back clears current data
		ary = []
		aryLabel = ""
		phoneDict.removeAll()
		
		let picker = ABPeoplePickerNavigationController()
        picker.peoplePickerDelegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
    
	func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, didSelectPerson person: ABRecordRef!) {

		var labelAry:[String] = []	//labelAry defined here or it needs to be cleared out for each new contact
		let imgData = ABPersonCopyImageDataWithFormat(person, kABPersonImageFormatThumbnail)?.takeRetainedValue()
		if imgData != nil {
			image = UIImage(data:imgData!)
		} else {
			image = UIImage(named:"152 - iPad")
		}
		pic.image = image
		contact = ABRecordCopyCompositeName(person).takeRetainedValue()
		var phones: ABMultiValueRef = ABRecordCopyValue(person, kABPersonPhoneProperty).takeRetainedValue()
		//load phone numbers into array
		ary = ABMultiValueCopyArrayOfAllValues(phones).takeRetainedValue() as [String]
		
		//load phone labels into array
		for i=0; i<ary.count; i++ {
			aryLabel = String(ABMultiValueCopyLabelAtIndex(phones,i).takeRetainedValue())
			aryLabel = aryLabel.substringWithRange(Range<String.Index>(start: advance(aryLabel.startIndex, 4), end: advance(aryLabel.endIndex, -4)))
			labelAry.append(aryLabel)
		}
		
		//merge labels and nums into dictionary
		for i=0; i<ary.count; i++ {
			phoneDict[labelAry[i]] = ary[i]
		}
	}
	
	func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, shouldContinueAfterSelectingPerson person: ABRecordRef!) -> Bool {
		peoplePickerNavigationController(peoplePicker, didSelectPerson: person)
		peoplePicker.dismissViewControllerAnimated(true, completion: nil)
		
		return false;
	}
	
	func peoplePickerNavigationControllerDidCancel(peoplePicker: ABPeoplePickerNavigationController!) {
		//peoplePicker.dismissViewControllerAnimated(true, completion: nil)
	self.navigationController?.popToRootViewControllerAnimated(true)
	}
//End AB

}
