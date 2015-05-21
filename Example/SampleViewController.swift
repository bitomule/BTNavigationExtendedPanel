//
//  SampleViewController.swift
//  BTNavigationExtendedPanelhttps://github.com/bitomule/BTNavigationExtendedPanel.git
//
//  Created by David Collado Sela on 20/5/15.
//  Copyright (c) 2015 David Collado Sela. All rights reserved.
//

import UIKit

class SampleViewController: UIViewController,BTNavigationExtendedPanelDelegate {
    
    var panel:BTNavigationExtendedPanel!

    @IBAction func showButtonPressed(sender: AnyObject) {
        
        let button00 = BTButton(title: "Button 1", image: UIImage(named: "sampleimage")!, enabledImage: UIImage(named: "sampleimage_selected")!)
        let button01 = BTButton(title: "Button 2", image: UIImage(named: "sampleimage")!)
        let button02 = BTButton(title: "Button 3", image: UIImage(named: "sampleimage")!, enabledImage: UIImage(named: "sampleimage_selected")!)
        
        let button10 = BTButton(title: "Button 4", image: UIImage(named: "sampleimage")!, enabledImage: UIImage(named: "sampleimage_selected")!)
        let button11 = BTButton(title: "Button 5", image: UIImage(named: "sampleimage")!, enabledImage: UIImage(named: "sampleimage_selected")!)
        let button12 = BTButton(title: "Button 6", image: UIImage(named: "sampleimage")!)
        
        let row1 = BTRow(buttons:[button00,button01,button02],title:nil)
        let row2 = BTRow(buttons:[button10,button11,button12],title:"Row 2")

        panel = BTNavigationExtendedPanel.show(self, delegate: self, buttonRows: [row1,row2], buttonsTitleColor: UIColor.whiteColor(), separatorTitleColor: UIColor.whiteColor(), separatorColor: UIColor.whiteColor())
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Delegate
    
    func buttonPressed(index:BTButtonIndexPath){
        println("Row:\(index.row), Index: \(index.index)")
        if(index.row == 0 && index.index == 1){
            panel.hide(callback: { () -> Void in
                println("hidden")
            })
        }
    }

}
