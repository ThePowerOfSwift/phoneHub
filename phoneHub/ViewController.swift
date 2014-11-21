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

class ViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
	
	var textFieldValue:String!
	var editRow:NSIndexPath!
	var tblView =  UIView(frame: CGRectZero)

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

	override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {//nsnotification enter
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
        } else if segue.identifier == "directCall" {
			let vc: PostDirectCallViewController = segue.destinationViewController as PostDirectCallViewController
			vc.number = textFieldValue
		} else if segue.identifier == "nameOnly" {
			let vc: NameOnlyViewController = segue.destinationViewController as NameOnlyViewController
//			println("insegue: \(textField.text)")
//			println("insegue: \(textFieldValue)")
			vc.name = textFieldValue
		} else if segue.identifier == "showAB" {
			let vc: ABNavController = segue.destinationViewController as ABNavController
		}

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
			textFieldValue = textField.text
			performSegueWithIdentifier("directCall", sender: self)
		} else { //either dial out or tell user to first give a number
//			performSegueWithIdentifier("showAB", sender: self)
			textField.becomeFirstResponder()
		}
    }

    @IBAction func tapPlus(sender: UIBarButtonItem) {
        if textField.text == "" {
			let picker = ABNavController()
			picker.peoplePickerDelegate = picker
			presentViewController(picker, animated: true, completion: nil)
		} else {
			textFieldValue = textField.text
			performSegueWithIdentifier("nameOnly", sender: self)
        }
    }
//End Nav Actions
    
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

