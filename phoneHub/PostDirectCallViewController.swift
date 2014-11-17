//
//  PostDirectCallViewController.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/13/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit
import CoreData

class PostDirectCallViewController: UIViewController {

	@IBOutlet weak var image: UIImageView!
	@IBOutlet weak var phoneLabel: UILabel!
	@IBOutlet weak var nameField: UITextField!
	@IBOutlet weak var memo: UITextView!
	let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)

	let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
	var status:String = "unlabeled"
	var number: String!
	override func viewDidLoad() {
        super.viewDidLoad()
		memo.layer.borderColor = (UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )).CGColor;
		memo.layer.borderWidth = 5

		phoneLabel.text = number
		image.image = UIImage(named: "152 - iPad")
		UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(cleaner(number))")!)
    }

	@IBAction func status(sender: UIButton) {
		status = sender.titleLabel!.text!
	}
	
	@IBAction func doneTapped(sender: UIBarButtonItem) {
		let entityDescription = NSEntityDescription.entityForName("Contacts", inManagedObjectContext: managedObjectContext)
		let contact = Contacts(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
		
		if nameField.text == "" {
			contact.name = phoneLabel.text!
		} else {
			contact.name = nameField.text
		}
		
		contact.photo = UIImageJPEGRepresentation(image.image,1.0)
		contact.memo = memo.text
		contact.phone = phoneLabel.text!
		contact.phoneType = "Phone"
		if status != "Call Back" {
			contact.status = status
			contact.called = NSDate()
		}
		else {
			contact.status = status
			contact.called = nil
		}
		appDelegate.saveContext()
		
		self.navigationController?.popToRootViewControllerAnimated(true)

	}
	func cleaner(phNum: String) -> String {
		var cleaned = phNum.stringByReplacingOccurrencesOfString("[\\(\\)\\-]", withString: "", options: .RegularExpressionSearch)
		var final: String = ""
		var count: Int = 0
		for char in cleaned {
			if String(char) == "1" || String(char) == "2" || String(char) == "3" || String(char) == "4" || String(char) == "5" || String(char) == "6" || String(char) == "7" || String(char) == "8" || String(char) == "8" || String(char) == "0" {
				final.append(char)
			}
			count++
		}
		return final
	}
}
