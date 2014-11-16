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
	var locationManager = CLLocationManager()
	
    override func viewDidLoad() {
        super.viewDidLoad()
//Start Loc
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()

//		locationManager(locationManager, didUpdateLocations: [])
		println(ArchCell.latitude)
		println(ArchCell.longitude)
		let latitude:CLLocationDegrees = CLLocationDegrees(ArchCell.latitude)
		let longitude:CLLocationDegrees = CLLocationDegrees(ArchCell.longitude)
		
		let latDelta:CLLocationDegrees = 0.01
		let longDelta:CLLocationDegrees = 0.01
		
		var theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
		var locationOfInterest:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
		var region:MKCoordinateRegion = MKCoordinateRegionMake(locationOfInterest, theSpan)
		
		map.setRegion(region, animated: true)
		
		var thePin = MKPointAnnotation()
		thePin.coordinate = locationOfInterest
		map.addAnnotation(thePin)
//End Loc
		
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
		CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
			if placemarks.count > 0 {
				let pm = placemarks[0] as CLPlacemark
				self.locationManager.stopUpdatingLocation()
				
				self.ArchCell.latitude = pm.location.coordinate.latitude
				self.ArchCell.longitude = pm.location.coordinate.longitude
				println("lat: \(pm.location.coordinate.latitude)\t\t\(pm.location.coordinate.longitude)")
				println(pm.country)
			} else {
				println("Error with the data.")
			}
		})
	}
}
/*
import UIKit
import CoreLocation
class ViewController: UIViewController, CLLocationManagerDelegate {
	let locationManager = CLLocationManager()
	override func viewDidLoad() {
		super.viewDidLoad()
		self.locationManager.delegate = self
		self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
		self.locationManager.requestWhenInUseAuthorization()
		self.locationManager.startUpdatingLocation()
	}
	func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
		CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
			if placemarks.count > 0 {
				let pm = placemarks[0] as CLPlacemark
				self.locationManager.stopUpdatingLocation()
				println("lat: \(pm.location.coordinate.latitude)\t\t\(pm.location.coordinate.longitude)")
			} else {
				println("Error with the data.")
			}
		})
	}
}
*/