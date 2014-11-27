//
//  ArchiveDetailViewController.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/14/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit
import MapKit
class ArchiveDetailViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
	
	@IBOutlet weak var pic: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var phoneLabel: UILabel!
	@IBOutlet weak var statusLabel: UILabel!
	@IBOutlet weak var calledTime: UILabel!
	@IBOutlet weak var memoArea: UITextView!

	@IBOutlet weak var map: MKMapView!
	
	var ArchCell:Contacts!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor(netHex: 0x274A95)
		let dateFormatter = NSDateFormatter()
		dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
		dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
		dateFormatter.timeZone = NSTimeZone()
		let localDate = dateFormatter.stringFromDate(ArchCell.called!)
		
		pic.image = UIImage(data: ArchCell.photo)
		pic.contentMode = .ScaleAspectFit
		pic.layer.cornerRadius = pic.frame.size.width / 2
		pic.clipsToBounds = true
		pic.layer.borderColor = UIColor.whiteColor().CGColor
		pic.layer.borderWidth = 1
		
		nameLabel.text = ArchCell.name
//		nameLabel.textColor = UIColor.whiteColor()
		
		phoneLabel.text = ArchCell.phone
//		phoneLabel.textColor = UIColor.whiteColor()
		
		calledTime.text = localDate
//		calledTime.textColor = UIColor.whiteColor()
		
		memoArea.text = ArchCell.memo
		memoArea.editable = false
		memoArea.backgroundColor = UIColor(netHex: 0xD7D7CF)
//		memo.textColor = UIColor.whiteColor()
		
		statusLabel.text = ArchCell.status
//		statusLabel.textColor = UIColor.whiteColor()
		
		
		loadMap(ArchCell.latitude as CLLocationDegrees, long: ArchCell.longitude as CLLocationDegrees, map: map)
		
		view.backgroundColor = UIColor(netHex: 0xE5C49A)
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
}