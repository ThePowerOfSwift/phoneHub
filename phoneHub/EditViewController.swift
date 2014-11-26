//
//  EditViewController.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/2/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit
import CoreData

class EditViewController: UIViewController, UITextViewDelegate {
	@IBOutlet weak var nameField: UITextField!
	@IBOutlet weak var phoneLabel: UILabel!
	@IBOutlet weak var numField: UITextField!

	@IBOutlet weak var userPic: UIImageView!
	@IBOutlet weak var memoArea: UITextView!
	var contact: Contacts!
	
	@IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
	
	let managedObjectContext:NSManagedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationItem.title = "Edit"

		memoArea.layer.borderColor = (UIColor.whiteColor()).CGColor
		memoArea.layer.borderWidth = 2
		nameField.text = contact.name
		phoneLabel.text = contact.phoneType
		numField.text = contact.phone
		memoArea.text = contact.memo
		userPic.image = UIImage(data: contact.photo)
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
	
	// MARK: - Lifecycle
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
	}
	
	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)
		NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
		NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
	}
	
	// MARK: - Notifications
	
	func keyboardWillShowNotification(notification: NSNotification) {
		updateBottomLayoutConstraintWithNotification(notification)
//		self.navigationController?.navigationBar.hidden = true
	}
	
	func keyboardWillHideNotification(notification: NSNotification) {
		updateBottomLayoutConstraintWithNotification(notification)
//		self.navigationController?.navigationBar.hidden = false
	}
	
	
	// MARK: - Private
	
	func updateBottomLayoutConstraintWithNotification(notification: NSNotification) {
		let userInfo = notification.userInfo!
		
		let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as NSNumber).doubleValue
		let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
		let convertedKeyboardEndFrame = view.convertRect(keyboardEndFrame, fromView: view.window)
		let rawAnimationCurve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as NSNumber).unsignedIntValue << 16
		let animationCurve = UIViewAnimationOptions.init(UInt(rawAnimationCurve))
		
		bottomLayoutConstraint.constant = CGRectGetMaxY(view.bounds) - CGRectGetMinY(convertedKeyboardEndFrame)
		
		UIView.animateWithDuration(animationDuration, delay: 0.0, options: .BeginFromCurrentState | animationCurve, animations: {
			self.view.layoutIfNeeded()
			}, completion: nil)
	}
	
	
	// MARK: - UITextViewDelegate
	
	func textViewShouldReturn(textView: UITextView) -> Bool {
		textView.resignFirstResponder()
		return true
	}
	override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
		self.view.endEditing(true)
	}
	
}
