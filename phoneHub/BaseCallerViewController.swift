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

	var phoneLabel:UILabel!
	var memoLabel:UILabel!
	var memoArea:UITextView!
	var image:UIImageView!
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

		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
		
		//map
		map = MKMapView(frame: CGRectMake(20, 100, 150, 150))
		
	
		//done Bar Button
		doneBButton = UIBarButtonItem(title: "Done", style: .Bordered, target: self, action: "doneTapped:")
		self.navigationItem.rightBarButtonItem = doneBButton
		
		//memoLabel
		memoLabel = UILabel(frame: CGRectMake(20, 250, 150, 50))
		memoLabel.text = "Memo"
		
		//memo TextView
		memoArea = UITextView(frame: CGRectMake(20, 300, 200, 200))
		memoArea.layer.borderColor = (UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )).CGColor;
		memoArea.layer.borderWidth = 5
		
		//addSubview
		self.view.addSubview(map)
		self.view.addSubview(memoLabel)
		self.view.addSubview(memoArea)
	
		//dial out
		UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(cleaner(contact.phone))")!)
		contact.called = NSDate()
	}

	func doneTapped(sender: UIBarButtonItem) {
		//		if status != "Call Back" {contact.status = status}
		//		else {contact.called = nil}
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

//
//	@IBAction func status(sender: UIButton) {
//		status = sender.titleLabel!.text!
//	}
//	

	
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
