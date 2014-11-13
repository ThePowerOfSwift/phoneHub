//
//  PostCallViewController.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/2/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit

class PostCallViewController: UIViewController {

	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var phoneLabel: UILabel!
	@IBOutlet weak var memo: UITextView!

	var nameL:String!
	var phoneL:String!
	var memoL:String!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		nameLabel.text = nameL
		phoneLabel.text = phoneL
		memo.text = memoL
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
