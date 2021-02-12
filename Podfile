source 'https://github.com/virgilius-santos/public-pod-specs.git'
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '12.4'

use_frameworks!

project 'VSMarvelApp/VSMarvelApp.xcodeproj'

target 'VSMarvelApp' do

  plugin 'cocoapods-keys', {
    :project => "VSMarvelApp/VSMarvelApp.xcodeproj",
    :target => "VSMarvelApp",
    :keys => [
      "MarvelApiKey",
      "MarvelPrivateKey"
    ]}

  pod "VService"
  pod "VCore"
  pod "VComponents"
  
  pod 'SwiftGen'
  pod 'SnapKit'
  
  pod 'Hero'
  
  pod 'CollectionKit'
  pod "CollectionKit/WobbleAnimator"
  pod "YetAnotherAnimationLibrary"
  pod "Kingfisher"
  
  pod 'RxSwift'
  pod 'RxRelay'
  pod 'RxCocoa'
  
  pod 'CryptoSwift'
  
  pod 'SwiftFormat/CLI'
  pod 'SwiftLint'

  
  target 'VSMarvelAppTests' do
    inherit! :search_paths

    pod 'RxTest'                      
    pod 'RxBlocking'                  
  end
end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
    
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.4'
            config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = 'YES'
            config.build_settings['SWIFT_VERSION'] = '5'
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.4'
      end
    end
end
