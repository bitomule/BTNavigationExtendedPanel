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
        let button00 = BTButton(title: "Button 1", image: UIImage(named: "sampleimage")!, indexPath: NSIndexPath(forRow: 0, inSection: 0), enabledImage: UIImage(named: "sampleimage")!)
        let button01 = BTButton(title: "Button 2", image: UIImage(named: "sampleimage")!, indexPath: NSIndexPath(forRow: 0, inSection: 1))
        let button02 = BTButton(title: "Button 3", image: UIImage(named: "sampleimage")!, indexPath: NSIndexPath(forRow: 0, inSection: 2), enabledImage: UIImage(named: "sampleimage")!)
        
        let button10 = BTButton(title: "Button 4", image: UIImage(named: "sampleimage")!, indexPath: NSIndexPath(forRow: 0, inSection: 0), enabledImage: UIImage(named: "sampleimage")!)
        let button11 = BTButton(title: "Button 5", image: UIImage(named: "sampleimage")!, indexPath: NSIndexPath(forRow: 1, inSection: 1), enabledImage: UIImage(named: "sampleimage")!)
        let button12 = BTButton(title: "Button 6", image: UIImage(named: "sampleimage")!, indexPath: NSIndexPath(forRow: 1, inSection: 2))
        BTNavigationExtendedPanel.show(self,buttonRows:[[button00,button01,button02],[button10,button11,button12]])
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
