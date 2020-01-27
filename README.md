
# Marvel - Mobile Exercise #

This is a iOS app created using Swift and the [Marvel Developer API](https://developer.marvel.com/).
You can search and save the chracteres you like most.

## Requirements

* Xcode 11.2
* iOS 12.4 +
* Swift 5.1

For security reasons I did not leave the public and private keys of the Marvel api in the project, so it is necessary to create an account on the site [Site Developer Marvel](https://developer.marvel.com)

## Architecture

This app is using `MVVM`, with  `Coordinators` on navigate between screens.
Also this app is using Repository to abstract the datasource from the viewModel. The Repository transform the service model (or database model) to app model for the purpose of isolate this layers.

## Features

* ✅ **No Storyboard:** Views develop using view code, with no broken contraints.
* ✅ **Unit Tests:** 59 (code coverage: ~79%)
* ✅ **UITests:** 0
* ✅ **Devices:** iPhone 5s, iPhone11.
* ✅ **iOS:** 12.4+.

🌟 💯 All tests passed using above configurations. 🌟

This project takes advantage of `Protocols` and `Generics` to reuse views and cells.

On Swift 5.1 I can use `Result` type to handle network responses better. 

You can favorite a character right from the catalog screen, just do a long press over any item and the options to that character will show up.

## Pods
#### pod 'VService'
is an HTTP networking library written in Swift.

#### pod 'VCore'
is an library with extensions and generics functions to helper development, written in Swift.

#### pod 'SnapKit'
Less verbose Auto-Layout constraints [link](https://github.com/SnapKit/SnapKit). 

#### pod 'Hero'
is a library for building iOS view controller transitions [link](https://github.com/HeroTransitions/Hero). 

#### pod 'CollectionKit'
A modern Swift framework for building composable data-driven collection view [link](https://github.com/SoySauceLab/CollectionKit). 

#### pod 'RxSwift, RxCocoa'
An API for asynchronous programming
with observable streams [link](https://github.com/ReactiveX/RxSwift). 

#### pod 'CryptoSwift'
CryptoSwift is a growing collection of standard and secure cryptographic algorithms implemented in Swift [link](https://github.com/krzyzanowskim/CryptoSwift).

#### pod 'cocoapods-keys'
A key value store for enviroment and application keys [link](https://github.com/orta/cocoapods-keys).

## How to install

* Clone or download the project to your machine.
* At the project directory run: ```bundle install``` and then ```bundle exec pod install```.
* Open XCode11+ and build the project using: ```Cmd```+ ```Shift``` + ```B```.
* Build the project for testing using: ```Cmd```+ ```Shift```+ ```U```.
* Run the tests using: ```Cmd``` + ```U```

### Reference

Screens: [thiagolioy/marvelapp-SketchProject](https://github.com/thiagolioy/marvelapp-SketchProject)

cocoa-keys: [thiagolioy/tools-pods-tricks](https://medium.com/cocoaacademymag/creating-a-ios-app-from-scratch-tools-pods-tricks-of-the-trade-and-more-part-1-a0a3f18fbd13#.fu8u4puxu)

### Next Steps
Create code documentation with Jazzy.
implementing unit tests with RxTest and RxBlocking.
Create code documentation with Jazzy.
implementing unit tests with RxTest and RxBlocking.
add screens
