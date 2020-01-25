
import UIKit

protocol DSCharactersViewModel {
    var title: String { get }
    var rightButtonIcon: DSAsset  { get }
    var placeholderSearchBar: String  { get }
    var filterOptionsSearchBar: [String]  { get }
    
    func goTo(_ vm: DSCharacterViewModel)
    func switchView()
    func cellSize(from rect: CGRect) -> CGSize
}

protocol DSCharacterViewModel {
    var name: String { get }
    var asset: DSAsset { get }
    var style: DSCellStyle { get }
}
