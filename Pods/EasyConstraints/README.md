# EasyConstraints
Suit of custom swift operators to create NSLayoutConstraints.

## Why?

Sometimes you need to do auto layout in code, and many times it's horrible. You need to use NSLayoutConstraint with a looong method or use auto layout format strings. I wanted to test swift custom operators and had a bad time with lot's of lines of simple auto layout constraints. With this easy operators I'm able to reduce code and get a clear view of what I'm doing when I create a constraint.

## Installation

> **Embedded frameworks require a minimum deployment target of iOS 8 or OS X Mavericks.**
>


### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

CocoaPods 0.36 adds supports for Swift and embedded frameworks. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate EasyConstraints into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'EasyConstraints'
```

Then, run the following command:

```bash
$ pod install
```


## Easy to understand

You just need to learn 3 concepts:

####<>

<> means first Item in constraint relation, equivalent to item parameter in NSLayoutConstraint.

####*

\* means oposite. For example, in a horizontal trailing relationship "<><" * would mean vertical "*<><".

####<^>

<^> means top, so if you want to make view1 top equals to view2 top you just need: "view1<^>(view2,0)". And you are right, "*<^>" is bottom!

## How to

EasyConstraints only includes some constraints, the ones I needed as this started as a learning project. All the operators take a view and a touple with view, constant and a optional NSLayoutRelation parameter. If you need to define a different NSLayoutRelation to Equal (default) you can use that paremeter.

This are the operators included in EasyConstraints now:

#### <^>

EasyConstraints:

```swift
view1<^>(view2,0)
```

Using NSLayoutConstraint constructor:

```swift
NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view2, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
```

#### *<^>

EasyConstraints:

```swift
view1*<^>(view2,0)
```

Using NSLayoutConstraint constructor:

```swift
NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view2, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
```

#### <<>

EasyConstraints:

```swift
view1<<>(view2,0)
```

Using NSLayoutConstraint constructor:

```swift
NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view2, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
```

#### <>>

EasyConstraints:

```swift
view1<>>(view2,0)
```

Using NSLayoutConstraint constructor:

```swift
NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view2, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
```

#### ><>

EasyConstraints:

```swift
view1><>(view2,0)
```

Using NSLayoutConstraint constructor:

```swift
NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view2, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
```

#### <><

EasyConstraints:

```swift
view1<><(view2,0)
```

Using NSLayoutConstraint constructor:

```swift
NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view2, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
```

#### *><>

EasyConstraints:

```swift
view1*><>(view2,0)
```

Using NSLayoutConstraint constructor:

```swift
NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view2, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
```

#### *<><

EasyConstraints:

```swift
view1*<><(view2,0)
```

Using NSLayoutConstraint constructor:

```swift
NSLayoutConstraint(item: view1, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view2, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
```

## Thanks

Maybe you hate this idea,love it or want to create a PR. Any feedback is welcome. 





