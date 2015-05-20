//
//  BTTransitionManager.swift
//  BTNavigationExtendedPanel
//
//  Created by David Collado Sela on 20/5/15.
//  Copyright (c) 2015 David Collado Sela. All rights reserved.
//

import UIKit

class BTTransitionManager: NSObject,UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    private var presenting = false
    var screens : (from:UIViewController, to:UIViewController)!
    var transitionContext:UIViewControllerContextTransitioning!
    
    // MARK: UIViewControllerAnimatedTransitioning protocol methods
    
    // animate a change from one viewcontroller to another
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        // get reference to our fromView, toView and the container view that we should perform the transition in
        let container = transitionContext.containerView()
        
        // create a tuple of our screens
        screens = (transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!, transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!)
        
        // assign references to our menu view controller and the 'bottom' view controller from the tuple
        // remember that our menuViewController will alternate between the from and to view controller depending if we're presenting or dismissing
        let menuViewController = !self.presenting ? screens.from as! BTNavigationExtendedPanel : screens.to as! BTNavigationExtendedPanel
        
        // perform the animation!
        
        if (self.presenting){
            self.onStageMenuController(menuViewController)
        }
        else {
            self.offStageMenuController(menuViewController)
        }
    }
    
    func offStageMenuController(menuViewController:BTNavigationExtendedPanel){
        menuViewController.viewContainer.layer.removeAllAnimations()
        let animation = CABasicAnimation(keyPath: "bounds.size.height")
        animation.duration = self.transitionDuration(transitionContext)
        animation.fromValue = menuViewController.startHeight
        animation.toValue = 0
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.delegate = self
        menuViewController.viewContainer.layer.addAnimation(animation, forKey: "scaleUp")
    }
    
    func onStageMenuController(menuViewController:BTNavigationExtendedPanel){
        let animation = CABasicAnimation(keyPath: "bounds.size.height")
        animation.duration = self.transitionDuration(transitionContext)
        animation.fromValue = 0
        animation.toValue = menuViewController.startHeight
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.delegate = self
        menuViewController.viewContainer.layer.addAnimation(animation, forKey: "scaleDown")
    }
    
    // return how many seconds the transiton animation will take
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.2
    }
    
    // MARK: UIViewControllerTransitioningDelegate protocol methods
    
    // return the animataor when presenting a viewcontroller
    // remember that an animator (or animation controller) is any object that aheres to the UIViewControllerAnimatedTransitioning protocol
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    // return the animator used when dismissing from a viewcontroller
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        transitionContext.completeTransition(true)
        // bug: we have to manually add our 'to view' back http://openradar.appspot.com/radar?id=5320103646199808
        UIApplication.sharedApplication().keyWindow?.addSubview(screens.to.view)
    }
    
}

