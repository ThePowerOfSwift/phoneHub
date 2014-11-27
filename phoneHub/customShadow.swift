//
//  customShadow.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/26/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit

class customShadow {
	init(theself: UIView, frame:CGRect){
		let x = frame.origin.x
		let y = frame.origin.y
		let w = frame.width
		let h = frame.height
		
		let imageSize = CGSize(width: 1, height: h)
		let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: x, y: y), size: imageSize))
		theself.addSubview(imageView)
		let image = drawCustomImage(imageSize)
		imageView.image = image
		
		let imageSize1 = CGSize(width: w, height: 1)
		let imageView1 = UIImageView(frame: CGRect(origin: CGPoint(x: x, y: y+h), size: imageSize1))
		theself.addSubview(imageView1)
		let image1 = drawCustomImage(imageSize1)
		imageView1.image = image1
	}
	
	func drawCustomImage(size: CGSize) -> UIImage {
		// Setup our context
		let bounds = CGRect(origin: CGPoint.zeroPoint, size: size)
		let opaque = false
		let scale: CGFloat = 0
		UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
		let context = UIGraphicsGetCurrentContext()
		
		// Setup complete, do drawing here
		CGContextSetStrokeColorWithColor(context, UIColor(netHex: 0xD7D7CF).CGColor)
		CGContextSetLineWidth(context, 3.0)
		CGContextStrokeRect(context, bounds)
		
		// Drawing complete, retrieve the finished image and cleanup
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return image
	}
}