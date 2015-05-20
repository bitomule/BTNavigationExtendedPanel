//
//  ModalExampleViewController.swift
//  BTNavigationExtendedPanel
//
//  Created by David Collado Sela on 20/5/15.
//  Copyright (c) 2015 David Collado Sela. All rights reserved.
//

import UIKit

class ModalExampleViewController: UIViewController {
    
    class func show(presenter:UIViewController){
        if let navigationController = presenter.navigationController{
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("ModalExampleViewController") as! ModalExampleViewController
            vc.modalPresentationStyle = UIModalPresentationStyle.Custom
            vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            vc.transitioningDelegate = vc.manager
            vc.presenterNavigationController = navigationController
            navigationController.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    let manager = TransitionManager()

    @IBOutlet weak var topSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var topButtonsContainer: UIView!
    @IBOutlet weak var bottomButtonsContainer: UIView!
    var presenterNavigationController:UINavigationController!
    
    var startHeight:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "viewTapped")
        self.view.addGestureRecognizer(tapGesture)
        
        let ignoreTapInContainer = UITapGestureRecognizer(target: self, action: "ignoreTapInContainer")
        viewContainer.addGestureRecognizer(ignoreTapInContainer)
        
        startHeight = viewContainer.bounds.height
        setAnchorToTop()
        matchNavigationBarColor()
    }
    
    private func setAnchorToTop(){
        viewContainer.layer.anchorPoint = CGPointMake(0.5, 0);
        topSpaceConstraint.constant = startHeight * -0.5
        topSpaceConstraint.constant = topSpaceConstraint.constant + presenterNavigationController.navigationBar.bounds.height
    }
    
    private func matchNavigationBarColor(){
        viewContainer.backgroundColor = presenterNavigationController.navigationBar.barTintColor
    }
    
    func viewTapped(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func ignoreTapInContainer(){
        
    }


}
