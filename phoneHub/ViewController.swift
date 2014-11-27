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
import QuartzCore

class ViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
	
	var textFieldValue:String!
	var cell: ContactCell!
	var selected: Entry!
	var targetRow: NSIndexPath!
	let tblView =  UIView(frame: CGRectZero)
	let colors = Colors(top: UIColor(netHex: 0xD7D7CF), bot: UIColor(netHex: 0xE5C49A))
	let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		textField.delegate = self

        fetchedResultsController = getFetchResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
	
		// set selected and unselected icons
		var item:UITabBarItem = self.tabBarController?.tabBar.items?[0] as UITabBarItem
		item.image = UIImage(named: "contact iconNew")?.imageWithRenderingMode(.AlwaysOriginal)
		var item1:UITabBarItem = self.tabBarController?.tabBar.items?[1] as UITabBarItem
		item1.image = UIImage(named: "folderNew")?.imageWithRenderingMode(.AlwaysOriginal)

		for item in self.tabBarController?.tabBar.items as [UITabBarItem] {
			if let image = item.image {
				item.image = image.imageWithColor(UIColor(netHex: 0x21ACBB)).imageWithRenderingMode(.AlwaysOriginal)
			}
		}
		refresh()
    }
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		tableView.tableFooterView = tblView
		tableView.backgroundColor = UIColor(netHex: 0xE5C49A)
	}
	
	func refresh() {
		tableView.backgroundColor = UIColor.clearColor()
		var backgroundLayer = colors.gl
		backgroundLayer.frame = tableView.frame
		tableView.layer.insertSublayer(backgroundLayer, atIndex: 0)
	}

	func textFieldShouldReturn(textField: UITextField!) -> Bool {
		textField.resignFirstResponder()
		return true
	}

	override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
		self.view.endEditing(true)
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		textField.text = ""
		if segue.identifier == "postCall" {
            let vc: PostCallViewController = segue.destinationViewController as PostCallViewController
			let indexPath = tableView.indexPathForSelectedRow()
		} else if segue.identifier == "showEdit" {
			let theContact = fetchedResultsController.objectAtIndexPath(targetRow!) as Contacts
			let vc: EditViewController = segue.destinationViewController as EditViewController
			vc.contact = theContact
		} else if segue.identifier == "edit" {
			let theContact = fetchedResultsController.objectAtIndexPath(targetRow!) as Contacts
			let vc: EditEntryViewController = segue.destinationViewController as EditEntryViewController
			vc.contact = theContact
		} else if segue.identifier == "directCall" {
			let vc: PostDirectCallViewController = segue.destinationViewController as PostDirectCallViewController
			vc.number = textFieldValue
		} else if segue.identifier == "nameOnly" {
			let vc: NameOnlyViewController = segue.destinationViewController as NameOnlyViewController
			vc.name = textFieldValue
		} else if segue.identifier == "showAB" {
			let vc: ABNavController = segue.destinationViewController as ABNavController
		} else if segue.identifier == "tapToCall" {
			var targetRow = self.tableView.indexPathForSelectedRow()
			let theContact = fetchedResultsController.objectAtIndexPath(targetRow!) as Contacts
			let vc:TapCallViewController = segue.destinationViewController as TapCallViewController
			vc.contact = theContact
		}
    }

//Start Table
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let numberOfSections = fetchedResultsController.sections?.count
        return numberOfSections!
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInSection = fetchedResultsController.sections![section].numberOfObjects
		if numberOfRowsInSection > 0 {
			self.navigationController?.tabBarItem.badgeValue = "\(numberOfRowsInSection)";
		}
		if numberOfRowsInSection == 0 {
			self.navigationController?.tabBarItem.badgeValue = nil;
		}

        return numberOfRowsInSection!
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let theContact = fetchedResultsController.objectAtIndexPath(indexPath) as Contacts
        cell = tableView.dequeueReusableCellWithIdentifier("listCell") as ContactCell
		
		cell.load(
			theContact.name,
			phoneType:theContact.phoneType,
			memo: theContact.memo,
			pic: UIImage(data: theContact.photo)!,
			phone: theContact.phone,
			status: theContact.status,
			created: theContact.created
		)
		cell.pic.image = UIImage(data: theContact.photo)
		cell.pic.contentMode = .ScaleAspectFit
		cell.pic.layer.cornerRadius = cell.pic.frame.size.width / 2
		cell.pic.clipsToBounds = true
		cell.pic.layer.borderColor = UIColor.whiteColor().CGColor
		cell.pic.layer.borderWidth = 1
		
		if indexPath.row % 2 == 0{
			cell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.35)
			cell.accessoryType = .None
		} else {
			cell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.65)
			cell.accessoryType = .None
		}
		
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
			self.targetRow = indexPath
            self.performSegueWithIdentifier("showEdit", sender: self)
            }
        )
        editAction.backgroundColor = UIColor(netHex: 0xF5A623)
        
        let deleteAction = UITableViewRowAction(style: .Normal, title: "delete", handler: {
            (action, indexPath) -> Void in
            self.tableView(self.tableView, commitEditingStyle: .Delete, forRowAtIndexPath: indexPath)
            }
        )
        deleteAction.backgroundColor = UIColor(netHex: 0xC7262A)
		
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

