
import UIKit

protocol ListRouter {
    func list_goTo(_: DetailViewModel)
    func list_switchToGrid()
}

struct ListViewModel: CharactersViewModel {
    
    let title: String
    
    let router: ListRouter
    
    let rightButtonIcon: DSAsset = DSIcon.gridIcon
    
    let placeholderSearchBar: String = "Type something here..."
    let filterOptionsSearchBar: [String] = []//["Title", "Genre", "Rating", "Actor"]
        
    let repository: CharactersRepositoryProtocol
    
    init(title: String,
         router: ListRouter,
         repository: CharactersRepositoryProtocol = CharactersRepository()) {
        self.title = title
        self.router = router
        self.repository = repository
    }
    
    func goTo(_ vm: CharacterViewModel) {
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
