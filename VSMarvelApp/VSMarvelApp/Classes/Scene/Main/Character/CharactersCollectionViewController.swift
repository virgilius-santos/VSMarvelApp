
import CollectionKit
import Hero
import RxCocoa
import RxSwift
import UIKit
import VCore

typealias GridViewController = CharactersCollectionViewController<GridViewCell>
typealias ListViewController = CharactersCollectionViewController<ListViewCell>

final class CharactersCollectionViewController<CharacterView: UIView>: DSCollectionViewController, HeroViewControllerDelegate where CharacterView: CharacterViewStyleable {
    typealias ViewModel = CharactersCollectionViewModelProtocol

    let viewModel: ViewModel

    let scale = HeroModifier.scale(3)
    let delay = HeroModifier.delay(0.2)

    let disposeBag = DisposeBag()

    init(viewModel: ViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = DSColor.secondary.uiColor

        let cellProvider: CharactersCollectionViewProvider<CharacterView>

        let loadingProvider = LoadingViewProvider(sizeSource: { [weak self] in
            guard let self = self else { return CGSize.zero }
            return CGSize(width: self.view.frame.width - 2 * DSSpacing.xxSmall.value,
                          height: self.view.frame.width / 3)
        })

        let finalProvider: ComposedProvider

        Layout: do {
            let sizeSource = { (frame) -> CGSize in
                CharacterView.cellSize(from: frame)
            }

            let tapHandler: ((CharacterViewModel) -> Void) = { [weak self] cellVM in
                self?.viewModel.goTo(cellVM)
            }

            cellProvider = CharactersCollectionViewProvider<CharacterView>(
                sizeSource: sizeSource,
                tapHandler: tapHandler
            )

            finalProvider = ComposedProvider(sections: [cellProvider.provider])
            collectionView.provider = finalProvider
        }

        SearchBar: do {
            configureRightButton(
                with: viewModel.rightButtonIcon.image,
                target: self,
                action: #selector(rightButtonAction)
            )
        }

        Data: do {
            title = viewModel.title
        }

        Rx: do {
            let searchController = addSearchBar(
                placeholder: viewModel.placeholderSearchBar,
                scopeButtonTitles: viewModel.filterOptionsSearchBar
            )

            let bookmarkButtonClicked = searchController.searchBar
                .rx
                .searchButtonClicked
                .asObservable()

            let text = searchController.searchBar
                .rx
                .text
                .asObservable()

            let input = CharactersInput(
                searchClick: bookmarkButtonClicked,
                text: text,
                currentIndex: cellProvider.currentIndex,
                reload: loadingProvider.tap
            )

            let output = viewModel.bind(input: input)

            output.cellViewModel
                .subscribe(onNext: { (listCellVM: [CharacterViewModel]) in
                    cellProvider.dataSource.data = listCellVM
                })
                .disposed(by: disposeBag)

            output.loading
                .subscribe(onNext: { state in

                    let noContainsLooadingProvider = finalProvider.sections.count == 1
                    switch state {
                    case .loading:
                        if noContainsLooadingProvider {
                            finalProvider.sections.append(loadingProvider.provider)
                        }
                        loadingProvider.dataSource.data = [LoadingState.loading]
                    case .error:
                        if noContainsLooadingProvider {
                            finalProvider.sections.append(loadingProvider.provider)
                        }
                        loadingProvider.dataSource.data = [LoadingState.error]
                    case .normal:
                        if !noContainsLooadingProvider {
                            finalProvider.sections = [cellProvider.provider]
                        }
                        loadingProvider.dataSource.data = [LoadingState.normal]
                    }
                })
                .disposed(by: disposeBag)

            output.resetData
                .subscribe(onNext: {
                    cellProvider.dataSource.data = []
                })
                .disposed(by: disposeBag)

            output.disposable
                .disposed(by: disposeBag)
        }
    }

    @objc func rightButtonAction() {
        viewModel.switchView()
    }
}

extension CharactersCollectionViewController where CharacterView == GridViewCell {
    func heroWillStartAnimatingTo(viewController: UIViewController) {
        if viewController is DetailViewController {
            collectionView.hero.modifiers = [scale,
                                             HeroModifier.ignoreSubviewModifiers,
                                             HeroModifier.fade]
        } else {
            collectionView.hero.modifiers = [HeroModifier.cascade]
        }
    }

    func heroWillStartAnimatingFrom(viewController: UIViewController) {
        if viewController is DetailViewController {
            collectionView.hero.modifiers = [HeroModifier.cascade]
        } else {
            collectionView.hero.modifiers = [HeroModifier.cascade,
                                             delay]
        }
    }
}

extension CharactersCollectionViewController where CharacterView == ListViewCell {
    func heroWillStartAnimatingTo(viewController: UIViewController) {
        if viewController is DetailViewController {
            collectionView.hero.modifiers = [.cascade]
        } else {
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
