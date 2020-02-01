
@testable import CollectionKit
@testable import Hero
import RxBlocking
import RxSwift
import RxTest
@testable import VSMarvelApp
import XCTest

class CharactersViewControllerTests: XCTestCase {
    typealias ViewController = CharactersViewController<CellView>
    typealias ViewModel = CharactersViewModelMock
    typealias CellView = CharacterViewSpy
    typealias CellViewModel = CharacterViewModel
    typealias BasicProviderData = BasicProvider<CellViewModel, CellView>

    var nav: UINavigationController!
    var sut: ViewController!
    var vm: ViewModel!

    var provider: BasicProviderData {
        (sut.collectionView.provider as! ComposedProvider).sections[0] as! BasicProviderData
    }

    var dataSource: ArrayDataSource<CellViewModel> {
        (provider.dataSource as! ArrayDataSource<CellViewModel>)
    }

    var viewSource: ClosureViewSource<CellViewModel, CellView> {
        provider.viewSource as! ClosureViewSource<CellViewModel, CellView>
    }

    var sizeSource: ClosureSizeSource<CellViewModel> {
        provider.sizeSource as! ClosureSizeSource<CellViewModel>
    }

    var dummyVM: ViewModel {
        .init()
    }

    var dummyCellVM: CellViewModel {
        CellViewModel(character: dummyCharacter)
    }

    var dummyCharacter: Character {
        Character(id: 77,
                  name: "name",
                  bio: "bio",
                  thumImage: ThumbImage(path: "thumImage",
                                        extension: "extension"))
    }

    var dummyDetailVC: DetailViewController {
        let vm = DetailViewModel(title: "title",
                                 description: "description",
                                 path: "path")
        let vc = DetailViewController(viewModel: vm)
        return vc
    }

    override func setUp() {
        vm = dummyVM
        sut = .init(viewModel: vm)
        nav = .init(rootViewController: sut)
        _ = sut.view
    }

    override func tearDown() {
        vm = nil
        sut = nil
        nav = nil
    }

    func test_searchBarTextObservable() {
        let scheduler = TestScheduler(initialClock: 0)
        let disposeBag = DisposeBag()
        let searchInputs = scheduler.createObserver(SearchInput.self)

        sut.searchBarTextObservable
            .map { SearchInput($0) }
            .bind(to: searchInputs)
            .disposed(by: disposeBag)

        scheduler.createColdObservable([.next(10, ("test", 2))])
            .subscribe(onNext: { [sut] args in
                sut?.searchBarText?(args)
            })
            .disposed(by: disposeBag)
        scheduler.start()

        XCTAssertEqual(searchInputs.events, [.next(10, SearchInput(("test", 2)))])
    }

    func test_viewDidLoad_dataSource_mustBeEmpty() {
        XCTAssert(dataSource.data.isEmpty)
    }

    func test_viewDidLoad_dataSource_dataIdentifier_mustBeCharacterName() {
        dataSource.data = [dummyCellVM]
        XCTAssertEqual(dataSource.identifier(at: 0), "name")
    }

    func test_viewDidLoad_viewSource_setup_mustConfigureView() {
        let view = CellView()
        viewSource.update(view: view, data: dummyCellVM, index: 0)
        XCTAssertEqual(view.dsLabel.text, "name\n\nbio")
        XCTAssertNotNil(view.dsImageView.image)
        XCTAssertEqual(view.dsImageView.heroID, dummyCellVM.path)
    }

    func test_viewDidLoad_sizeSource_returnSize() {
        let size = sizeSource.size(at: 0, data: dummyCellVM, collectionSize: CGSize.zero)
        XCTAssertEqual(size.width, 55.0)
        XCTAssertEqual(size.height, 66.0)
    }

    func test_viewDidLoad_provider_mustBeSeted() {
        XCTAssertNotNil(sut.collectionView.provider)
    }

    func test_viewDidLoad_searchBar_mustBeSeted() {
        XCTAssertNotNil(sut.navigationItem.searchController)
        XCTAssertFalse(sut.navigationItem.hidesSearchBarWhenScrolling)
        let search = sut.navigationItem.searchController
        XCTAssertFalse(search!.obscuresBackgroundDuringPresentation)
        let searchBar = search?.searchBar
        XCTAssertEqual(searchBar?.placeholder, "placeholderSearchBar")
        XCTAssertEqual(searchBar?.scopeButtonTitles, ["filterOptionsSearchBar"])
        XCTAssert((searchBar?.delegate as? ViewController) === sut)
    }

