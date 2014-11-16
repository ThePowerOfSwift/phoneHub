//
//  ViewController.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/2/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit
import AddressBookUI
import CoreData

class ViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, ABPeoplePickerNavigationControllerDelegate, NSFetchedResultsControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
	
	var i :Int = 0
	var ary:[String] = []
	var aryLabel:String = ""
	var phoneDict = [String:String]()
	var editRow:NSIndexPath!
	var tblView =  UIView(frame: CGRectZero)
	var image: UIImage!
    var contact: ABMultiValueRef!
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		textField.delegate = self
        fetchedResultsController = getFetchResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
    }
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
	tableView.tableFooterView = tblView
	tableView.backgroundColor = UIColor.whiteColor()
	}
	
	func textFieldShouldReturn(textField: UITextField!) -> Bool {
		textField.resignFirstResponder()
		return true
		// called when 'return' key pressed. return NO to ignore.
	}

	override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
		self.view.endEditing(true)
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		textField.text = ""
		if segue.identifier == "postCall" {
            let vc: PostCallViewController = segue.destinationViewController as PostCallViewController
			let indexPath = tableView.indexPathForSelectedRow()
			let cell = fetchedResultsController.objectAtIndexPath(indexPath!) as Contacts
			vc.contact = cell
        } else if segue.identifier == "showEdit" {
            let vc: EditViewController = segue.destinationViewController as EditViewController
			let cell = fetchedResultsController.objectAtIndexPath(editRow) as Contacts
			vc.contact = cell
        } else if segue.identifier == "showNumPicker" {
            let vc: NumPickViewController = segue.destinationViewController as NumPickViewController
            vc.contact = self.contact
			vc.phoneDict = self.phoneDict
			vc.image = self.image
		} else if segue.identifier == "directCall" {
			let vc: PostDirectCallViewController = segue.destinationViewController as PostDirectCallViewController
			vc.number = textField.text
		} else if segue.identifier == "nameOnly" {
			let vc: NameOnlyViewController = segue.destinationViewController as NameOnlyViewController
			vc.name = textField.text
		}
		phoneDict.removeAll()
    }

//Start Table
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let numberOfSections = fetchedResultsController.sections?.count
        return numberOfSections!
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInSection = fetchedResultsController.sections![section].numberOfObjects
        return numberOfRowsInSection!
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let theContact = fetchedResultsController.objectAtIndexPath(indexPath) as Contacts
        var cell: ContactCell = tableView.dequeueReusableCellWithIdentifier("listCell") as ContactCell
        cell.nameLabel.text = theContact.name
        cell.memoLabel.text = theContact.memo
		cell.phoneType.text = theContact.phoneType
		cell.pic.image = UIImage(data: theContact.photo)
        return cell
    }
//End Table

//Start Row Actions
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        let editAction = UITableViewRowAction(style: .Normal, title: "edit", handler: {
            (action, indexPath) -> Void in
			self.editRow = indexPath
            self.performSegueWithIdentifier("showEdit", sender: self)
            }
        )
        editAction.backgroundColor = UIColor.greenColor()
        
        let deleteAction = UITableViewRowAction(style: .Normal, title: "delete", handler: {
            (action, indexPath) -> Void in
            self.tableView(self.tableView, commitEditingStyle: .Delete, forRowAtIndexPath: indexPath)
            }
        )
        deleteAction.backgroundColor = UIColor.redColor()
		
        return [deleteAction, editAction]
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let managedObject: NSManagedObject = fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject
            managedObjectContext.deleteObject(managedObject)
            (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
        }
    }

//End Row Actions
    
//Start Nav Actions
    @IBAction func tapCall(sender: UIBarButtonItem) {
		if textField.text != "" {
			performSegueWithIdentifier("directCall", sender: self)
		} else { //either dial out or tell user to first give a number
			textField.becomeFirstResponder()
		}
    }

    @IBAction func tapPlus(sender: UIBarButtonItem) {
        if textField.text == "" {
            let picker = ABPeoplePickerNavigationController()
            picker.peoplePickerDelegate = self
            presentViewController(picker, animated: true, completion: nil)
        } else {
            performSegueWithIdentifier("nameOnly", sender: self)
            
        }
    }
//End Nav Actions
    
    
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
        performSegueWithIdentifier("showNumPicker", sender: self)
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
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }

    func contactFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Contacts")
        let sortDescriptor = NSSortDescriptor(key: "created", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
		fetchRequest.predicate = NSPredicate(format: "called = nil")
        return fetchRequest
    }
	
    func getFetchResultsController() -> NSFetchedResultsController {
        fetchedResultsController = NSFetchedResultsController(fetchRequest: contactFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }
    
}

