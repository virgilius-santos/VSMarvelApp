
import UIKit
import VCore

enum DSColor: CaseIterable {
    case primary, text, secondary, textDarker

    var uiColor: UIColor {
        switch self {
        case .primary:
            return Asset.Colors.primary.color
        case .secondary:
            return Asset.Colors.secondary.color
        case .text:
            return Asset.Colors.text.color
        case .textDarker:
            return Asset.Colors.text.color
                .modified(additionalBrightness: DSBrightness.darker.value)
        }
    }
}
