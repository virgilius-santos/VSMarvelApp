
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