    func test_viewDidLoad_rightButton_mustBeSeted() {
        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem)
    }

    func test_viewDidLoad_navTitle_mustBeSeted() {
        XCTAssertEqual(sut.title, "title")
    }

    func test_viewDidLoad_loadingProvider_mustBeSeted() {
        let provider = (sut.collectionView.provider as! ComposedProvider).sections[1] as! BasicProvider<DSLoadingState, DSLoadingView>
        sut.view.frame = .init(x: 0, y: 0, width: 600, height: 600)
        let size = provider.sizeSource.size(at: 9,
                                            data: DSLoadingState.loading,
                                            collectionSize: CGSize(width: 100, height: 100))
        XCTAssertEqual(size, CGSize(width: 592.0, height: 200))
    }

    func test_rightButton_click_goToList() {
        let bt = sut.navigationItem.rightBarButtonItem
        UIApplication.shared.sendAction(bt!.action!,
                                        to: bt!.target, from: self, for: nil)

        XCTAssertTrue(vm.switch!)
    }

    func test_cell_tap_goToDetail() {
        let vmCell = dummyCellVM
        dataSource.data = [vmCell]

        let bp = BasicProviderData.TapContext(view: .init(),
                                              index: 0,
                                              dataSource: dataSource)
        provider.tapHandler?(bp)
        XCTAssertEqual(vm.vmCell, vmCell)
    }

    func test_heroWillStartAnimatingTo_withGridViewCell_noToDetailViewController() {
        let vc = CharactersViewController<GridViewCell>(viewModel: dummyVM)
        vc.heroWillStartAnimatingTo(viewController: UIViewController())
        var modifiers: [HeroModifier] {
            vc.collectionView.hero.modifiers!
        }
        XCTAssertEqual(modifiers.count, 1)
        XCTAssert(modifiers[0] === HeroModifier.cascade)
    }

    func test_heroWillStartAnimatingTo_withGridViewCell_toDetailViewController() {
        let vc = CharactersViewController<GridViewCell>(viewModel: dummyVM)
        vc.heroWillStartAnimatingTo(viewController: dummyDetailVC)
        var modifiers: [HeroModifier] {
            vc.collectionView.hero.modifiers!
        }
        XCTAssertEqual(modifiers.count, 3)
        XCTAssert(modifiers[0] === vc.scale)
        XCTAssert(modifiers[1] === HeroModifier.ignoreSubviewModifiers)
        XCTAssert(modifiers[2] === HeroModifier.fade)
    }

    func test_heroWillStartAnimatingFrom_withGridViewCell_noToDetailViewController() {
        let vc = CharactersViewController<GridViewCell>(viewModel: dummyVM)
        vc.heroWillStartAnimatingFrom(viewController: UIViewController())
        var modifiers: [HeroModifier] {
            vc.collectionView.hero.modifiers!
        }
        XCTAssertEqual(modifiers.count, 2)
        XCTAssert(modifiers[0] === HeroModifier.cascade)
        XCTAssert(modifiers[1] === vc.delay)
    }

    func test_heroWillStartAnimatingFrom_withGridViewCell_toDetailViewController() {
        let vc = CharactersViewController<GridViewCell>(viewModel: dummyVM)
        vc.heroWillStartAnimatingFrom(viewController: dummyDetailVC)
        var modifiers: [HeroModifier] {
            vc.collectionView.hero.modifiers!
        }
        XCTAssertEqual(modifiers.count, 1)
        XCTAssert(modifiers[0] === HeroModifier.cascade)
    }

    func test_heroWillStartAnimatingTo_withListViewCell_noToDetailViewController() {
        let vc = CharactersViewController<ListViewCell>(viewModel: dummyVM)
        vc.heroWillStartAnimatingTo(viewController: UIViewController())
        var modifiers: [HeroModifier] {
            vc.collectionView.hero.modifiers!
        }
        XCTAssertEqual(modifiers.count, 1)
        XCTAssert(modifiers[0] === HeroModifier.ignoreSubviewModifiers)
    }

    func test_heroWillStartAnimatingTo_withListViewCell_toDetailViewController() {
        let vc = CharactersViewController<ListViewCell>(viewModel: dummyVM)
        vc.heroWillStartAnimatingTo(viewController: dummyDetailVC)
        var modifiers: [HeroModifier] {
            vc.collectionView.hero.modifiers!
        }
        XCTAssertEqual(modifiers.count, 1)
        XCTAssert(modifiers[0] === HeroModifier.cascade)
    }

    func test_heroWillStartAnimatingFrom_withListViewCell_noToDetailViewController() {
        let vc = CharactersViewController<ListViewCell>(viewModel: dummyVM)
        vc.heroWillStartAnimatingFrom(viewController: UIViewController())
        var modifiers: [HeroModifier] {
            vc.collectionView.hero.modifiers!
        }
        XCTAssertEqual(modifiers.count, 1)
        XCTAssert(modifiers[0] === HeroModifier.ignoreSubviewModifiers)
    }

    func test_heroWillStartAnimatingFrom_withListViewCell_toDetailViewController() {
        let vc = CharactersViewController<ListViewCell>(viewModel: dummyVM)
        vc.heroWillStartAnimatingFrom(viewController: dummyDetailVC)
        var modifiers: [HeroModifier] {
            vc.collectionView.hero.modifiers!
        }
        XCTAssertEqual(modifiers.count, 1)
        XCTAssert(modifiers[0] === HeroModifier.cascade)
    }

    class DataSourceMock: DataSource<CellViewModel> {
        let data: CellViewModel

        init(data: CellViewModel) {
            self.data = data
        }

        override func data(at _: Int) -> CellViewModel {
            data
        }
    }

    class CharacterViewSpy: UIView, CharacterViewStyleable {
        var dsLabel: UILabel = .init()
        var dsImageView: UIImageView = .init()
        var style: CharacterViewStyle?

        func apply(style: CharacterViewStyle) {
            self.style = style
        }
    }

    class CharactersViewModelMock: CharactersViewModel {
        var title: String = "title"
        var rightButtonIcon: DSAsset = DSIcon.image10
        var placeholderSearchBar: String = "placeholderSearchBar"
        var filterOptionsSearchBar: [String] = ["filterOptionsSearchBar"]

        var vmCell: CharacterViewModel?
        var `switch`: Bool?
        var rect: CGRect?

        func goTo(_ vm: CharacterViewModel) {
            vmCell = vm
        }

        func switchView() {
            self.switch = true
        }

        func cellSize(from rect: CGRect) -> CGSize {
            self.rect = rect
            return CGSize(width: 55, height: 66)
        }

        func bind(input _: CharactersInput) -> CharactersOutput {
            .init(cellViewModel: .never(),
                  loading: .never(),
                  resetData: .never(),
                  disposable: Disposables.create())
        }
    }

    struct SearchInput: Equatable {
        let text: String?
        let filter: Int
        init(_ value: (text: String?, filter: Int)) {
            text = value.text
            filter = value.filter
        }
    }
}
