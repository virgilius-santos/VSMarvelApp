
import UIKit

struct CharacterViewStyle {
    static let `default` = CharacterViewStyle(
        titleColor: DSColor.text,
        titleBackgroundColor: DSColor.secondary,
        titleBackgroundAlpha: DSAlpha.medium,
        cornerRadius: DSRadius.medium,
        shadow: DSShadow.zero
    )

    var titleColor: DSColor
    var titleBackgroundColor: DSColor
    var titleBackgroundAlpha: DSAlpha
    var cornerRadius: DSRadius
    var shadow: DSShadow
}
