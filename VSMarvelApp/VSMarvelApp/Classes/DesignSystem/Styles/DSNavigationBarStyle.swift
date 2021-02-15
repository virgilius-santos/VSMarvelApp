
import UIKit

struct DSNavigationBarStyle {
    static let `default` = DSNavigationBarStyle(
        titleColor: DSColor.text,
        backgroundColor: DSColor.primary
    )

    var titleColor: DSColor
    var backgroundColor: DSColor
}

extension UIViewController {
    func apply(style: DSNavigationBarStyle) {
        if let navBar = navigationController?.navigationBar {
            navBar.barTintColor = style.backgroundColor.uiColor
            navBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: style.titleColor.uiColor
            ]
        }
    }

    func configureRightButton(with icon: UIImage) -> UIBarButtonItem {
        let button = UIBarButtonItem(
            image: icon,
            style: UIBarButtonItem.Style.plain,
            target: nil,
            action: nil
        )
        navigationItem.rightBarButtonItem = button
        return button
    }
}
