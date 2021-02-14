
import UIKit
import VCore

struct DSWindowStyle {
    var tintColor: DSColor
    var backgroundColor: DSColor

    static let `default` = DSWindowStyle(tintColor: DSColor.text,
                                         backgroundColor: DSColor.secondary)
}

extension UIWindow {
    func apply(style: DSWindowStyle) {
        backgroundColor = style.backgroundColor.uiColor
        tintColor = style.tintColor.uiColor
    }
}
