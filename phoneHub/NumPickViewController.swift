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

class NumPickViewController: UIViewController, ABPeoplePickerNavigationControllerDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    var contact: ABMultiValueRef!
    var phone: ABMultiValueRef!
    var person: Contacts!
	var ary: NSArray!
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    
    override func viewDidAppear(animated: Bool) {
        println("asdf: \(contact)")
		println("qwer: \(ary)")
        nameLabel.text = contact as NSString
		
        displayList()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "numberSelected" {
            let destVC: EditViewController = segue.destinationViewController as EditViewController
        }
    }
    
    @IBAction func tapNum(sender: UIButton) {
        performSegueWithIdentifier("numberSelected", sender: self)
    }

    func displayList(){
        
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
        
        phone = ABMultiValueCopyValueAtIndex(phones, 0 as CFIndex).takeRetainedValue()
        println("asdf: \(contact)")
        println("asdf: \(phones)")

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
