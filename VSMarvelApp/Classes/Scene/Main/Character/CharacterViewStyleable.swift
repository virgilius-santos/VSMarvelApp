
import UIKit

protocol CharacterViewStyleable {
    var dsLabel: UILabel { get }
    var dsImageView: UIImageView { get }
    
    func apply(style: CharacterViewStyle)
    func setup(_ vm: CharacterViewModel)
}

extension CharacterViewStyleable {
    func setup(_ vm: CharacterViewModel) {
        apply(style: vm.style)
        dsImageView.image = vm.asset.image
        dsImageView.cancelRequest()
        dsImageView.setImage(with: vm.path,
                             placeholder: vm.asset.image)
        dsImageView.heroID = vm.path
        dsLabel.text = "\(vm.name)\n\n\(vm.bio)"
    }
}

extension CharacterViewStyleable where Self: GridViewCell {
    
    func apply(style: CharacterViewStyle) {
        apply(shadow: style.shadow)
        apply(style: style, in: dsLabel)
        layer.cornerRadius = style.cornerRadius.value
    }
    
    func apply(shadow: DSShadow) {
        layer.shadowColor = shadow.shadowColor.uiColor.cgColor
        layer.shadowOpacity = Float(shadow.shadowOpacity.value)
        layer.shadowOffset = .zero
        layer.shadowRadius = shadow.shadowRadius.value
    }
    
    func apply(style: CharacterViewStyle, in label: UILabel) {
        dsLabel.textAlignment = NSTextAlignment.center
        dsLabel.tintColor = style.titleColor.uiColor
        dsLabel.backgroundColor = style.titleBackgroundColor
            .uiColor
            .withAlphaComponent(style.titleBackgroundAlpha.value)
    }
}

extension CharacterViewStyleable where Self: ListViewCell {
    
    func apply(style: CharacterViewStyle) {
        apply(style: style, in: dsLabel)
    }
    
    func apply(style: CharacterViewStyle, in label: UILabel) {
        dsLabel.numberOfLines = 0
        dsLabel.tintColor = style.titleColor.uiColor
        dsLabel.backgroundColor = style.titleBackgroundColor
            .uiColor
            .withAlphaComponent(style.titleBackgroundAlpha.value)
    }
}
