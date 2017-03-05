# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target 'HungryOsori-iOS' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks

  # Pods for HungryOsori-iOS
  pod 'Firebase/Core'
  pod 'Firebase/Messaging'
  pod 'Alamofire', '~> 4.0'
  pod 'SDWebImage', '~> 4.0'

  target 'HungryOsori-iOSTests' do
    inherit! :search_paths
  endEMBEDDED_CONTENT_CONTAINS_SWIFT
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '3.0'
        config.build_settings['ALWAYS_EMBED_SWIFT_STANDART_LIBRARIES'] = 'NO'
      end
    end
  end
end
