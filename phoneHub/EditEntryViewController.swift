//
//  EditEntryViewController.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/24/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit

class EditEntryViewController: BaseCallerViewController {

	var nameLabel:UILabel!
	var nameField:UITextField!
	var phoneLabel:UILabel!
	var phoneField:UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//nameLabel
		nameLabel = UILabel(frame: CGRectMake(140, 70, 150, 50))
		nameLabel.text = contact.name
		nameLabel.textColor = UIColor.whiteColor()
		//phoneLabel
		phoneLabel = UILabel(frame: CGRectMake(140, 120, 150, 50))
		phoneLabel.text = contact.phone
		phoneLabel.textColor = UIColor.whiteColor()
		//addSubview
		self.view.addSubview(nameLabel)
		self.view.addSubview(phoneLabel)
		
		self.view.backgroundColor = UIColor(netHex: 0x274A95)
		
		//done Bar Button
		doneBButton = UIBarButtonItem(title: "Done", style: .Bordered, target: self, action: "doneTapped:")
		self.navigationItem.rightBarButtonItem = doneBButton
		
		//need to redo frame definitions
		//image
		image = UIImageView(frame: CGRectMake(20, 60, 100,100))
		image.image = UIImage(data: contact.photo)
		image.backgroundColor = UIColor.greenColor()

		//status buttons
		
		//complete
		completeButton = UIButton(frame: CGRectMake(20, 190, 150, 75))
		completeButton.setTitle("Complete", forState: UIControlState.Normal)
		completeButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
		completeButton.addTarget(self, action: "status:", forControlEvents: UIControlEvents.TouchUpInside)
		
		//call button
		callBackButton = UIButton(frame: CGRectMake(20, 250, 150, 75))
		callBackButton.setTitle("Call Back", forState: UIControlState.Normal)
		callBackButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
		callBackButton.addTarget(self, action: "status:", forControlEvents: UIControlEvents.TouchUpInside)
		
		//leftMessageButton
		leftMessageButton = UIButton(frame: CGRectMake(170, 190, 150, 75))
		leftMessageButton.setTitle("Left Message", forState: UIControlState.Normal)
		leftMessageButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
		leftMessageButton.addTarget(self, action: "status:", forControlEvents: UIControlEvents.TouchUpInside)
		
		//textedInsteadButton
		textedInsteadButton = UIButton(frame: CGRectMake(170, 250, 150, 75))
		textedInsteadButton.setTitle("Texted Instead", forState: UIControlState.Normal)
		textedInsteadButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
		textedInsteadButton.addTarget(self, action: "status:", forControlEvents: UIControlEvents.TouchUpInside)
		
		//memoLabel
		memoLabel = UILabel(frame: CGRectMake(20, 325, 150, 25))
		memoLabel.text = "Memo"
		
		//memo TextView
		memoArea = UITextView(frame: CGRectMake(20, 325, 275, 175))
		memoArea.layer.borderColor = (UIColor.whiteColor()).CGColor;
		memoArea.layer.borderWidth = 2
		memoArea.backgroundColor = UIColor(netHex: 0x274A95)
		
		//set label color
		completeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		callBackButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		leftMessageButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		textedInsteadButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
		
		completeButton.setTitleColor(UIColor(netHex: 0x274A95), forState: .Selected)
		callBackButton.setTitleColor(UIColor(netHex: 0x274A95), forState: .Selected)
		leftMessageButton.setTitleColor(UIColor(netHex: 0x274A95), forState: .Selected)
		textedInsteadButton.setTitleColor(UIColor(netHex: 0x274A95), forState: .Selected)
		
		
		memoLabel.textColor = UIColor.whiteColor()
		memoArea.textColor = UIColor.whiteColor()
		
		//addSubview
		self.view.addSubview(image)
		self.view.addSubview(memoLabel)
		self.view.addSubview(memoArea)
		
		//dial out
		//		UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(cleaner(contact.phone))")!)
//		contact.called = NSDate()

		
		
	}
	
}
