//
//  NewEditViewController.swift
//  phoneHub
//
//  Created by Stanley Chiang on 11/28/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit

class NewEditViewController: UIViewController {

	var msg: String!
    override func viewDidLoad() {
        super.viewDidLoad()
		if msg != nil {println("passed the message \(msg)!!  :D")}
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
