source 'https://github.com/virgilius-santos/public-pod-specs.git'
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '12.4'

use_frameworks!

target 'VSMarvelApp' do

  plugin 'cocoapods-keys', {
    :project => "VSMarvelApp.xcworkspace",
    :target => "VSMarvelApp",
    :keys => [
      "MarvelApiKey",
      "MarvelPrivateKey"
    ]}

  pod "VService"                        , '~> 0.2.6'#, :path => '../VSCommonSwiftLibrary'
  pod "VCore"                           , '~> 0.4'#, :path => '../VSCommonSwiftLibrary'
  pod "VComponents"                     , '~> 0.0.2'#, :path => '../VSCommonSwiftLibrary'
  
  pod 'SwiftGen'                        , '~> 6.0', :inhibit_warnings => true
  pod 'SnapKit'                         , '~> 5.0', :inhibit_warnings => true
  
  pod 'Hero'                            , '~> 1.5', :inhibit_warnings => true
  
  pod 'CollectionKit'                   , '~> 2.4', :inhibit_warnings => true
  pod "CollectionKit/WobbleAnimator"    , '~> 2.4', :inhibit_warnings => true
  pod "YetAnotherAnimationLibrary"      , :inhibit_warnings => true
  
  pod 'RxSwift'                         , '~> 5.0', :inhibit_warnings => true
  pod 'RxRelay'                         , :inhibit_warnings => true
  pod 'RxCocoa'                         , '~> 5.0', :inhibit_warnings => true
  
  pod 'CryptoSwift'                     , '~> 1.3', :inhibit_warnings => true
  
  pod 'SwiftFormat/CLI'                 , '~> 0.44', :inhibit_warnings => true
  
  target 'VSMarvelAppTests' do
    inherit! :search_paths

    pod 'RxTest'                        , '~> 5.0', :inhibit_warnings => true
    pod 'RxBlocking'                    , '~> 5.0', :inhibit_warnings => true
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5.1'
    end
  end
end
