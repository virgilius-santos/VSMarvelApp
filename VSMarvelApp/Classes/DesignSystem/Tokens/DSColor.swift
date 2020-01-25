
import UIKit
import VCore

enum DSColor: CaseIterable {
    case primary, text, secondary
    
    var uiColor: UIColor {
        switch self {
        case .primary:
            return Asset.Colors.primary.color
        case .secondary:
            return Asset.Colors.secondary.color
        case .text:
            return Asset.Colors.text.color
        }
    }
}
