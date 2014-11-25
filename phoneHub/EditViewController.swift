//
//  EditViewController.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/2/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit
import CoreData

class EditViewController: UIViewController {
	@IBOutlet weak var nameField: UITextField!
	@IBOutlet weak var phoneLabel: UILabel!
	@IBOutlet weak var numField: UITextField!

	@IBOutlet weak var userPic: UIImageView!
	@IBOutlet weak var memoArea: UITextView!
	var contact: Contacts!
	
	let managedObjectContext:NSManagedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
	
	override func viewDidLoad() {
        super.viewDidLoad()
//		self.navigationItem.title = "qwer"

		memoArea.layer.borderColor = (UIColor.whiteColor()).CGColor
		memoArea.layer.borderWidth = 2
//		memoArea.textColor = UIColor.whiteColor()
//		memoArea.backgroundColor = UIColor(netHex: 0x274A95)
//		
		nameField.text = contact.name
//		nameField.textColor = UIColor.whiteColor()
		
		phoneLabel.text = contact.phoneType
		
		numField.text = contact.phone
//		numField.textColor = UIColor.whiteColor()
		
		memoArea.text = contact.memo
		userPic.image = UIImage(data: contact.photo)
    }

    @IBAction func tappedTryAgain(sender: UIBarButtonItem) {
		self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func tappedDone(sender: UIBarButtonItem) {
		contact.update(
			nameField.text,
			phone: numField.text!,
			phoneType: contact.phoneType,
			photo: contact.photo,
			memo: memoArea.text,
			status: contact.status
		)
		self.navigationController?.popToRootViewControllerAnimated(true)
		//uiview.animatewithduration
		//scrolll view content size
		//export icon to pdf, create image set, attributes inspector, convert bitmap to vector
    }
}
