
import UIKit

struct DSCellStyle {
    
    var titleColor: DSColor
    var titleBackgroundColor: DSColor
    var titleBackgroundAlpha: DSAlpha
    var cornerRadius: DSRadius
    var shadow: DSShadow
    
    static let `default` = DSCellStyle(titleColor: DSColor.text,
                                       titleBackgroundColor: DSColor.secondary,
                                       titleBackgroundAlpha: DSAlpha.medium,
                                       cornerRadius: DSRadius.medium,
                                       shadow: DSShadow.zero)
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
