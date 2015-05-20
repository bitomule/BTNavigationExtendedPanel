//
//  BTNavigationExtendedPanel.swift
//  BTNavigationExtendedPanel
//
//  Created by David Collado Sela on 20/5/15.
//  Copyright (c) 2015 David Collado Sela. All rights reserved.
//

import UIKit

public struct BTButtonIndexPath {
    var row = 0
    var index = 0
}

public struct BTRow {
    var buttons:[BTButton]
    var title:String?
}

public class BTNavigationExtendedPanel: UIViewController {
    
    public class func show(presenter:UIViewController,buttonRows:[BTRow]){
        if let navigationController = presenter.navigationController{
            let vc = BTNavigationExtendedPanel()
            vc.modalPresentationStyle = UIModalPresentationStyle.Custom
            vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            vc.transitioningDelegate = vc.manager
            vc.presenterNavigationController = navigationController
            vc.rowsCount = buttonRows.count
            vc.buttonRows = buttonRows
            navigationController.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    let manager = BTTransitionManager()
    var viewContainer: UIView!
    
    
    internal var buttonsHorizontalPadding:CGFloat = 5
    internal var rowsPadding:CGFloat = 10
    internal var lastRowPadding:CGFloat = 10
    internal var fristRowPadding:CGFloat = 10
    
    
    internal var startHeight:CGFloat = 0
    private var rowsCount = 0
    private var buttonRows:[BTRow]!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        createViewContainer()
        addGestureRecognizers()
        startHeight = viewContainer.bounds.height
        setAnchorToTop()
        matchNavigationBarColor()
    }
    
    private func addGestureRecognizers(){
        let tapGesture = UITapGestureRecognizer(target: self, action: "viewTapped")
        self.view.addGestureRecognizer(tapGesture)
        
        let ignoreTapInContainer = UITapGestureRecognizer(target: self, action: "ignoreTapInContainer")
        viewContainer.addGestureRecognizer(ignoreTapInContainer)
    }
    
