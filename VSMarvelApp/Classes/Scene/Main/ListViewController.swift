
import UIKit
import CollectionKit
import Hero
import VCore
import RxCocoa
import RxSwift

class ListViewController: DSCollectionViewController {
    
    typealias ViewModel = DSCharactersViewModel
    typealias CellView = DSCharacterListTableViewCell
    typealias CellViewModel = DSCharacterViewModel
    
    let viewModel: ViewModel
    let disposeBag = DisposeBag()
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        logger.info("fuii", String(describing: Self.self))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Layout: do {
            
            let dataSource = ArrayDataSource(
                data: [],
                identifierMapper: { (index: Int, data: CellViewModel) in return data.name }
            )
            
            let viewSource = ClosureViewSource(
                viewUpdater: { (view: CellView, data: CellViewModel, index: Int) in
                    view.setup(data)
            })
            
            let sizeSource = { [weak self] (index: Int, data: CellViewModel, collectionSize: CGSize) -> CGSize in
                guard let self = self else { return CGSize.zero }
                return self.viewModel.cellSize(from: self.view.frame)
            }
            
            let provider = BasicProvider(
                dataSource: dataSource,
                viewSource: viewSource,
                sizeSource: sizeSource,
                animator: WobbleAnimator()
            )
            
            let inset = UIEdgeInsets(top: DSSpacing.xxSmall.value,
                                     left: DSSpacing.xxSmall.value,
                                     bottom: DSSpacing.xxSmall.value,
                                     right: DSSpacing.xxSmall.value)
            provider.layout = FlowLayout(spacing: DSSpacing.xxSmall.value,
                                         justifyContent: JustifyContent.spaceAround)
                .inset(by: inset)
            
            provider.tapHandler = { [viewModel] context in
                viewModel.goTo(context.data)
            }
            
            //lastly assign this provider to the collectionView to display the content
            collectionView.provider = provider
        }
        
        SearchBar: do {
            addSearchBar(placeholder: viewModel.placeholderSearchBar,
                         scopeButtonTitles: viewModel.filterOptionsSearchBar)
            configureRightButton(with: viewModel.rightButtonIcon.image,
                                 target: self,
                                 action: #selector(rightButtonAction))
        }
        
        Data: do {
            title = viewModel.title
        }
    }
    
    @objc func rightButtonAction() {
        viewModel.switchView()
    }
}

extension ListViewController: HeroViewControllerDelegate {
    
    func heroWillStartAnimatingTo(viewController: UIViewController) {
        if viewController is DetailViewController {
            collectionView.hero.modifiers = [.cascade]
        }
        else {
            collectionView.hero.modifiers = [.ignoreSubviewModifiers]
        }
    }
    
    func heroWillStartAnimatingFrom(viewController: UIViewController) {
        if viewController is DetailViewController {
            collectionView.hero.modifiers = [.cascade]
        } else {
            collectionView.hero.modifiers = [.ignoreSubviewModifiers]
        }
    }
}
