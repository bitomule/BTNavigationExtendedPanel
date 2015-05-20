//
//  SampleViewController.swift
//  BTNavigationExtendedPanel
//
//  Created by David Collado Sela on 20/5/15.
//  Copyright (c) 2015 David Collado Sela. All rights reserved.
//

import UIKit

class SampleViewController: UIViewController {

    @IBAction func showButtonPressed(sender: AnyObject) {
        BTNavigationExtendedPanel.show(self)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
