
import UIKit

struct DSShadow: Equatable {
    var shadowColor: DSColor
    var shadowOpacity: DSAlpha
    var shadowRadius: DSRadius

    static var zero = DSShadow(
        shadowColor: DSColor.secondary,
        shadowOpacity: DSAlpha.zero,
        shadowRadius: DSRadius.high
    )
}
