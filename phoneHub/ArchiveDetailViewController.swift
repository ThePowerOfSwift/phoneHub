//
//  ArchiveDetailViewController.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/14/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class ArchiveDetailViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
	
	@IBOutlet weak var pic: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var phoneLabel: UILabel!
	@IBOutlet weak var calledTime: UILabel!
	@IBOutlet weak var memo: UILabel!
	@IBOutlet weak var map: MKMapView!
	
	var ArchCell:Contacts!
	var locationManager:CLLocationManager = CLLocationManager()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
		let dateFormatter = NSDateFormatter()
		dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
		dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
		dateFormatter.timeZone = NSTimeZone()
		let localDate = dateFormatter.stringFromDate(ArchCell.called!)
		
		pic.image = UIImage(data: ArchCell.photo)
		nameLabel.text = ArchCell.name
		phoneLabel.text = ArchCell.phone
		calledTime.text = localDate
		memo.text = ArchCell.memo
	}
	
	func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
			println("managerLocation: \(manager.location)")
		println("latitude: \(manager.location.coordinate.latitude)")
		println("longitude: \(manager.location.coordinate.longitude)")
		self.locationManager.stopUpdatingLocation()
		
		let latitude:CLLocationDegrees = CLLocationDegrees(manager.location.coordinate.latitude)
		let longitude:CLLocationDegrees = CLLocationDegrees(manager.location.coordinate.longitude)
		
		let latDelta:CLLocationDegrees = 0.01
		let longDelta:CLLocationDegrees = 0.01
		
		var theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
		var locationOfInterest:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
		var region:MKCoordinateRegion = MKCoordinateRegionMake(locationOfInterest, theSpan)
		
		map.setRegion(region, animated: true)
		
		var thePin = MKPointAnnotation()
		thePin.coordinate = locationOfInterest
		map.addAnnotation(thePin)

	}
	
	func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
		println("zxcvzxcvError: " + error.localizedDescription)
	}
}
