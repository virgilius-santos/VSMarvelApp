
import UIKit
import VCore

struct DSWindowStyle {
    var tintColor: DSColor
    var backgroundColor: DSColor
    
    static let `default` = DSWindowStyle(tintColor: DSColor.text,
                                         backgroundColor: DSColor.secondary)
}

extension WindowStyleable where Self: UIApplicationDelegate {
    
    func applyWindow(style: DSWindowStyle, in window: UIWindow) {
        window.backgroundColor = style.backgroundColor.uiColor
        window.tintColor = style.tintColor.uiColor
    }
}
