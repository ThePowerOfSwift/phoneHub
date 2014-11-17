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

//		println(ArchCell.latitude)
//		println(ArchCell.longitude)
		
//		let latitude:CLLocationDegrees = CLLocationDegrees(ArchCell.latitude)
//		let longitude:CLLocationDegrees = CLLocationDegrees(ArchCell.longitude)
//		
//		let latDelta:CLLocationDegrees = 0.01
//		let longDelta:CLLocationDegrees = 0.01
//		
//		var theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
//		var locationOfInterest:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
//		var region:MKCoordinateRegion = MKCoordinateRegionMake(locationOfInterest, theSpan)
//		
//		map.setRegion(region, animated: true)
//		
//		var thePin = MKPointAnnotation()
//		thePin.coordinate = locationOfInterest
//		map.addAnnotation(thePin)
		
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
	
//	func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
//		CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
//			if placemarks.count > 0 {
//				let pm = placemarks[0] as CLPlacemark
//				self.locationManager.stopUpdatingLocation()
//				println("lat: \(pm.location.coordinate.latitude)\t\t\(pm.location.coordinate.longitude)")
//			} else {
//				println("Error with the data.")
//			}
//		})
//	}
//
//	func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
//		println("Error: " + error.localizedDescription)
//	}
	
	
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

		
//		CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
//			println("placemarks: \(placemarks)")
//
//			if (error != nil) {
//				println("111111111Error: " + error.localizedDescription)
//				return
//			}
//			
//			if placemarks.count > 0 {
//				let pm = placemarks[0] as CLPlacemark
//				self.displayLocationInfo(pm)
//			} else {
//				println("222222222Error with the data.")
//			}
//		})
	}
	
//	func displayLocationInfo(placemark: CLPlacemark) {
//		
//		self.locationManager.stopUpdatingLocation()
//		println(placemark.locality)
//		println(placemark.postalCode)
//		println(placemark.administrativeArea)
//		println(placemark.country)
//		println(placemark.location.coordinate.latitude)
//		println(placemark.location.coordinate.longitude)
//	}
	
	func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
		println("zxcvzxcvError: " + error.localizedDescription)
	}
}
