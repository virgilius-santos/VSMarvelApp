
import UIKit

struct CharacterViewStyle: Equatable {
    static let grid = CharacterViewStyle(
        titleColor: DSColor.text,
        titleBackgroundColor: DSColor.secondary,
        titleBackgroundAlpha: DSAlpha.medium,
        cornerRadius: DSRadius.medium,
        shadow: DSShadow.zero,
        textAlignment: .center,
        numberOfLines: 0
    )

    static let list = CharacterViewStyle(
        titleColor: DSColor.text,
        titleBackgroundColor: DSColor.secondary,
        titleBackgroundAlpha: DSAlpha.medium,
        cornerRadius: DSRadius.medium,
        shadow: nil,
        textAlignment: .left,
        numberOfLines: 0
    )

    let titleColor: DSColor
    let titleBackgroundColor: DSColor
    let titleBackgroundAlpha: DSAlpha
    let cornerRadius: DSRadius
    let shadow: DSShadow?
    let textAlignment: NSTextAlignment
    let numberOfLines: Int
}
