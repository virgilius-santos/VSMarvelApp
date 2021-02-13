
import UIKit

protocol CharacterViewStyleable {
    var dsLabel: UILabel { get }
    var dsImageView: UIImageView { get }

    static func cellSize(from size: CGSize) -> CGSize

    func setup(_ vm: CharacterViewModel)
}

extension CharacterViewStyleable where Self: UIView{
    func setup(_ vm: CharacterViewModel) {
        apply(style: vm.style)

        dsImageView.image = vm.asset.image
        dsImageView.cancelRequest()
        dsImageView.setImage(
            with: vm.path,
            placeholder: vm.asset.image
        )
        dsImageView.heroID = vm.path
        dsLabel.text = vm.label
    }

    private func apply(style: CharacterViewStyle) {
        apply(shadow: style.shadow)

        layer.cornerRadius = style.cornerRadius.value

        dsLabel.textAlignment = style.textAlignment
        dsLabel.numberOfLines = style.numberOfLines
        dsLabel.tintColor = style.titleColor.uiColor
        dsLabel.backgroundColor = style.titleBackgroundColor
            .uiColor
            .withAlphaComponent(style.titleBackgroundAlpha.value)
    }

    private func apply(shadow: DSShadow?) {
        guard let shadow = shadow else { return }
        layer.shadowColor = shadow.shadowColor.uiColor.cgColor
        layer.shadowOpacity = Float(shadow.shadowOpacity.value)
        layer.shadowOffset = .zero
        layer.shadowRadius = shadow.shadowRadius.value
    }
}
