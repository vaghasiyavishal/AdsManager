#
#  Be sure to run `pod spec lint AdsManager.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '12.0'
s.name = "AdsManager"
s.summary = "AdsManager lets a user can Set to Live Ads."
s.requires_arc = true

# 2
s.version = "0.1.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Vaghasiya Vishal" => "vaghasiyavishal@outlook.com" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/vaghasiyavishal/AdsManager"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/vaghasiyavishal/AdsManager.git",
             :tag => "#{s.version}" }

# 7
s.framework = "UIKit"
s.dependency 'Google-Mobile-Ads-SDK', '~> 8.6'

# 8
s.source_files = "AdsManager/**/*.{swift}"

# 9
s.resources = "AdsManager/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

# 10
s.swift_version = "4.2"

end
