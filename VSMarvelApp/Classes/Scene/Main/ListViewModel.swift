
import UIKit
import RxSwift

protocol ListRouter {
    func list_goTo(_: DetailViewModel)
    func list_switchToGrid()
}

struct ListViewModel: DSCharactersViewModel {
    
    struct CellViewModel: DSCharacterViewModel {
        let asset: DSAsset
        let name: String
        let style: DSCellStyle
    }
    
    let title: String
    
    let router: ListRouter
    
    let rightButtonIcon: DSAsset = DSIcon.gridIcon
    
    let placeholderSearchBar: String = "Type something here..."
    let filterOptionsSearchBar: [String] = ["Title", "Genre", "Rating", "Actor"]
    
    let searchBarText = BehaviorSubject<String?>(value: "")
    
    let cells: [CellViewModel] = [
        CellViewModel(asset: DSImage.image1, name: "image1", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image10, name: "image10", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image11, name: "image11", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image12, name: "image12", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image13, name: "image13", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image14, name: "image14", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image15, name: "image15", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image16, name: "image16", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image17, name: "image17", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image18, name: "image18", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image19, name: "image19", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image2, name: "image2", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image20, name: "image20", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image21, name: "image21", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image22, name: "image22", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image23, name: "image23", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image24, name: "image24", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image25, name: "image25", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image26, name: "image26", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image27, name: "image27", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image28, name: "image28", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image29, name: "image29", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image3, name: "image3", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image30, name: "image30", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image4, name: "image4", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image5, name: "image5", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image6, name: "image6", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image7, name: "image7", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image8, name: "image8", style: DSCellStyle.default),
        CellViewModel(asset: DSImage.image9, name: "image9", style: DSCellStyle.default),
        ].sorted(by: { $0.name < $1.name })
    
    func goTo(_ vm: DSCharacterViewModel) {
        let detail = DetailViewModel(title: vm.name,
                                     description: "Bitten by a radioactive spider, high school student Peter Parker gained the speed, strength and powers of a spider. Adopting the name Spider-Man, Peter hoped to start a career using his new abilities. Taught that with great power comes great responsibility, Spidey has vowed to use his powers to help people.",
                                     asset: vm.asset)
        router.list_goTo(detail)
    }
    
    func switchView() {
        router.list_switchToGrid()
    }
    
    func cellSize(from rect: CGRect) -> CGSize {
        let width: CGFloat = (rect.width) - 2*DSSpacing.xxSmall.value
        return CGSize(width: width, height: width/3)
    }
}
