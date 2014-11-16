//
//  ArchiveDetailViewController.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/14/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit
import MapKit

class ArchiveDetailViewController: UIViewController, MKMapViewDelegate {
	
	@IBOutlet weak var pic: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var phoneLabel: UILabel!
	@IBOutlet weak var calledTime: UILabel!
	@IBOutlet weak var memo: UILabel!
	@IBOutlet weak var map: MKMapView!
	
	var ArchCell:Contacts!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		var formatter: NSDateFormatter = NSDateFormatter()
		formatter.dateFormat = "MM-dd-yyyy"
		let stringDate: String = formatter.stringFromDate(ArchCell.called!)
		
		pic.image = UIImage(data: ArchCell.photo)
		nameLabel.text = ArchCell.name
		phoneLabel.text = ArchCell.phone
		calledTime.text = stringDate
		memo.text = ArchCell.memo

		let latitude:CLLocationDegrees = 33.9243744
		let latDelta:CLLocationDegrees = 0.01
		let longitude:CLLocationDegrees = -84.3057602
		let longDelta:CLLocationDegrees = 0.01
		
		var theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
		
		var locationOfInterest:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
		
		var region:MKCoordinateRegion = MKCoordinateRegionMake(locationOfInterest, theSpan)
		
		map.setRegion(region, animated: true)
		
		var thePin = MKPointAnnotation()
		thePin.coordinate = locationOfInterest
		map.addAnnotation(thePin)
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
			if (error != nil) {
				println("Error: " + error.localizedDescription)
				return
			}
			if placemarks.count > 0 {
				let pm = placemarks[0] as CLPlacemark
				self.displayLocationInfo(pm)
			} else {
				println("Error with the data.")
			}
		})
	}
	func displayLocationInfo(placemark: CLPlacemark) {
		self.locationManager.stopUpdatingLocation()
		println(placemark.location.coordinate.latitude);println(placemark.location.coordinate.longitude)
		
		println(placemark.locality);println(placemark.postalCode);println(placemark.administrativeArea);println(placemark.country)
	}
	func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
		println("Error: " + error.localizedDescription)
	}
}
*/