//
//  Colors.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/24/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class Colors {
	let colorTop = UIColor.whiteColor().CGColor
	let colorBottom = UIColor(netHex: 0x30A5FF).CGColor
	
	let gl: CAGradientLayer
//	set switch cases instead
	init(top: UIColor, bot: UIColor) {
		gl = CAGradientLayer()
		gl.colors = [ top.CGColor, bot.CGColor]
		gl.locations = [ -1.5, 1.0]
	}
	
}