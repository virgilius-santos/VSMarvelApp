
import CollectionKit
import SnapKit
import UIKit

class DSCollectionViewController: UIViewController {
    let collectionView = CollectionView(frame: UIScreen.main.bounds)

    var provider: Provider? {
        get { collectionView.provider }
        set { collectionView.provider = newValue }
    }

    override func loadView() {
        view = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NavBar: do {
            apply(style: .default)
        }
    }
}
