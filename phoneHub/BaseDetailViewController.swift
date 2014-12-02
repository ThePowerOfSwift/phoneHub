//
//  BaseDetailViewController.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/28/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit

class BaseDetailViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

	var spacerToBottom: NSLayoutConstraint!
	
	var spacer: UIView = UIView()
	var memoLabel: UILabel!
	var memoArea: UITextView = UITextView()
	
	override func viewDidLoad() {

		self.view.setTranslatesAutoresizingMaskIntoConstraints(false)
		memoArea.setTranslatesAutoresizingMaskIntoConstraints(false)
		spacer.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		spacer.backgroundColor = UIColor.greenColor()
		self.view.addSubview(spacer)
		memoArea.backgroundColor = UIColor.redColor()
		memoArea.delegate = self
		self.view.addSubview(memoArea)
		self.view.backgroundColor = UIColor.grayColor()
		memoArea.addConstraint(NSLayoutConstraint(item: memoArea, attribute: .Width, relatedBy: .Equal,
			toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 275.0))
		memoArea.addConstraint(NSLayoutConstraint(item: memoArea, attribute: .Height, relatedBy: .Equal,
			toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 225.0))
		self.view.addConstraint(NSLayoutConstraint(item: memoArea, attribute: .Leading, relatedBy: .Equal,
			toItem: self.view, attribute: .Leading, multiplier: 1.0, constant: 20.0))

		spacer.addConstraint(NSLayoutConstraint(item: spacer, attribute: .Width, relatedBy: .Equal,
			toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 160.0))
		spacer.addConstraint(NSLayoutConstraint(item: spacer, attribute: .Height, relatedBy: .Equal,
			toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 6.0))
		self.view.addConstraint(NSLayoutConstraint(item: spacer, attribute: .Leading, relatedBy: .Equal,
			toItem: self.view, attribute: .Leading, multiplier: 1.0, constant: 84.0))

		var memoAreaToSpacer:NSLayoutConstraint = NSLayoutConstraint(item: spacer, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: memoArea, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 1)

		spacerToBottom = NSLayoutConstraint(item: bottomLayoutGuide, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: spacer, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 1)

		self.view.addConstraint(memoAreaToSpacer)
		self.view.addConstraint(spacerToBottom)

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
		spacerToBottom.constant = CGRectGetMaxY(view.bounds) - CGRectGetMinY(convertedKeyboardEndFrame) - height! - 5
		
		UIView.animateWithDuration(animationDuration, delay: 0.0, options: .BeginFromCurrentState | animationCurve, animations: {
			self.view.layoutIfNeeded()
			}, completion: nil)
	}
	
	
	// MARK: - UITextViewDelegate
	
	override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
		self.view.endEditing(true)
	}

	
/*
	var spacerToBottom:NSLayoutConstraint!
	var userPic = UIImageView()//frame: CGRectMake(20, 90, 50, 50))
	
    override func viewDidLoad() {
        super.viewDidLoad()
		//background
		self.view.backgroundColor = majorColor
		
		//profile pic style
		userPic.contentMode = .ScaleAspectFit
		userPic.layer.cornerRadius = userPic.frame.size.width / 2
		userPic.clipsToBounds = true
		userPic.layer.borderColor = UIColor.whiteColor().CGColor
		userPic.layer.borderWidth = 1
		
		//memo Label
		var memoLabel = UILabel()//frame: CGRectMake(20, 264, 100, 32), text:"memo", color: UIColor.blackColor(), font: minorFont)
//		self.view.addSubview(memoLabel)
		
		//memo area
		var memoArea = UITextView()//frame: CGRectMake(20, 291, 275, 225))
		memoArea.backgroundColor = majorColor
		memoArea.delegate = self
		self.view.addSubview(memoArea)
		
//		var memoLine = customShadow(theself: self.view, frame: memoArea.frame)
		
		//Spacer View
		var spacer:UIView = UIView()//frame: CGRectMake(84, 518, 160, 6))
		spacer.alpha = 0
		self.view.addSubview(spacer)

		//Constraints
		var memoAreaHeight:NSLayoutConstraint = NSLayoutConstraint(item: memoArea, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 225)
		self.view.addConstraint(memoAreaHeight)
		
		var memoAreaWidth:NSLayoutConstraint = NSLayoutConstraint(item: memoArea, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 275)
		self.view.addConstraint(memoAreaWidth)
		
		
		var memoAreaToSpacer:NSLayoutConstraint = NSLayoutConstraint(item: spacer, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: memoArea, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 8)
		view.addConstraint(memoAreaToSpacer)

		spacerToBottom = NSLayoutConstraint(item: bottomLayoutGuide, attribute: NSLayoutAttribute.Top, relatedBy: .Equal, toItem: spacer, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
		view.addConstraint(spacerToBottom)

		self.view.setTranslatesAutoresizingMaskIntoConstraints(false)
		memoArea.setTranslatesAutoresizingMaskIntoConstraints(false)
		spacer.setTranslatesAutoresizingMaskIntoConstraints(false)
		
	}
	
	
	
//Start--textfield-textview functionality block
	//mostly from http://effortlesscode.com/auto-layout-keyboard-shown-hidden/
	//Start toggle box colors
	func textFieldDidBeginEditing(textField: UITextField) {
		textField.backgroundColor = minorColor
	}
	
	func textFieldDidEndEditing(textField: UITextField) {
		textField.backgroundColor = majorColor
	}
	
	func textViewDidBeginEditing(textView: UITextView) {
		textView.backgroundColor = minorColor
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShowNotification:", name: UIKeyboardWillShowNotification, object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
	}
	
	func textViewDidEndEditing(textView: UITextView) {
		textView.backgroundColor = majorColor
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
		spacerToBottom.constant = CGRectGetMaxY(view.bounds) - CGRectGetMinY(convertedKeyboardEndFrame) - height! - 5
		
		UIView.animateWithDuration(animationDuration, delay: 0.0, options: .BeginFromCurrentState | animationCurve, animations: {
			self.view.layoutIfNeeded()
			}, completion: nil)
	}
	
	// MARK: - UITextViewDelegate
	
	override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
		self.view.endEditing(true)
	}
//End--textfield-textview functionality block
*/
}
