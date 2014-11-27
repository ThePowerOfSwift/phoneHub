//
//  NameOnlyViewController.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/13/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit
import CoreData

class NameOnlyViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

	@IBOutlet weak var image: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var phoneLabel: UILabel!
	@IBOutlet weak var phoneField: UITextField!
	@IBOutlet weak var memo: UITextView!
	@IBOutlet weak var bottomLayoutConstraint:NSLayoutConstraint!
	
	let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
	let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
	var status:String = "unlabeled"
	var name: String!
	var phoneLine:customShadow!
	var memoLine:customShadow!
	
	let profilePic = UIImage(named: "profpicPDFWhite")
	override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor(netHex: 0xE5C49A)
		
		memo.backgroundColor = UIColor(netHex: 0xE5C49A)
		memo.delegate = self
		memoLine = customShadow(theself:self.view, frame: memo.frame)
		
		nameLabel.text = name
		phoneField.delegate = self
		phoneLine = customShadow(theself:self.view, frame: phoneField.frame)
		
		image.image = UIImage(data: UIImagePNGRepresentation(profilePic))
		image.contentMode = .ScaleAspectFit
		image.layer.cornerRadius = image.frame.size.width / 2
		image.clipsToBounds = true
		image.layer.borderColor = UIColor.whiteColor().CGColor
		image.layer.borderWidth = 1

    }
	
	//Start toggle box colors
	func textFieldDidBeginEditing(textField: UITextField) {
		textField.backgroundColor = UIColor(netHex: 0xD7D7CF)
	}
	
	func textFieldDidEndEditing(textField: UITextField) {
		textField.backgroundColor = UIColor(netHex: 0xE5C49A)
	}
	
	func textViewDidBeginEditing(textView: UITextView) {
		
		textView.backgroundColor = UIColor(netHex: 0xD7D7CF)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
	}
	
	func textViewDidEndEditing(textView: UITextView) {
		textView.backgroundColor = UIColor(netHex: 0xE5C49A)
		NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
		NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
	}
	//End toggle box colors
	
	// MARK: - Notifications
	
	func keyboardWillShowNotification(notification: NSNotification) {
		updateBottomLayoutConstraintWithNotification(notification)
	}
	
	func keyboardWillHideNotification(notification: NSNotification) {
		updateBottomLayoutConstraintWithNotification(notification)
	}
	
	// MARK: - Private
	
	func updateBottomLayoutConstraintWithNotification(notification: NSNotification) {
		let userInfo = notification.userInfo!
		
		let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as NSNumber).doubleValue
		let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
		let convertedKeyboardEndFrame = view.convertRect(keyboardEndFrame, fromView: view.window)
		let rawAnimationCurve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as NSNumber).unsignedIntValue << 16
		let animationCurve = UIViewAnimationOptions.init(UInt(rawAnimationCurve))
		
		
		let frame = self.tabBarController?.tabBar.frame
		let height = frame?.size.height
		bottomLayoutConstraint.constant = CGRectGetMaxY(view.bounds) - CGRectGetMinY(convertedKeyboardEndFrame) - height! - 5
		
		UIView.animateWithDuration(animationDuration, delay: 0.0, options: .BeginFromCurrentState | animationCurve, animations: {
			self.view.layoutIfNeeded()
			}, completion: nil)
	}
	
	
	// MARK: - UITextViewDelegate
	
	override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
		self.view.endEditing(true)
	}

	@IBAction func doneTapped(sender: UIBarButtonItem) {
		if phoneField.text != "" {
			let entityDescription = NSEntityDescription.entityForName("Contacts", inManagedObjectContext: managedObjectContext)
			let contact = Contacts(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
			
			contact.photo = UIImagePNGRepresentation(image.image)
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
}
