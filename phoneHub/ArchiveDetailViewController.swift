//
//  ArchiveDetailViewController.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/14/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit

class ArchiveDetailViewController: UIViewController {
	
	@IBOutlet weak var pic: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var phoneLabel: UILabel!
	@IBOutlet weak var calledTime: UILabel!
	@IBOutlet weak var memo: UILabel!
	
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
	}
	
	
}
