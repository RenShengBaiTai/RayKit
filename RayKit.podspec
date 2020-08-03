#
# Be sure to run `pod lib lint RayKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RayKit'
  s.version          = '1.0.1'
  s.summary          = 'Ray Lib'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                        RayKit is common Lib
                        DESC
                        
  s.homepage         = 'https://github.com/RenShengBaiTai'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '757038564@qq.com' => 'caixiaobo2018@gmail.com' }
  s.source           = { :git => 'https://github.com/RenShengBaiTai/RayKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'RayKit/Classes/**/*'
  
  s.dependency 'KeychainSwift'
  s.dependency 'SnapKit'
  s.dependency 'MJRefresh'

  
  s.swift_version = '5.0'

   s.resource_bundles = {
     'RayKit' => ['RayKit/Assets/*']
   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
