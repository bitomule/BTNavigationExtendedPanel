//
//  BTNavigationExtendedPanel.swift
//  BTNavigationExtendedPanel
//
//  Created by David Collado Sela on 20/5/15.
//  Copyright (c) 2015 David Collado Sela. All rights reserved.
//

import UIKit

public class BTNavigationExtendedPanel: UIViewController {
    
    public class func show(presenter:UIViewController){
        if let navigationController = presenter.navigationController{
            let vc = BTNavigationExtendedPanel()
            vc.modalPresentationStyle = UIModalPresentationStyle.Custom
            vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            vc.transitioningDelegate = vc.manager
            vc.presenterNavigationController = navigationController
            navigationController.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    
    
    let manager = TransitionManager()
    
    @IBOutlet weak var topSpaceConstraint: NSLayoutConstraint!
    var viewContainer: UIView!
    var topButtonsContainer: UIView!
    var bottomButtonsContainer: UIView!
    var presenterNavigationController:UINavigationController!
    
    var startHeight:CGFloat = 0
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "viewTapped")
        self.view.addGestureRecognizer(tapGesture)
        
        let ignoreTapInContainer = UITapGestureRecognizer(target: self, action: "ignoreTapInContainer")
        viewContainer.addGestureRecognizer(ignoreTapInContainer)
        
        startHeight = viewContainer.bounds.height
        setAnchorToTop()
        matchNavigationBarColor()
    }
    
    func viewTapped(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func ignoreTapInContainer(){
        
    }
    
    private func setAnchorToTop(){
        viewContainer.layer.anchorPoint = CGPointMake(0.5, 0);
        topSpaceConstraint.constant = startHeight * -0.5
        topSpaceConstraint.constant = topSpaceConstraint.constant + presenterNavigationController.navigationBar.bounds.height
    }
    
    private func matchNavigationBarColor(){
        viewContainer.backgroundColor = presenterNavigationController.navigationBar.barTintColor
    }
    
    private func createViewContainer(){
        viewContainer = UIView()
        let trailingConstraint = NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: viewContainer, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: viewContainer, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
        self.view.addSubview(viewContainer)
        self.view.addConstraints([trailingConstraint])
    }
    
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

}
