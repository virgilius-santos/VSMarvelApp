
import UIKit

protocol DSCellStyleable {
    var dsLabel: UILabel { get }
    var dsImageView: UIImageView { get }
    
    func apply(style: DSCellStyle)
}

extension DSCellStyleable where Self: GridViewCell {
    
    func apply(style: DSCellStyle) {
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
    
    func apply(style: DSCellStyle, in label: UILabel) {
        dsLabel.textAlignment = NSTextAlignment.center
        dsLabel.tintColor = style.titleColor.uiColor
        dsLabel.backgroundColor = style.titleBackgroundColor
            .uiColor
            .withAlphaComponent(style.titleBackgroundAlpha.value)
    }
}

extension DSCellStyleable where Self: ListViewCell {
    
    func apply(style: DSCellStyle) {
        apply(style: style, in: dsLabel)
    }
    
    func apply(style: DSCellStyle, in label: UILabel) {
        dsLabel.tintColor = style.titleColor.uiColor
        dsLabel.backgroundColor = style.titleBackgroundColor
            .uiColor
            .withAlphaComponent(style.titleBackgroundAlpha.value)
    }
}
