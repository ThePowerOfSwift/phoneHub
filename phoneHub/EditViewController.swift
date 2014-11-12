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
	var nameF:String = ""
	var phoneL:String = ""
	var numF:String = ""
	var image: UIImage!
	@IBOutlet weak var nameField: UITextField!
	@IBOutlet weak var phoneLabel: UILabel!
	@IBOutlet weak var numField: UITextField!
	
	@IBOutlet weak var userPic: UIImageView!
	@IBOutlet weak var memoArea: UITextView!
	let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
	
	let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
		nameField.text = nameF
		phoneLabel.text = phoneL
		numField.text = numF
		memoArea.text = "asfsafd"
		userPic.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func tappedTryAgain(sender: UIBarButtonItem) {
//        make sure button label is dependent on segue source
		self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func tappedDone(sender: UIBarButtonItem) {
        //save data
		let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
		
		let entityDescription = NSEntityDescription.entityForName("Contacts", inManagedObjectContext: managedObjectContext!)
		let newEntry = Contacts(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)

		newEntry.name = nameField.text
		newEntry.phone = numField.text
		newEntry.memo = memoArea.text

		appDelegate.saveContext()
		
		
		
		self.navigationController?.popToRootViewControllerAnimated(true)
    }

}
