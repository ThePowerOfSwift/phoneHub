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

	@IBOutlet weak var image: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var phoneLabel: UILabel!
	@IBOutlet weak var phoneField: UITextField!
	@IBOutlet weak var memo: UITextView!
	let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
	let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
	var status:String = "unlabeled"
	var name: String!

	override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationItem.hidesBackButton = true
		self.view.backgroundColor = UIColor(netHex: 0x274A95)
		memo.layer.borderColor = (UIColor.whiteColor()).CGColor
		memo.layer.borderWidth = 2
		memo.backgroundColor = UIColor(netHex: 0x274A95)
		memo.textColor = UIColor.whiteColor()
		
		nameLabel.text = name
		nameLabel.textColor = UIColor.whiteColor()

		phoneLabel.textColor = UIColor.whiteColor()
		
		image.image = UIImage(named: "contact iconNew")?.imageWithColor(UIColor.whiteColor())
    }

	@IBAction func doneTapped(sender: UIBarButtonItem) {
		if phoneField.text != "" {
			let entityDescription = NSEntityDescription.entityForName("Contacts", inManagedObjectContext: managedObjectContext)
			let contact = Contacts(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
			
			contact.photo = UIImageJPEGRepresentation(image.image,1.0)
			contact.name = nameLabel.text!
			contact.memo = memo.text
			contact.phone = phoneField.text!
			contact.phoneType = "phone"
			contact.status = status
			contact.created = NSDate()
			appDelegate.saveContext()
		
			self.navigationController?.popToRootViewControllerAnimated(true)
		}
	}
	
	@IBAction func status(sender: UIButton) {
		status = sender.titleLabel!.text!
	}
	
}
