//
//  BaseDetailViewController.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/28/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit

class BaseDetailViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

	var spacerToBottom:NSLayoutConstraint!
	var userPic = UIImageView(frame: CGRectMake(20, 90, 50, 50))
	
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
		var memoLabel = UILabel(frame: CGRectMake(20, 264, 100, 32), text:"memo", color: UIColor.blackColor(), font: minorFont)
//		self.view.addSubview(memoLabel)
		
		//memo area
		var memoArea = UITextView(frame: CGRectMake(20, 291, 275, 225))
		memoArea.backgroundColor = majorColor
		memoArea.delegate = self
		self.view.addSubview(memoArea)
		
		var memoLine = customShadow(theself: self.view, frame: memoArea.frame)
		
		//Spacer View
		var spacer:UIView = UIView(frame: CGRectMake(84, 518, 160, 6))
		spacer.alpha = 0
		self.view.addSubview(spacer)

		//Constraints
		var memoAreaToSpacer:NSLayoutConstraint = NSLayoutConstraint(item: spacer, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: memoArea, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 8)
		spacerToBottom = NSLayoutConstraint(item: bottomLayoutGuide, attribute: NSLayoutAttribute.Top, relatedBy: .Equal, toItem: spacer, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
		view.addConstraint(memoAreaToSpacer)
		view.addConstraint(spacerToBottom)
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
}
