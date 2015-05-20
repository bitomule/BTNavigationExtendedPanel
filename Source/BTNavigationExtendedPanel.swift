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
    
    
    
    let manager = BTTransitionManager()
    
    var topSpaceConstraint: NSLayoutConstraint!
    var viewContainer: UIView!
    var topButtonsContainer: UIView!
    var bottomButtonsContainer: UIView!
    var presenterNavigationController:UINavigationController!
    
    var startHeight:CGFloat = 0
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        createViewContainer()
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
        if(!UIApplication.sharedApplication().statusBarHidden){
           topSpaceConstraint.constant = topSpaceConstraint.constant + UIApplication.sharedApplication().statusBarFrame.size.height
        }
    }
    
    private func matchNavigationBarColor(){
        
        func colorComponentTranslucent(component:Int) -> Int{
            return (component - 40) / (1 - 40 / 255)
        }
        
        if(presenterNavigationController.navigationBar.translucent){
            viewContainer.backgroundColor = presenterNavigationController.navigationBar.barTintColor
            println("Colors won't match as navigationBar is translucent")
        }else{
            viewContainer.backgroundColor = presenterNavigationController.navigationBar.barTintColor
        }
    }
    
    private func createViewContainer(){
        viewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 1000))
        viewContainer.setTranslatesAutoresizingMaskIntoConstraints(false)
        viewContainer.clipsToBounds = true
        let trailingConstraint = NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: viewContainer, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: viewContainer, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
        topSpaceConstraint = NSLayoutConstraint(item: viewContainer, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        self.view.addSubview(viewContainer)
        createRowsContainers(3,container: viewContainer)
        self.view.addConstraints([trailingConstraint,leadingConstraint,topSpaceConstraint])
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    private func createRowsContainers(rowsCount:Int,container:UIView){
        var lastAddedRow:UIView?
        assert(rowsCount >= 1, "Can't create Panel without rows")
        for(var i=0;i<rowsCount;i++){
            lastAddedRow = createRow(container,previousRow:lastAddedRow)
        }
        let bottomSpaceConstraint = NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: lastAddedRow!, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 10)
        container.addConstraint(bottomSpaceConstraint)
    }
    
    private func createRow(container:UIView,previousRow:UIView?)->UIView{
        let view = UIView()
        view.backgroundColor = UIColor.yellowColor()
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        container.addSubview(view)
        if let previousRow = previousRow{
            let topSpaceToPreviousRow = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: previousRow, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 20)
            container.addConstraint(topSpaceToPreviousRow)
        }else{
            let topSpaceToSuperview = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: container, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 10)
            container.addConstraint(topSpaceToSuperview)
        }
        let trailingConstraint = NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 10)
        let leadingConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: container, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 10)
        let heightConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 100)
        container.addConstraints([trailingConstraint,leadingConstraint])
        view.addConstraint(heightConstraint)
        return view
    }
    
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

}
