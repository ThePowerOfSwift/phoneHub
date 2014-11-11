//
//  EditViewController.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/2/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func tappedTryAgain(sender: UIBarButtonItem) {
//        make sure button label is dependent on segue source
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func tappedDone(sender: UIBarButtonItem) {
        //save data
    }

}
