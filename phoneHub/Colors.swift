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
	let colorTop = UIColor(red: 192.0/255.0, green: 38.0/255.0, blue: 42.0/255.0, alpha: 1.0)
	let colorBottom = UIColor(red: 35.0/255.0, green: 2.0/255.0, blue: 2.0/255.0, alpha: 1.0)
	
	let gl: CAGradientLayer
	
	init() {
		gl = CAGradientLayer()
		gl.colors = [ colorTop, colorBottom]
		gl.locations = [ 0.0, 1.0]
	}
}