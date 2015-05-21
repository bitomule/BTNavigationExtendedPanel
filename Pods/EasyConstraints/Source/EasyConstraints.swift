//
//  EasyConstraints.swift
//  EasyConstraints
//
//  Created by David Collado Sela on 21/5/15.
//  Copyright (c) 2015 David Collado Sela. All rights reserved.
//

import UIKit

infix operator <^> {}

infix operator *<^> {}

infix operator <<> {}

infix operator <>> {}

infix operator ><> {}

infix operator <>< {}

infix operator *><> {}

infix operator *<>< {}


//TOP
public func <^> (view1:UIView,relatedTo:(view2:UIView,constant:CGFloat)) -> NSLayoutConstraint{
    return NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: relatedTo.view2, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: relatedTo.constant)
}

public func <^> (view1:UIView,relatedTo:(view2:UIView,constant:CGFloat,relation:NSLayoutRelation)) -> NSLayoutConstraint{
    return NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Top, relatedBy: relatedTo.relation, toItem: relatedTo.view2, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: relatedTo.constant)
}

//BOTTOM
public func *<^> (view1:UIView,relatedTo:(view2:UIView,constant:CGFloat)) -> NSLayoutConstraint{
    return NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: relatedTo.view2, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: relatedTo.constant)
}

public func *<^> (view1:UIView,relatedTo:(view2:UIView,constant:CGFloat,relation:NSLayoutRelation)) -> NSLayoutConstraint{
    return NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Bottom, relatedBy: relatedTo.relation, toItem: relatedTo.view2, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: relatedTo.constant)
}

//LEFT
public func <<> (view1:UIView,relatedTo:(view2:UIView,constant:CGFloat)) -> NSLayoutConstraint{
    return NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: relatedTo.view2, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: relatedTo.constant)
}

public func <<> (view1:UIView,relatedTo:(view2:UIView,constant:CGFloat,relation:NSLayoutRelation)) -> NSLayoutConstraint{
    return NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Leading, relatedBy: relatedTo.relation, toItem: relatedTo.view2, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: relatedTo.constant)
}

//RIGHT
public func <>> (view1:UIView,relatedTo:(view2:UIView,constant:CGFloat)) -> NSLayoutConstraint{
    return NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: relatedTo.view2, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: relatedTo.constant)
}

public func <>> (view1:UIView,relatedTo:(view2:UIView,constant:CGFloat,relation:NSLayoutRelation)) -> NSLayoutConstraint{
    return NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Trailing, relatedBy: relatedTo.relation, toItem: relatedTo.view2, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: relatedTo.constant)
}

//LEADING HORIZONTAL SPACE
public func ><> (view1:UIView,relatedTo:(view2:UIView,constant:CGFloat)) -> NSLayoutConstraint{
    return NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: relatedTo.view2, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: relatedTo.constant)
}

public func ><> (view1:UIView,relatedTo:(view2:UIView,constant:CGFloat,relation:NSLayoutRelation)) -> NSLayoutConstraint{
    return NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Leading, relatedBy: relatedTo.relation, toItem: relatedTo.view2, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: relatedTo.constant)
}

//TRAILING HORIZONTAL SPACE
public func <>< (view1:UIView,relatedTo:(view2:UIView,constant:CGFloat)) -> NSLayoutConstraint{
    return NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: relatedTo.view2, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: relatedTo.constant)
}

public func <>< (view1:UIView,relatedTo:(view2:UIView,constant:CGFloat,relation:NSLayoutRelation)) -> NSLayoutConstraint{
    return NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Trailing, relatedBy: relatedTo.relation, toItem: relatedTo.view2, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: relatedTo.constant)
}

//LEADING VERTICAL SPACE
public func *><> (view1:UIView,relatedTo:(view2:UIView,constant:CGFloat)) -> NSLayoutConstraint{
    return NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: relatedTo.view2, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: relatedTo.constant)
}

public func *><> (view1:UIView,relatedTo:(view2:UIView,constant:CGFloat,relation:NSLayoutRelation)) -> NSLayoutConstraint{
    return NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Top, relatedBy: relatedTo.relation, toItem: relatedTo.view2, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: relatedTo.constant)
}

//TRAILING VERTICAL SPACE
public func *<>< (view1:UIView,relatedTo:(view2:UIView,constant:CGFloat)) -> NSLayoutConstraint{
    return NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: relatedTo.view2, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: relatedTo.constant)
}

public func *<>< (view1:UIView,relatedTo:(view2:UIView,constant:CGFloat,relation:NSLayoutRelation)) -> NSLayoutConstraint{
    return NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Bottom, relatedBy: relatedTo.relation, toItem: relatedTo.view2, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: relatedTo.constant)
}
