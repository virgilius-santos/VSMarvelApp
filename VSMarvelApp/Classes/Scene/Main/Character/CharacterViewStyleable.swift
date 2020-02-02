
import UIKit

protocol CharacterViewStyleable {
    var dsLabel: UILabel { get }
    var dsImageView: UIImageView { get }

    func apply(style: CharacterViewStyle)
    func setup(_ vm: CharacterViewModel)

    static func cellSize(from size: CGSize) -> CGSize
}
