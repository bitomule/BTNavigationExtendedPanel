//
//  BTNavigationExtendedPanel.swift
//  BTNavigationExtendedPanel
//
//  Created by David Collado Sela on 20/5/15.
//  Copyright (c) 2015 David Collado Sela. All rights reserved.
//

import UIKit
import EasyConstraints

public struct BTButtonIndexPath {
    public var row = 0
    public var index = 0
    public init(row:Int,index:Int) {
        self.row = row
        self.index = index
    }
}

public struct BTRow {
    public var buttons:[BTButton]
    public var title:String?
    public init(buttons:[BTButton],title:String?) {
        self.buttons = buttons
        self.title = title
    }
}

public class BTNavigationExtendedPanel: UIViewController {
    
    public class func create(presenter:UIViewController,delegate:BTNavigationExtendedPanelDelegate,buttonRows:[BTRow],buttonsHorizontalPadding:CGFloat = 5,buttonImagesHorizontalPadding:CGFloat = 5,buttonsFont:UIFont = UIFont.systemFontOfSize(15),separatorsFont:UIFont = UIFont.systemFontOfSize(15),buttonsTitleColor:UIColor = UIColor.blackColor(),separatorTitleColor:UIColor = UIColor.blackColor(),separatorColor:UIColor = UIColor.blackColor())-> BTNavigationExtendedPanel?{
        if let navigationController = presenter.navigationController{
            let vc = BTNavigationExtendedPanel()
            vc.presenterNavigationController = navigationController
            vc.rowsCount = buttonRows.count
            vc.buttonRows = buttonRows
            vc.buttonsFont = buttonsFont
            vc.separatorsFont = separatorsFont
            vc.buttonsTitleColor = buttonsTitleColor
            vc.separatorTitleColor = separatorTitleColor
            vc.buttonsHorizontalPadding = buttonsHorizontalPadding
            vc.imagesPadding = buttonImagesHorizontalPadding
            vc.separatorColor = separatorColor
            vc.delegate = delegate
            return vc
        }
        println("Can't find navigation controller")
        return nil
    }
    
    private var displayed = false
    
    private var inTime = 0.5
    private var outTime = 0.3
    
