//
//  EditViewController.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/2/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit
import CoreData
import QuartzCore

class EditViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
	@IBOutlet weak var nameField: UITextField!
	@IBOutlet weak var phoneLabel: UILabel!
	@IBOutlet weak var numField: UITextField!

	@IBOutlet weak var userPic: UIImageView!
	@IBOutlet weak var memoArea: UITextView!
	var contact: Contacts!
	let colors = Colors(top: UIColor.whiteColor(), bot: UIColor.grayColor())
	@IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
	
	let managedObjectContext:NSManagedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationItem.title = "Edit"
		self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
//		memoArea.layer.borderColor = (UIColor.whiteColor()).CGColor
//		memoArea.layer.borderWidth = 2
		
		nameField.text = contact.name
		nameField.backgroundColor = UIColor(netHex: 0xE5C49A)
		nameField.delegate = self
//		nameField.layer.shadowOpacity = 1.0;
//		nameField.layer.shadowRadius = 0.0;
//		nameField.layer.shadowColor = UIColor.blueColor().CGColor;
//		nameField.layer.shadowOffset = CGSizeMake(-1.0, 1.0);
		
		phoneLabel.text = contact.phoneType

		numField.text = contact.phone
		numField.backgroundColor = UIColor(netHex: 0xE5C49A)
		numField.delegate = self
		memoArea.text = contact.memo
		memoArea.backgroundColor = UIColor(netHex: 0xE5C49A)
		memoArea.delegate = self

		userPic.image = UIImage(data: contact.photo)
		userPic.contentMode = .ScaleAspectFit
		userPic.layer.cornerRadius = userPic.frame.size.width / 2
		userPic.clipsToBounds = true
		userPic.layer.borderColor = UIColor.whiteColor().CGColor
		userPic.layer.borderWidth = 1
	
		view.backgroundColor = UIColor(netHex: 0xE5C49A)
//		refresh()
	}
	//UIColor(netHex: 0xE5C49A) is beige
	//UIColor(netHex: 0xD7D7CF) is gray
	func refresh() {
		view.backgroundColor = UIColor.clearColor()
		var backgroundLayer = colors.gl
		backgroundLayer.frame = view.frame
		view.layer.insertSublayer(backgroundLayer, atIndex: 0)
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
    }
	
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
		
//		for some reason i have to break it up like above. sticking them together is gives a compile-time error bottomLayoutConstraint.constant = CGRectGetMaxY(view.bounds) - CGRectGetMinY(convertedKeyboardEndFrame) - self.tabBarController?.tabBar.frame.size.height
		
		
		UIView.animateWithDuration(animationDuration, delay: 0.0, options: .BeginFromCurrentState | animationCurve, animations: {
			self.view.layoutIfNeeded()
			}, completion: nil)
	}
	
	
	// MARK: - UITextViewDelegate
	
	override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
		self.view.endEditing(true)
	}
	
}
