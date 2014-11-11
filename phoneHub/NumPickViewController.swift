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
    var contact: ABMultiValueRef!
    var phone: ABMultiValueRef!
    var person: Contacts!
//	var ary: NSArray!
	var numbers: UIView!
	var phoneDict = [String:String]()
	let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!

	var tblView =  UIView(frame: CGRectZero)
	
    override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		nameLabel.text = contact as NSString
		tableView.tableFooterView = tblView
		tableView.backgroundColor = UIColor.clearColor()
		self.tableView.reloadData()
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
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "numberSelected" {
            let destVC: EditViewController = segue.destinationViewController as EditViewController
        }
    }
	
	
//Start AB
    
    @IBAction func bktoAB(sender: UIBarButtonItem) {
        let picker = ABPeoplePickerNavigationController()
        picker.peoplePickerDelegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, didSelectPerson person: ABRecordRef!) {
        contact = ABRecordCopyCompositeName(person).takeRetainedValue()
        var phones: ABMultiValueRef = ABRecordCopyValue(person, kABPersonPhoneProperty).takeRetainedValue()
//        ary = ABMultiValueCopyArrayOfAllValues(phones).takeUnretainedValue() as NSArray
        phone = ABMultiValueCopyValueAtIndex(phones, 0 as CFIndex).takeRetainedValue()

        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        let entityDescription = NSEntityDescription.entityForName("Contacts", inManagedObjectContext: managedObjectContext)
        var thePerson = Contacts(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext) as Contacts
        thePerson.name = contact as String
        thePerson.phone = phone as String
        self.person = thePerson
    }
    
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, shouldContinueAfterSelectingPerson person: ABRecordRef!) -> Bool {
        peoplePickerNavigationController(peoplePicker, didSelectPerson: person)
        peoplePicker.dismissViewControllerAnimated(true, completion: nil)
        return false;
    }
    
    func peoplePickerNavigationControllerDidCancel(peoplePicker: ABPeoplePickerNavigationController!) {
        peoplePicker.dismissViewControllerAnimated(true, completion: nil)
    }
//End AB

}
