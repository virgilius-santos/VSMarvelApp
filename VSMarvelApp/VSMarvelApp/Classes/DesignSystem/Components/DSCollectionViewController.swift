
import CollectionKit
import SnapKit
import UIKit

class DSCollectionViewController: UIViewController, UISearchBarDelegate {
    let collectionView = CollectionView(frame: UIScreen.main.bounds)

    var provider: Provider? {
        get { collectionView.provider }
        set { collectionView.provider = newValue }
    }

    var searchBarText: (((text: String?, filter: Int)) -> Void)?

    override func loadView() {
        view = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NavBar: do {
            apply(style: .default)
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text
        let index = searchBar.selectedScopeButtonIndex
        searchBarText?((text, index))
    }
}
