#
#  Be sure to run `pod spec lint SwiftIcon.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

# 1
s.platform = :ios
s.ios.deployment_target = '11.0'
s.name = "SwiftIcon"
s.summary = "SwiftIcon is a light weight linear font to icon framework. It allows user to get icon string and image by simply using a hex code of the font file. It's targeting iOS 11.0+ by using Swift"
s.requires_arc = true

# 2
s.version = "1.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Eric Yang" => "yanglei.eric@gmail.com" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/ericleiyang/SwiftIcon"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/ericleiyang/SwiftIcon",
:tag => "#{s.version}" }

# 7
s.framework = "Foundation"
s.framework = "CoreGraphics"
s.framework = "CoreText"
s.framework = "UIKit"

# 8
s.source_files = "./*.{swift}"

# 9
s.swift_version = "4.2"

end
