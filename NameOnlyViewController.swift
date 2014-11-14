//
//  NameOnlyViewController.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/13/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit
import CoreData

class NameOnlyViewController: UIViewController {

	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var phoneField: UITextField!
	@IBOutlet weak var memo: UITextView!
	let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
	let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
	var status:String = "unlabeled"
	var name: String!

	override func viewDidLoad() {
        super.viewDidLoad()
		nameLabel.text = name
    }

	@IBAction func doneTapped(sender: UIBarButtonItem) {
		if phoneField.text != "" {
			let entityDescription = NSEntityDescription.entityForName("Contacts", inManagedObjectContext: managedObjectContext)
			let contact = Contacts(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
		
			contact.name = nameLabel.text!
			contact.memo = memo.text
			contact.phone = phoneField.text!
			contact.status = status
			appDelegate.saveContext()
		
			self.navigationController?.popToRootViewControllerAnimated(true)
		}
	}
	
	@IBAction func status(sender: UIButton) {
		status = sender.titleLabel!.text!
	}
	
}
