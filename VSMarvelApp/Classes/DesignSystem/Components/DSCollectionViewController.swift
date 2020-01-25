
import UIKit
import CollectionKit
import SnapKit

class DSCollectionViewController: UIViewController, DSNavigationBarStyleable, DSNavigationBarConfigurable, UISearchResultsUpdating {
    
    let collectionView = CollectionView()
    
    var provider: Provider? {
        get { return collectionView.provider }
        set { collectionView.provider = newValue }
    }
    
    var searchBarText: (((text: String?, filter: Int))->())?
    
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
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let text = searchBar.text
        let index = searchBar.selectedScopeButtonIndex
        searchBarText?((text, index))
    }
}
