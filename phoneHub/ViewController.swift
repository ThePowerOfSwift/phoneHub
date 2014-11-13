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
	
	var image: UIImage!
    var contact: ABMultiValueRef!
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
    
    var simpleEdit: Bool = false
    var actionRow: NSIndexPath!
    var action:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
		textField.delegate = self
        fetchedResultsController = getFetchResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
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
        if segue.identifier == "postCall" {
            let destVC: PostCallViewController = segue.destinationViewController as PostCallViewController
			let indexPath = tableView.indexPathForSelectedRow()
			let cell = fetchedResultsController.objectAtIndexPath(indexPath!) as Contacts
			destVC.nameL = cell.name
			destVC.phoneL = cell.phone
			destVC.memoL = cell.memo
        } else if segue.identifier == "showEdit" {
            textField.text = ""
            let destVC: EditViewController = segue.destinationViewController as EditViewController
        } else if segue.identifier == "showNumPicker" {
            let destVC: NumPickViewController = segue.destinationViewController as NumPickViewController
            destVC.contact = self.contact
			destVC.phoneDict = self.phoneDict
			destVC.image = self.image
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
//		cell.pic.image = theContact
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
            self.simpleEdit = true
            self.action = true
            self.actionRow = indexPath
            self.performSegueWithIdentifier("showEdit", sender: self)
            self.action = false
            }
        )
        editAction.backgroundColor = UIColor.greenColor()
        
        let deleteAction = UITableViewRowAction(style: .Normal, title: "delete", handler: {
            (action, indexPath) -> Void in
            self.tableView(self.tableView, commitEditingStyle: .Delete, forRowAtIndexPath: indexPath)
            }
        )
        deleteAction.backgroundColor = UIColor.redColor()
        
        let moreAction = UITableViewRowAction(style: .Normal, title: "more", handler: {
            (action, indexPath) -> Void in
            let actionSheetController: UIAlertController = UIAlertController(title: "More", message: "Extra Options--Now half off!", preferredStyle: .ActionSheet)
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
                //dismiss action sheet
                //doing nothing also makes it dismiss
            }
            actionSheetController.addAction(cancelAction)
            let blue: UIAlertAction = UIAlertAction(title: "Turn it blue", style: .Default) { action -> Void in
                //Turn the cell blue
                var cell: ContactCell = self.tableView.cellForRowAtIndexPath(indexPath) as ContactCell
                cell.backgroundColor = UIColor.blueColor()
            }
            actionSheetController.addAction(blue)
            let white: UIAlertAction = UIAlertAction(title: "Turn it white", style: .Default) { action -> Void in
                //Turn the cell white
                var cell: ContactCell = self.tableView.cellForRowAtIndexPath(indexPath) as ContactCell
                cell.backgroundColor = UIColor.whiteColor()
            }
            actionSheetController.addAction(white)
            //			//We need to provide a popover sourceView when using it on iPad
            //			actionSheetController.popoverPresentationController?.sourceView = tableView as UITableView;
			
            //Present the AlertController
            self.presentViewController(actionSheetController, animated: true, completion: nil)
        })
        moreAction.backgroundColor = UIColor.grayColor()
        //buttons get displayed in backwards order in app
        return [deleteAction, moreAction, editAction]
        
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
        performSegueWithIdentifier("buttonCall", sender: self)
    }

    @IBAction func tapPlus(sender: UIBarButtonItem) {
        if textField.text == "" {
            let picker = ABPeoplePickerNavigationController()
            picker.peoplePickerDelegate = self
            presentViewController(picker, animated: true, completion: nil)
        } else {
            performSegueWithIdentifier("plusWithTF", sender: self)
            
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
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    func getFetchResultsController() -> NSFetchedResultsController {
        fetchedResultsController = NSFetchedResultsController(fetchRequest: contactFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }
    
}

