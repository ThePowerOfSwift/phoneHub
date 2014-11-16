//
//  PostCallViewController.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/2/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class PostCallViewController: UIViewController, CLLocationManagerDelegate {

	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var phoneLabel: UILabel!
	@IBOutlet weak var memo: UITextView!
	@IBOutlet weak var image: UIImageView!
	
	let locationManager = CLLocationManager()
	var status:String = "unlabeled"
	var contact: Contacts!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationItem.hidesBackButton = true
		nameLabel.text = contact.name
		phoneLabel.text = contact.phone
		memo.text = contact.memo
		image.image = UIImage(data: contact.photo)
		//dial out
//		println("dialing\ngot:\(contact.phone)\nnow:\(cleaner(contact.phone))")
		UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(cleaner(contact.phone))")!)
		contact.called = NSDate()
	}
	
	@IBAction func status(sender: UIButton) {
		status = sender.titleLabel!.text!
	}
	
	@IBAction func doneTapped(sender: UIBarButtonItem) {
		let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
		contact.photo = UIImageJPEGRepresentation(image.image,1.0)
		contact.name = nameLabel.text!
		contact.phone = phoneLabel.text!
		contact.memo = memo.text
		if status != "Button1" {contact.status = status}
		else {contact.called = nil}
		appDelegate.saveContext()
		self.navigationController?.popToRootViewControllerAnimated(true)
	}
	
	// this is such a crappy function :(
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
