//
//  UIColorExtensions.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/23/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit

//Site Wide Colors
var teal:UIColor = UIColor(netHex: 0x21ACBB)
var beige:UIColor = UIColor(netHex: 0xE5C49A)
var grey:UIColor = UIColor(netHex: 0xD7D7CF)

var mainColor:UIColor = teal
var majorColor:UIColor = beige
var minorColor:UIColor = grey

//Site Wide Fonts
var HelvNThin13:UIFont = UIFont(name: "HelveticaNeue-Thin", size: 13)!
var HelvNLight20:UIFont = UIFont(name: "HelveticaNeue-Light", size: 20)!

var minorFont:UIFont = HelvNThin13
var majorFont:UIFont = HelvNLight20

//allows definition of colors in hex--pulled off stackoverflow
extension UIColor {
	convenience init(red: Int, green: Int, blue: Int) {
		assert(red >= 0 && red <= 255, "Invalid red component")
		assert(green >= 0 && green <= 255, "Invalid green component")
		assert(blue >= 0 && blue <= 255, "Invalid blue component")
		
		self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
	}
	
	convenience init(netHex:Int) {
		self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
	}
}

//quicker way to define labels
extension UILabel{
	convenience init(frame: CGRect, text: String, color: UIColor, font: UIFont){
		self.init()
		self.frame = frame
		self.text = text
		self.textColor = color
		self.font = font
	}
}

//fills an image with a color--pulled off stackoverflow
extension UIImage {
	func imageWithColor(tintColor: UIColor) -> UIImage {
		UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
		
		let context = UIGraphicsGetCurrentContext() as CGContextRef
		CGContextTranslateCTM(context, 0, self.size.height)
		CGContextScaleCTM(context, 1.0, -1.0);
		CGContextSetBlendMode(context, kCGBlendModeNormal)
		
		let rect = CGRectMake(0, 0, self.size.width, self.size.height) as CGRect
		CGContextClipToMask(context, rect, self.CGImage)
		tintColor.setFill()
		CGContextFillRect(context, rect)
		
		let newImage = UIGraphicsGetImageFromCurrentImageContext() as UIImage
		UIGraphicsEndImageContext()
		
		return newImage
	}
}