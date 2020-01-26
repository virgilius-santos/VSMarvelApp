// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  internal typealias AssetColorTypeAlias = NSColor
  internal typealias AssetImageTypeAlias = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  internal typealias AssetColorTypeAlias = UIColor
  internal typealias AssetImageTypeAlias = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Colors {
    internal static let primary = ColorAsset(name: "primary")
    internal static let secondary = ColorAsset(name: "secondary")
    internal static let text = ColorAsset(name: "text")
  }
  internal enum Images {
    internal static let gridIcon = ImageAsset(name: "Grid Icon")
    internal static let listIcon = ImageAsset(name: "List Icon")
    internal static let placeholder = ImageAsset(name: "placeholder")
    internal static let image1 = ImageAsset(name: "image_1")
    internal static let image10 = ImageAsset(name: "image_10")
    internal static let image11 = ImageAsset(name: "image_11")
    internal static let image12 = ImageAsset(name: "image_12")
    internal static let image13 = ImageAsset(name: "image_13")
    internal static let image14 = ImageAsset(name: "image_14")
    internal static let image15 = ImageAsset(name: "image_15")
    internal static let image16 = ImageAsset(name: "image_16")
    internal static let image17 = ImageAsset(name: "image_17")
    internal static let image18 = ImageAsset(name: "image_18")
    internal static let image19 = ImageAsset(name: "image_19")
    internal static let image2 = ImageAsset(name: "image_2")
    internal static let image20 = ImageAsset(name: "image_20")
    internal static let image21 = ImageAsset(name: "image_21")
    internal static let image22 = ImageAsset(name: "image_22")
    internal static let image23 = ImageAsset(name: "image_23")
    internal static let image24 = ImageAsset(name: "image_24")
    internal static let image25 = ImageAsset(name: "image_25")
    internal static let image26 = ImageAsset(name: "image_26")
    internal static let image27 = ImageAsset(name: "image_27")
    internal static let image28 = ImageAsset(name: "image_28")
    internal static let image29 = ImageAsset(name: "image_29")
    internal static let image3 = ImageAsset(name: "image_3")
    internal static let image30 = ImageAsset(name: "image_30")
    internal static let image4 = ImageAsset(name: "image_4")
    internal static let image5 = ImageAsset(name: "image_5")
    internal static let image6 = ImageAsset(name: "image_6")
    internal static let image7 = ImageAsset(name: "image_7")
    internal static let image8 = ImageAsset(name: "image_8")
    internal static let image9 = ImageAsset(name: "image_9")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ColorAsset {
  internal fileprivate(set) var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  internal var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

internal extension AssetColorTypeAlias {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct DataAsset {
  internal fileprivate(set) var name: String

  #if os(iOS) || os(tvOS) || os(OSX)
  @available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
  internal var data: NSDataAsset {
    return NSDataAsset(asset: self)
  }
  #endif
}

#if os(iOS) || os(tvOS) || os(OSX)
@available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
internal extension NSDataAsset {
  convenience init!(asset: DataAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(name: asset.name, bundle: bundle)
    #elseif os(OSX)
    self.init(name: NSDataAsset.Name(asset.name), bundle: bundle)
    #endif
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  internal var image: AssetImageTypeAlias {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = AssetImageTypeAlias(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = AssetImageTypeAlias(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

internal extension AssetImageTypeAlias {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}
