//
//  BaseCallerViewController.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/21/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit
import CoreData
import MapKit
import CoreLocation

class BaseCallerViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
	
	var memoLabel:UILabel!
	var memoArea:UITextView!
	var image = UIImageView()
	var map: MKMapView!
	var spacerView:UIView!
	var doneBButton:UIBarButtonItem!
	
	var completeButton:UIButton!
	var callBackButton:UIButton!
	var leftMessageButton:UIButton!
	var textedInsteadButton:UIButton!
	
	let locationManager = CLLocationManager()
	var contact: Contacts!
	
    override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationItem.title = "After Call"
		self.view.backgroundColor = UIColor(netHex: 0xE5C49A)
		self.navigationItem.hidesBackButton = true
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()

		//dial out
//		UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(cleaner(contact.phone))")!)
		contact.called = NSDate()

		//done Bar Button
		doneBButton = UIBarButtonItem(title: "Done", style: .Bordered, target: self, action: "doneTapped:")
		self.navigationItem.rightBarButtonItem = doneBButton
		
		//need to redo frame definitions
		//image
		image = UIImageView(frame: CGRectMake(20, 80, 100,100))
		image.image = UIImage(data: contact.photo)
		image.contentMode = .ScaleAspectFit
		image.layer.cornerRadius = image.frame.size.width / 2
		image.clipsToBounds = true
		image.layer.borderColor = UIColor.whiteColor().CGColor
		image.layer.borderWidth = 1
		
		//map
		map = MKMapView(frame: CGRectMake(20, 190, 255, 175))
		
		//status buttons
		
		//complete
		completeButton = UIButton(frame: CGRectMake(10, 190, 150, 75))
		completeButton.setTitle("Complete", forState: UIControlState.Normal)
		completeButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
		completeButton.addTarget(self, action: "status:", forControlEvents: UIControlEvents.TouchUpInside)
		
		//call button
		callBackButton = UIButton(frame: CGRectMake(10, 250, 150, 75))
		callBackButton.setTitle("Call Back", forState: UIControlState.Normal)
		callBackButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
		callBackButton.addTarget(self, action: "status:", forControlEvents: UIControlEvents.TouchUpInside)
		
		//leftMessageButton
		leftMessageButton = UIButton(frame: CGRectMake(160, 190, 150, 75))
		leftMessageButton.setTitle("Left Message", forState: UIControlState.Normal)
		leftMessageButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
		leftMessageButton.addTarget(self, action: "status:", forControlEvents: UIControlEvents.TouchUpInside)

		//textedInsteadButton
		textedInsteadButton = UIButton(frame: CGRectMake(160, 250, 150, 75))
		textedInsteadButton.setTitle("Texted Instead", forState: UIControlState.Normal)
		textedInsteadButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
		textedInsteadButton.addTarget(self, action: "status:", forControlEvents: UIControlEvents.TouchUpInside)

		//memoLabel
		memoLabel = UILabel(frame: CGRectMake(20, 325, 150, 25))
		memoLabel.text = "Memo"
		
		//memo TextView
		memoArea = UITextView(frame: CGRectMake(20, 325, 275, 175))
		memoArea.backgroundColor = UIColor(netHex: 0xE5C49A)

		
		memoLabel.textColor = UIColor.whiteColor()
		memoArea.textColor = UIColor.whiteColor()
		
		memoArea.text = contact.memo
		//addSubview
		self.view.addSubview(image)
//		self.view.addSubview(map)
		self.view.addSubview(memoLabel)
		self.view.addSubview(memoArea)

//////Constraints
		
		spacerView = UIView(frame: CGRectMake(84, 518, 160, 6))
		spacerView.alpha = 0
		var spacertoview = NSLayoutConstraint(item: spacerView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: memoArea, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 8)
		view.addConstraint(spacertoview)
		
		
		
		
		
		
		
//////
	}
	
	func status(sender: UIButton) {
		completeButton.backgroundColor = UIColor(netHex: 0xE5C49A)
		callBackButton.backgroundColor = UIColor(netHex: 0xE5C49A)
		leftMessageButton.backgroundColor = UIColor(netHex: 0xE5C49A)
		textedInsteadButton.backgroundColor = UIColor(netHex: 0xE5C49A)
		completeButton.selected = false
		callBackButton.selected = false
		leftMessageButton.selected = false
		textedInsteadButton.selected = false
		
		contact.status = sender.titleLabel!.text!
		sender.backgroundColor = UIColor(netHex: 0xD7D7CF)
		sender.selected = true
	}

	func doneTapped(sender: UIBarButtonItem) {
		//add conditional to do nothing if no status is selected
		if contact.status == "Call Back" || contact.status == "Complete" || contact.status == "Left Message" || contact.status == "Texted Instead"{
			if contact.status == "Call Back" {
				contact.update(
					contact.name,
					phone: contact.phone,
					phoneType: contact.phoneType,
					photo: contact.photo,
					memo: memoArea.text,
					status: "reCall"
				)
				
			} else {
				contact.update(
					contact.name,
					phone: contact.phone,
					phoneType: contact.phoneType,
					photo: contact.photo,
					memo: memoArea.text,
					status: contact.status,
					called: contact.called!,
					latitude: contact.latitude!,
					longitude: contact.longitude!
				)
			}
			self.navigationController?.popToRootViewControllerAnimated(true)
		}
	}
	
	func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
		locationManager.stopUpdatingLocation()

		contact.latitude = manager.location.coordinate.latitude
		contact.longitude = manager.location.coordinate.longitude
		
		let latitude:CLLocationDegrees = CLLocationDegrees(contact.latitude!)
		let longitude:CLLocationDegrees = CLLocationDegrees(contact.longitude!)
		loadMap(latitude, long: longitude, map: map)
	}

	func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
		println("Error: " + error.localizedDescription)
	}

	func loadMap(lat: CLLocationDegrees, long: CLLocationDegrees, map: MKMapView){
		let latDelta:CLLocationDegrees = 0.01
		let longDelta:CLLocationDegrees = 0.01
		
		var theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
		var locationOfInterest:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
		var region:MKCoordinateRegion = MKCoordinateRegionMake(locationOfInterest, theSpan)
		
		map.setRegion(region, animated: true)
		
		var thePin = MKPointAnnotation()
		thePin.coordinate = locationOfInterest
		map.addAnnotation(thePin)
	}


	
	func cleaner(phNum: String) -> String {
		var cleaned = phNum.stringByReplacingOccurrencesOfString("[\\(\\)]", withString: "", options: .RegularExpressionSearch)
		var final: String = ""
		var count: Int = 0
		for char in cleaned {
			if String(char) == "1" || String(char) == "2" || String(char) == "3" || String(char) == "4" || String(char) == "5" || String(char) == "6" || String(char) == "7" || String(char) == "8" || String(char) == "8" || String(char) == "0"{
				final.append(char)
			} else if String(char) == "+" {final.append(char)}
			count++
		}
		return final
	}

}
