#
#  Be sure to run `pod spec lint NSDate+RelativeFormatter.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "BTNavigationExtendedPanel"
  s.version      = "0.3.3"
  s.summary      = "Custom UIView displayed under navigation bar."

  s.description  = <<-DESC
                  UIViewController displayed under navigation bar to simulate an extended navigation bar.
                  * Allows multiple rows
                  * Easy tu customize
                  * Uses auto layout
                  * Image based sizes
                  * Displayed with a nice animation
                   DESC

  s.homepage     = "https://github.com/bitomule/BTNavigationExtendedPanel"
  s.license      = "MIT"


  s.author             = { "David Collado Sela" => "bitomule@gmail.com" }
  s.social_media_url   = "http://twitter.com/bitomule"

  s.platform     = :ios
  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/bitomule/BTNavigationExtendedPanel.git", :tag => "0.3.3" }

  s.source_files = 'Source/*.swift'
  s.dependency 'EasyConstraints', '~> 0.1.0'
  s.requires_arc = true

end
