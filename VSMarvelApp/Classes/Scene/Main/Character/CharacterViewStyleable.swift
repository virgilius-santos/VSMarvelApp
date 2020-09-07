
import UIKit

protocol CharacterViewStyleable {
    var dsLabel: UILabel { get }
    var dsImageView: UIImageView { get }

    static func cellSize(from size: CGSize) -> CGSize

    func apply(style: CharacterViewStyle)
    func setup(_ vm: CharacterViewModel)
}
