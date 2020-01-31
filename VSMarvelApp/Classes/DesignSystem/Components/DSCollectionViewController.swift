
import CollectionKit
import SnapKit
import UIKit

class DSCollectionViewController: UIViewController, DSNavigationBarStyleable, DSNavigationBarConfigurable, UISearchResultsUpdating, UISearchBarDelegate {
    let collectionView = CollectionView()

    var provider: Provider? {
        get { collectionView.provider }
        set { collectionView.provider = newValue }
    }

    var searchBarText: (((text: String?, filter: Int)) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        NavBar: do {
            apply(style: .default)
        }

        Collection: do {
            view.addSubview(collectionView)
            collectionView.snp.makeConstraints {
                $0.edges.equalTo(self.view.safeAreaLayoutGuide)
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    func updateSearchResults(for _: UISearchController) {
//        let searchBar = searchController.searchBar
//        let text = searchBar.text
//        let index = searchBar.selectedScopeButtonIndex
//        searchBarText?((text, index))
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text
        let index = searchBar.selectedScopeButtonIndex
        searchBarText?((text, index))
    }
}
