//
//  ArchiveViewController.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/14/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit
import CoreData
import QuartzCore

class ArchiveViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate  {

	let colors = Colors()
	var tblView =  UIView(frame: CGRectZero)
	let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
	var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		fetchedResultsController = getFetchResultsController()
		fetchedResultsController.delegate = self
		fetchedResultsController.performFetch(nil)

		refresh()
    }
	func refresh() {
		tableView.backgroundColor = UIColor.clearColor()
		var backgroundLayer = colors.gl
		backgroundLayer.frame = tableView.frame
		tableView.layer.insertSublayer(backgroundLayer, atIndex: 0)
	}
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		tableView.tableFooterView = tblView
		tableView.backgroundColor = UIColor(netHex: 0x274A95)
	}

	func controllerDidChangeContent(controller: NSFetchedResultsController) {
		tableView.reloadData()
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "showLog" {
			let vc: ArchiveDetailViewController = segue.destinationViewController as ArchiveDetailViewController
			let indexPath = tableView.indexPathForSelectedRow()
			var Acell = fetchedResultsController.objectAtIndexPath(indexPath!) as Contacts
			vc.ArchCell = Acell
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
		var cell: ContactCell = tableView.dequeueReusableCellWithIdentifier("archCell") as ContactCell
		cell.nameLabel.text = theContact.name
		cell.memoLabel.text = theContact.memo
		cell.phoneType.text = theContact.phoneType
		cell.pic.image = UIImage(data: theContact.photo)
		cell.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
		cell.accessoryType = .None
		return cell
	}
//End Table

//Start Row Actions
	override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		return true
	}
	
	override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
		let addAction = UITableViewRowAction(style: .Normal, title: "add", handler: {
			(action, indexPath) -> Void in
			let theContact:Contacts = self.fetchedResultsController.objectAtIndexPath(indexPath) as Contacts
			theContact.called = nil
			}
		)
		addAction.backgroundColor = UIColor(netHex: 0xF5A623)
		
		let deleteAction = UITableViewRowAction(style: .Normal, title: "delete", handler: {
			(action, indexPath) -> Void in
			self.tableView(self.tableView, commitEditingStyle: .Delete, forRowAtIndexPath: indexPath)
			}
		)
		deleteAction.backgroundColor = UIColor(netHex: 0xC7262A)
		
		return [deleteAction, addAction]
		
	}
	
	override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		if editingStyle == UITableViewCellEditingStyle.Delete {
			let managedObject: NSManagedObject = fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject
			managedObjectContext.deleteObject(managedObject)
			(UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
		}
	}
	
//End Row Actions
	func contactFetchRequest() -> NSFetchRequest {
		let fetchRequest = NSFetchRequest(entityName: "Contacts")
		let sortDescriptor = NSSortDescriptor(key: "called", ascending: false)
		fetchRequest.sortDescriptors = [sortDescriptor]
		fetchRequest.predicate = NSPredicate(format: "called != nil")
		return fetchRequest
	}
	
	func getFetchResultsController() -> NSFetchedResultsController {
		fetchedResultsController = NSFetchedResultsController(fetchRequest: contactFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
		return fetchedResultsController
	}
	
}
