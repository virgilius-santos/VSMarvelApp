source 'https://github.com/virgilius-santos/public-pod-specs.git'
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '12.4'

use_frameworks!

target 'VSMarvelApp' do

  plugin 'cocoapods-keys', {
    :project => "VSMarvelApp",
    :target => "VSMarvelApp",
    :keys => [
      "MarvelApiKey",
      "MarvelPrivateKey"
    ]}

  pod "VService"                , :path => '../VSCommonSwiftLibrary'
  pod "VCore"                   , :path => '../VSCommonSwiftLibrary'
  pod "VComponents"             , :path => '../VSCommonSwiftLibrary'
  pod 'SwiftGen'                , '~> 6.0'
  pod 'SnapKit'                 , '~> 5.0'

  target 'VSMarvelAppTests' do
    inherit! :search_paths

  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5.1'
    end
  end
end
