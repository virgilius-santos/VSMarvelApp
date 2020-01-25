
import Foundation

protocol DSNavigationBarStyleable {
    associatedtype Style
    func apply(style: Style)
}

protocol DSNavigationBarConfigurable {
    associatedtype Image
    func configureRightButton(with icon: Image, target: Any, action: Selector)
}