    func viewTapped(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func ignoreTapInContainer(){
        
    }
    
    private var topSpaceConstraint: NSLayoutConstraint!
    
    private func setAnchorToTop(){
        viewContainer.layer.anchorPoint = CGPointMake(0.5, 0);
        topSpaceConstraint.constant = startHeight * -0.5
        topSpaceConstraint.constant = topSpaceConstraint.constant + presenterNavigationController.navigationBar.bounds.height
        if(!UIApplication.sharedApplication().statusBarHidden){
           topSpaceConstraint.constant = topSpaceConstraint.constant + UIApplication.sharedApplication().statusBarFrame.size.height
        }
    }
    
    private var presenterNavigationController:UINavigationController!
    
    private func matchNavigationBarColor(){
        if(presenterNavigationController.navigationBar.translucent){
            viewContainer.backgroundColor = presenterNavigationController.navigationBar.barTintColor
            println("Colors won't match as navigationBar is translucent")
        }else{
            viewContainer.backgroundColor = presenterNavigationController.navigationBar.barTintColor
        }
    }
    
    
    private func createViewContainer(){
        viewContainer = UIView()
        viewContainer.setTranslatesAutoresizingMaskIntoConstraints(false)
        viewContainer.clipsToBounds = true
        let trailingConstraint = NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: viewContainer, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: viewContainer, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
        topSpaceConstraint = NSLayoutConstraint(item: viewContainer, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        self.view.addSubview(viewContainer)
        createRowsContainers(rowsCount,container: viewContainer)
        self.view.addConstraints([trailingConstraint,leadingConstraint,topSpaceConstraint])
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        println(viewContainer.bounds.width)
    }
    
    private func createRowsContainers(rowsCount:Int,container:UIView){
        var lastAddedRow:UIView?
        assert(rowsCount > 0, "Can't create Panel without rows")
        for(var i=0;i<rowsCount;i++){
            lastAddedRow = createRow(container,previousRow:lastAddedRow,row:i)
        }
        let bottomSpaceConstraint = NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: lastAddedRow!, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: lastRowPadding)
        container.addConstraint(bottomSpaceConstraint)
    }
    
    private func createRow(container:UIView,previousRow:UIView?,row:Int)->UIView{
        let view = UIView()
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        container.addSubview(view)
        if let previousRow = previousRow{
            let topSpaceToPreviousRow = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: previousRow, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: rowsPadding)
            container.addConstraint(topSpaceToPreviousRow)
        }else{
            let topSpaceToSuperview = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: container, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: fristRowPadding)
            container.addConstraint(topSpaceToSuperview)
        }
        let trailingConstraint = NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.GreaterThanOrEqual, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: rowsPadding)
        let leadingConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.GreaterThanOrEqual, toItem: container, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: rowsPadding)
        let centerXConstraint = NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        container.addConstraints([leadingConstraint,leadingConstraint,centerXConstraint])
        createButtonsForRow(row,rowView:view)
        if(row + 1 < buttonRows.count && buttonRows[row + 1].title != nil){
            return createSeparator(row + 1, lastRow: view,container:container)
        }
        container.setNeedsLayout()
        container.layoutIfNeeded()
        return view
    }
    
    private func createButtonsForRow(row:Int,rowView:UIView){
        let buttons = self.buttonRows[row].buttons
        assert(buttons.count > 0, "Can't create row without buttons")
        var lastButtonView:UIView?
        for(var i=0;i<buttons.count;i++){
            buttons[i].indexPath = BTButtonIndexPath(row: row, index: i)
            buttons[i].createView(rowView,buttonPadding:buttonsHorizontalPadding, previousButton: lastButtonView)
            lastButtonView = buttons[i].view
        }
        let trailingConstraint = NSLayoutConstraint(item: rowView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: lastButtonView!, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)

        rowView.addConstraint(trailingConstraint)
    }
    
    private func createSeparator(row:Int,lastRow:UIView,container:UIView)->UIView{
        let view = UIView()
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        container.addSubview(view)
        let topSpaceToPreviousRow = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: lastRow, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: rowsPadding)
        let trailingConstraint = NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: rowsPadding)
        let leadingConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: container, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: rowsPadding)
        let heightConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 50)
        container.addConstraints([topSpaceToPreviousRow,trailingConstraint,leadingConstraint])
        let leadingLine = createSeparatorLine(view, titleLabel: nil)
        let titleLabel = createSeparatorTitleLabel(view, previousLine: leadingLine)
        titleLabel.text = buttonRows[row].title
        let trailingLine = createSeparatorLine(view, titleLabel: titleLabel)
        return view
    }
    
    private func createSeparatorLine(container:UIView,titleLabel:UIView?)->UIView{
        let view = UIView()
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.backgroundColor = UIColor.whiteColor()
        container.addSubview(view)
        if let titleLabel = titleLabel{
            let leadingConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: titleLabel, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: rowsPadding)
            let trailingConstraint = NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: rowsPadding)
            container.addConstraints([leadingConstraint,trailingConstraint])
        }else{
            let leadingConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: container, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: rowsPadding)
            container.addConstraint(leadingConstraint)
        }
        let heightConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 1)
        let centerYConstraint = NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        
        view.addConstraint(heightConstraint)
        container.addConstraints([centerYConstraint])
        return view
    }
    
    private func createSeparatorTitleLabel(container:UIView,previousLine:UIView)->UILabel{
        let label = UILabel()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        container.addSubview(label)
        let topConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: container, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 5)
        let bottomConstraint = NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: label, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 5)
        let leadingConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: previousLine, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: rowsPadding)
        let centerXConstraint = NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: label, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: label, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        container.addConstraints([topConstraint,bottomConstraint,leadingConstraint,centerXConstraint,centerYConstraint])
        return label
    }
    
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

}
