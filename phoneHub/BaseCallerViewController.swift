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
	
	var doneBButton:UIBarButtonItem!
	
	var completeButton:UIButton!
	var callBackButton:UIButton!
	var leftMessageButton:UIButton!
	var textedInsteadButton:UIButton!
	
	let locationManager = CLLocationManager()
//	var status:String = "unlabeled"
	var contact: Contacts!
	
    override func viewDidLoad() {
		super.viewDidLoad()
//		self.view.backgroundColor = UIColor.blueColor()
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
		
		//done Bar Button
		doneBButton = UIBarButtonItem(title: "Done", style: .Bordered, target: self, action: "doneTapped:")
		self.navigationItem.rightBarButtonItem = doneBButton
		
		//need to redo frame definitions
		//image
		image = UIImageView(frame: CGRectMake(20, 60, 100,100))
		image.image = UIImage(data: contact.photo)
		
		//map
		map = MKMapView(frame: CGRectMake(20, 190, 255, 175))
	
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
		memoArea.layer.borderColor = (UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )).CGColor;
		memoArea.layer.borderWidth = 5
		
		//addSubview
		self.view.addSubview(image)
//		self.view.addSubview(map)
		self.view.addSubview(completeButton)
		self.view.addSubview(callBackButton)
		self.view.addSubview(leftMessageButton)
		self.view.addSubview(textedInsteadButton)
		self.view.addSubview(memoLabel)
		self.view.addSubview(memoArea)

		//dial out
//		UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(cleaner(contact.phone))")!)
		contact.called = NSDate()
	}
	
	func status(sender: UIButton) {
		completeButton.backgroundColor = UIColor.whiteColor()
		callBackButton.backgroundColor = UIColor.whiteColor()
		leftMessageButton.backgroundColor = UIColor.whiteColor()
		textedInsteadButton.backgroundColor = UIColor.whiteColor()
		
		contact.status = sender.titleLabel!.text!
		sender.backgroundColor = UIColor.greenColor()
	}

	func doneTapped(sender: UIBarButtonItem) {
		//add conditional to do nothing if no status is selected
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
