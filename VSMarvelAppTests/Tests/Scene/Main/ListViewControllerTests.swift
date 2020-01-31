
@testable import CollectionKit
@testable import Hero
@testable import VSMarvelApp
import XCTest

class ListViewControllerTests: XCTestCase {
    typealias ViewController = CharactersViewController<ListViewCell>
    typealias ViewModel = ViewController.ViewModel
    typealias CellView = ListViewCell
    typealias CellViewModel = CharacterViewModel
    typealias BasicProviderData = BasicProvider<CellViewModel, CellView>

    var nav: UINavigationController!
    var spy: RouterSpy!
    var sut: ViewController!

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

    var modifiers: [HeroModifier] {
        sut.collectionView.hero.modifiers!
    }

    var dummyVM: ViewModel {
        ListViewModel(title: "a", router: spy)
    }

    var dummyCellVM: CellViewModel {
        CellViewModel(character: dummyCharacter)
    }

    var dummyCharacter: Character {
        Character(id: 0,
                  name: "a",
                  bio: "b",
                  thumImage: ThumbImage(path: "c",
                                        extension: "jpg"))
    }

    var dummyDetailVC: DetailViewController {
        let vm = DetailViewModel(title: "c", description: "d", path: "arte")
        let vc = DetailViewController(viewModel: vm)
        return vc
    }

    override func setUp() {
        spy = .init()
        sut = .init(viewModel: dummyVM)
        nav = .init(rootViewController: sut)
        _ = sut.view
    }

    override func tearDown() {
        spy = nil
        sut = nil
    }

    func test_viewDidLoad_dataSource_mustBeEmpty() {
        XCTAssert(dataSource.data.isEmpty)
    }

    func test_viewDidLoad_dataSource_dataIdentifier_mustBeCharacterName() {
        dataSource.data = [dummyCellVM]
        XCTAssertEqual(dataSource.identifier(at: 0), dummyCellVM.name)
    }

    func test_viewDidLoad_viewSource_setup_mustConfigureView() {
        let view = CellView()
        viewSource.update(view: view, data: dummyCellVM, index: 0)
        XCTAssertEqual(view.dsLabel.text, "a\n\nb")
        XCTAssertNotNil(view.dsImageView.image)
    }

    func test_viewDidLoad_sizeSource_returnSize() {
        let size = sizeSource.size(at: 0, data: dummyCellVM, collectionSize: CGSize.zero)
        XCTAssertEqual(size.width, sut.view.frame.width - 2 * DSSpacing.xxSmall.value)
        XCTAssertEqual(size.height, size.width / 3)
    }

    func test_viewDidLoad_viewModel_mustBeRequestData() {}

    func test_viewDidLoad_provider_mustBeSeted() {
        XCTAssertNotNil(sut.collectionView.provider)
    }

    func test_viewDidLoad_searchBar_mustBeSeted() {
        XCTAssertNotNil(sut.navigationItem.searchController)
        XCTAssertFalse(sut.navigationItem.hidesSearchBarWhenScrolling)
        let search = sut.navigationItem.searchController!
        XCTAssertFalse(search.obscuresBackgroundDuringPresentation)
        let searchBar = search.searchBar
        XCTAssertEqual(searchBar.placeholder, sut.viewModel.placeholderSearchBar)
        XCTAssertEqual(searchBar.scopeButtonTitles, sut.viewModel.filterOptionsSearchBar)
        XCTAssertEqual(searchBar.delegate as? ViewController, sut)
    }

    func test_viewDidLoad_rightButton_mustBeSeted() {
        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem)
    }

    func test_viewDidLoad_navTitle_mustBeSeted() {
        XCTAssertEqual(sut.title, "a")
    }

    func test_rightButton_click_goToList() {
        let bt = sut.navigationItem.rightBarButtonItem
        UIApplication.shared.sendAction(bt!.action!,
                                        to: bt!.target, from: self, for: nil)

        XCTAssertTrue(spy.list_switchToGridSpy!)
    }

    func test_cell_tap_goToDetail() {
        dataSource.data = [dummyCellVM]

        let bp = BasicProviderData.TapContext(view: .init(),
                                              index: 0,
                                              dataSource: dataSource)
        provider.tapHandler?(bp)
        XCTAssertEqual(spy?.detail?.name, dummyCellVM.name)
    }

    func test_heroWillStartAnimatingTo_noToDetailViewController() {
        sut.heroWillStartAnimatingTo(viewController: UIViewController())
        XCTAssertEqual(modifiers.count, 1)
        XCTAssert(modifiers[0] === HeroModifier.ignoreSubviewModifiers)
    }

    func test_heroWillStartAnimatingTo_toDetailViewController() {
        sut.heroWillStartAnimatingTo(viewController: dummyDetailVC)
        XCTAssertEqual(modifiers.count, 1)
        XCTAssert(modifiers[0] === HeroModifier.cascade)
    }

    func test_heroWillStartAnimatingFrom_noToDetailViewController() {
        sut.heroWillStartAnimatingFrom(viewController: UIViewController())
        XCTAssertEqual(modifiers.count, 1)
        XCTAssert(modifiers[0] === HeroModifier.ignoreSubviewModifiers)
    }

    func test_heroWillStartAnimatingFrom_toDetailViewController() {
        sut.heroWillStartAnimatingFrom(viewController: dummyDetailVC)
        XCTAssertEqual(modifiers.count, 1)
        XCTAssert(modifiers[0] === HeroModifier.cascade)
    }

    func dataMock(index: Int) -> CellViewModel? {
        dataSource.data(at: index)
    }

    class RouterSpy: ListRouter {
        var list_switchToGridSpy: Bool?
        var detail: CharacterViewModel?

        func list_goTo(_ vm: CharacterViewModel) {
            detail = vm
        }

        func list_switchToGrid() {
            list_switchToGridSpy = true
        }
    }
}
