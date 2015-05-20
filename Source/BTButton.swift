//
//  BTButton.swift
//  BTNavigationExtendedPanel
//
//  Created by David Collado Sela on 20/5/15.
//  Copyright (c) 2015 David Collado Sela. All rights reserved.
//

import UIKit

public class BTButton:NSObject{
    var title:String
    var image:UIImage
    var enabledImage:UIImage?
    var indexPath:BTButtonIndexPath
    var view:UIView!
    var imageView:UIImageView!
    var titleLabel:UILabel!
    var button:UIButton!
    private var on = false
    private var panel:BTNavigationExtendedPanel!
    
    public init (title:String,image:UIImage,enabledImage:UIImage?=nil){
        self.title = title
        self.image = image
        self.indexPath = BTButtonIndexPath(row: 0,index: 0)
        self.enabledImage = enabledImage
    }
    
    internal func turnOn(){
        if let enabledImage = enabledImage{
            on = true
            imageView.image = enabledImage
        }
    }
    
    internal func turnOff(){
        on = false
        imageView.image = image
    }
    
    internal var titlePadding:CGFloat = 5
    internal var imagePadding:CGFloat = 5
    
    // MARK: - View constructors
    
    internal func createView(container:UIView,buttonPadding:CGFloat,previousButton:UIView?,titleFont:UIFont)->UIView{
        view = UIView()
        view.backgroundColor = UIColor.blackColor()
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        container.addSubview(view)
        self.imageView = createImage(view)
        self.titleLabel = createTitleLabel(view,imageView:imageView)
        titleLabel.font = titleFont
        self.button = createButton(view)
        if let previousButton = previousButton{
            let leftConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: previousButton, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: buttonPadding)
            container.addConstraint(leftConstraint)
        }else{
            let leftConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: container, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
            container.addConstraint(leftConstraint)
        }
        let topConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: container, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 5)
        let bottomConstraint = NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 5)
        container.addConstraints([topConstraint,bottomConstraint])
        return view
    }
    
    private func createImage(container:UIView)->UIImageView{
        let imageView = UIImageView(image: image)
        imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        container.addSubview(imageView)
        let leftConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: container, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: imagePadding)
        let rightConstraint = NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: imageView, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: imagePadding)
        let topConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: container, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: imagePadding)
        let widthConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: image.size.width)
        let heightConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: image.size.height)
        container.addConstraints([leftConstraint,rightConstraint,topConstraint,widthConstraint,heightConstraint])
        return imageView
    }
    
    private func createTitleLabel(container:UIView,imageView:UIImageView)->UILabel{
        let label = UILabel()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        container.addSubview(label)
        label.text = self.title
        label.textColor = UIColor.whiteColor()
        label.numberOfLines = 0
        let leftConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: container, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: titlePadding)
        let rightConstraint = NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: label, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: titlePadding)
        let topConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: imageView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: titlePadding)
        let bottomConstraint = NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: label, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: titlePadding)
        container.addConstraints([leftConstraint,rightConstraint,topConstraint,bottomConstraint])
        return label
    }
    
    private func createButton(container:UIView)-> UIButton{
        let button = UIButton()
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        container.addSubview(button)
        let leftConstraint = NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: button, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: container, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: button, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: container, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: button, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        container.addConstraints([leftConstraint,rightConstraint,bottomConstraint,topConstraint])
        button.addTarget(self, action: "buttonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }
    
    // MARK: - Button target
    
    func buttonPressed(){
        on == true ? turnOff() : turnOn()
    }
}
