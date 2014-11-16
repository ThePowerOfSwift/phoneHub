//
//  EditViewController.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/2/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

/*
added the `?` in `prepareforsegue` as well as in the  `editcontroller`. the previous compile errors go away but instead there is 1 new compile error and 1 new runtime bug. First, In the edit controller, `userPic.image = UIImage(data: img)` gets the same nil on optional error. Second, at run-time the data isn't actually passed between the controllers. it just stores a nil value, which explains the appreance of the original bug. what do i need to do to assign values to individual attributes in this object? thanks for your help @HAS
*/
import UIKit
import CoreData

class EditViewController: UIViewController {
	@IBOutlet weak var nameField: UITextField!
	@IBOutlet weak var phoneLabel: UILabel!
	@IBOutlet weak var numField: UITextField!

	@IBOutlet weak var userPic: UIImageView!
	@IBOutlet weak var memoArea: UITextView!
	
	var img:NSData!
	var contact: Contacts!
	let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
	
	let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
		
		memoArea.layer.borderColor = (UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )).CGColor;
		memoArea.layer.borderWidth = 5
		nameField.text = contact?.name
		phoneLabel.text = contact?.phoneType
		numField.text = contact?.phone
		memoArea.text = contact?.memo
		img = contact?.photo
//		userPic.image = UIImage(data: img)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func tappedTryAgain(sender: UIBarButtonItem) {
//        make sure button label is dependent on segue source
		self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func tappedDone(sender: UIBarButtonItem) {

		let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
		let entityDescription = NSEntityDescription.entityForName("Contacts", inManagedObjectContext: managedObjectContext!)
		let newEntry = Contacts(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)

		newEntry.name = nameField.text
		newEntry.phoneType = phoneLabel.text!
		newEntry.phone = numField.text
		newEntry.memo = memoArea.text
		newEntry.created = NSDate()
		newEntry.photo = contact.photo
		appDelegate.saveContext()
		self.navigationController?.popToRootViewControllerAnimated(true)
    }

}