    public func show(callback:(()->Void)? = nil){
        displayed = true
        
        self.willMoveToParentViewController(presenterNavigationController)
        presenterNavigationController.view.addSubview(self.view)
        self.didMoveToParentViewController(presenterNavigationController)
        
        let animation = CABasicAnimation(keyPath: "bounds.size.height")
        animation.duration = inTime
        animation.fromValue = 0
        animation.toValue = self.startHeight
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.645, 0.045, 0.355, 1)
        animation.delegate = self
        self.viewContainer.layer.addAnimation(animation, forKey: "scaleDown")
    }
    
    public func hide(){
        displayed = false
        self.viewContainer.layer.removeAllAnimations()
        
        let animation = CABasicAnimation(keyPath: "bounds.size.height")
        animation.duration = outTime
        animation.fromValue = self.startHeight
        animation.toValue = 0
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.645, 0.045, 0.355, 1)
        animation.delegate = self
        self.viewContainer.layer.addAnimation(animation, forKey: "scaleUp")
    }
    
    public func isExpanded()->Bool{
        return displayed
    }
    
    override public func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        if(!displayed){
            self.view.removeFromSuperview()
        }
    }
    
    public func setButtonOnAtIndex(index:BTButtonIndexPath,on:Bool){
        let row = buttonRows[index.row]
        let button = row.buttons[index.index]
        if(on){
            button.turnOn()
        }else{
            button.turnOff()
        }
    }
    
    public func setButtonTitleAtIndex(index:BTButtonIndexPath,title:String){
        let row = buttonRows[index.row]
        let button = row.buttons[index.index]
        button.updateTitle(title)
    }
    
    public func setButtonImageAtIndex(index:BTButtonIndexPath,image:UIImage){
        let row = buttonRows[index.row]
        let button = row.buttons[index.index]
        button.updateImage(image)
    }
    
    
    var viewContainer: UIView!
    
    
    internal var buttonsHorizontalPadding:CGFloat = 5
    internal var rowsPadding:CGFloat = 0
    internal var rowsHorizontalMargin:CGFloat = 13
    internal var titleHorizontalmargin:CGFloat = 5
    internal var separatorTopPadding:CGFloat = 10
    internal var lastRowPadding:CGFloat = 10
    internal var firstRowPadding:CGFloat = 10
    internal var imagesPadding:CGFloat = 5
    
    
    internal var startHeight:CGFloat = 0
    private var rowsCount = 0
    private var buttonRows:[BTRow]!
    private var buttonsFont:UIFont!
    private var separatorsFont:UIFont!
    private var buttonsTitleColor:UIColor!
    private var separatorTitleColor:UIColor!
    private var separatorColor:UIColor!
    
    private var delegate:BTNavigationExtendedPanelDelegate!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        createViewContainer()
        addGestureRecognizers()
        startHeight = viewContainer.bounds.height
        setFrame()
        setAnchorToTop()
        matchNavigationBarColor()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "navigationControllerChange", name: "UINavigationControllerWillShowViewControllerNotification", object: nil)
    }
    
    func navigationControllerChange(){
        hide()
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    private func addGestureRecognizers(){
        let tapGesture = UITapGestureRecognizer(target: self, action: "viewTapped")
        self.view.addGestureRecognizer(tapGesture)
        let navigationBarTapGesture = UITapGestureRecognizer(target: self, action: "viewTapped")
        self.presenterNavigationController.navigationBar.addGestureRecognizer(navigationBarTapGesture)
        
        let ignoreTapInContainer = UITapGestureRecognizer(target: self, action: "ignoreTapInContainer")
        viewContainer.addGestureRecognizer(ignoreTapInContainer)
    }
    
    func viewTapped(){
        hide()
    }
    
    func ignoreTapInContainer(){
        
    }
    
    private var topSpaceConstraint: NSLayoutConstraint!
    
    private func setFrame(){
        let y:CGFloat
        if(UIApplication.sharedApplication().statusBarHidden){
            y = presenterNavigationController.navigationBar.bounds.height - 1
        }else{
            y = presenterNavigationController.navigationBar.bounds.height + UIApplication.sharedApplication().statusBarFrame.size.height - 1
        }
        view.frame = CGRect(x: 0, y: y, width: presenterNavigationController.view.bounds.width, height: presenterNavigationController.view.bounds.height)
    }
    
    private func setAnchorToTop(){
        viewContainer.layer.anchorPoint = CGPointMake(0.5, 0);
        topSpaceConstraint.constant = startHeight * -0.5
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
        let trailingConstraint = self.view<>>(viewContainer,0)
        let leadingConstraint = self.view<<>(viewContainer,0)
        topSpaceConstraint = viewContainer<^>(self.view,0)
        self.view.addSubview(viewContainer)
        createRowsContainers(rowsCount,container: viewContainer)
        self.view.addConstraints([trailingConstraint,leadingConstraint,topSpaceConstraint])
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    private func createRowsContainers(rowsCount:Int,container:UIView){
        var lastAddedRow:UIView?
        assert(rowsCount > 0, "Can't create Panel without rows")
        for(var i=0;i<rowsCount;i++){
            lastAddedRow = createRow(container,previousRow:lastAddedRow,row:i)
        }
        let bottomSpaceConstraint = container*<^>(lastAddedRow!,lastRowPadding)
        container.addConstraint(bottomSpaceConstraint)
    }
    
    private func createRow(container:UIView,previousRow:UIView?,row:Int)->UIView{
        let view = UIView()
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        container.addSubview(view)
        if let previousRow = previousRow{
            var prev:UIView!
            if(buttonRows[row].title != nil){
                prev = createSeparator(row, lastViewAdded: previousRow,container:container)
            }else{
                prev = previousRow
            }
            let topSpaceToPreviousRow = view*><>(prev,rowsPadding)
            container.addConstraint(topSpaceToPreviousRow)
            
        }else{
            let topSpaceToSuperview = view<^>(container,firstRowPadding)
            container.addConstraint(topSpaceToSuperview)
        }
        let trailingConstraint = view<><(container,rowsHorizontalMargin)
        let leadingConstraint = view<<>(container,rowsHorizontalMargin,NSLayoutRelation.GreaterThanOrEqual)
        let centerXConstraint = NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        container.addConstraints([leadingConstraint,leadingConstraint,centerXConstraint])
        createButtonsForRow(row,rowView:view)
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
            buttons[i].createView(rowView,panel:self,buttonPadding:buttonsHorizontalPadding,imagesPadding:imagesPadding, previousButton: lastButtonView,titleFont:buttonsFont,titleColor:buttonsTitleColor)
            lastButtonView = buttons[i].view
        }
        let trailingConstraint = rowView<>>(lastButtonView!,0)

        rowView.addConstraint(trailingConstraint)
    }
    
    private func createSeparator(row:Int,lastViewAdded:UIView,container:UIView)->UIView{
        let view = UIView()
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        container.addSubview(view)
        let topSpaceToPreviousRow = view*><>(lastViewAdded,separatorTopPadding)
        let trailingConstraint = container<>>(view,rowsHorizontalMargin)
        let leadingConstraint = view<<>(container,rowsHorizontalMargin)
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
        view.backgroundColor = separatorColor
        container.addSubview(view)
        if let titleLabel = titleLabel{
            let leadingConstraint = view><>(titleLabel,titleHorizontalmargin)
            let trailingConstraint = container<>>(view,rowsHorizontalMargin)
            container.addConstraints([leadingConstraint,trailingConstraint])
        }else{
            let leadingConstraint = view<<>(container,rowsHorizontalMargin)
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
        label.font = separatorsFont
        label.textColor = separatorTitleColor
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        container.addSubview(label)
        let topConstraint = label<^>(container,5)
        let bottomConstraint = container*<^>(label,5)
        let leadingConstraint = label><>(previousLine,titleHorizontalmargin)
        let centerXConstraint = NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: label, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: label, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        container.addConstraints([topConstraint,bottomConstraint,leadingConstraint,centerXConstraint,centerYConstraint])
        return label
    }
    
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    internal func buttonPressed(index:BTButtonIndexPath){
        delegate.buttonPressed(index)
    }

}
