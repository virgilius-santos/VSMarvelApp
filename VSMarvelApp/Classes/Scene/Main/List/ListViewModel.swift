
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
                                     description: vm.bio,
                                     path: vm.path)
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