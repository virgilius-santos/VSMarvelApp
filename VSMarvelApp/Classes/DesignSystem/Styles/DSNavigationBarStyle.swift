
import UIKit

struct DSNavigationBarStyle {
    
    var titleColor: DSColor
    var backgroundColor: DSColor
    
    static let `default` = DSNavigationBarStyle(titleColor: DSColor.text,
                                                backgroundColor: DSColor.primary)
}

extension DSNavigationBarStyleable where Self: UIViewController {
    
    func apply(style: DSNavigationBarStyle) {
        if let navBar = navigationController?.navigationBar {
            navBar.barTintColor = style.backgroundColor.uiColor
            navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: style.titleColor.uiColor]
        }
    }
}

extension DSNavigationBarConfigurable where Self: UIViewController {
    
    func configureRightButton(with icon: UIImage, target: Any, action: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: icon,
                                                            style: UIBarButtonItem.Style.plain,
                                                            target: target,
                                                            action: action)
    }
}
