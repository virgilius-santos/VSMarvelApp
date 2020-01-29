
import UIKit

protocol GridRouter {
    func grid_goTo(_: CharacterViewModel)
    func grid_switchToList()
}

struct GridViewModel: CharactersViewModel {
    
    let title: String
    
    let router: GridRouter
    
    let rightButtonIcon: DSAsset = DSIcon.listIcon
    
    let placeholderSearchBar: String = "Type something here..."
    let filterOptionsSearchBar: [String] = []//["Title", "Genre", "Rating", "Actor"]
    
    let repository: CharactersRepositoryProtocol
    
    init(title: String,
         router: GridRouter,
         repository: CharactersRepositoryProtocol = CharactersRepository()) {
        self.title = title
        self.router = router
        self.repository = repository
    }
    
    func goTo(_ vm: CharacterViewModel) {
        router.grid_goTo(vm)
    }
    
    func switchView() {
        router.grid_switchToList()
    }
    
    func cellSize(from rect: CGRect) -> CGSize {
        let width: CGFloat = (rect.width / 2) - 2*DSSpacing.xxSmall.value
        return CGSize(width: width, height: width)
    }
}
