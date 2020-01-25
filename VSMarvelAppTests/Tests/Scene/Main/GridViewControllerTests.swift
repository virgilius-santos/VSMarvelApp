
import XCTest
@testable import VSMarvelApp
@testable import CollectionKit
@testable import Hero

class GridViewControllerTests: XCTestCase {

    typealias ViewController = GridViewController
    typealias CellView = ViewController.CellView
    typealias CellViewModel = ViewController.CellViewModel
    typealias BasicProviderData = BasicProvider<CellViewModel, CellView>
    
    var nav: UINavigationController!
    var spy: RouterSpy!
    var sut: ViewController!
    
    override func setUp() {
        spy = .init()
        sut = .init(viewModel: GridViewModel(title: "a", router: spy))
        nav = .init(rootViewController: sut)
        _ = sut.view
    }

    var provider: BasicProviderData {
        return (sut.collectionView.provider as! BasicProviderData)
    }
    
    var dataSource: ArrayDataSource<CellViewModel> {
        return (provider.dataSource as! ArrayDataSource<CellViewModel>)
    }
    
    var viewSource: ClosureViewSource<CellViewModel, CellView> {
        return provider.viewSource as! ClosureViewSource<CellViewModel, CellView>
    }
    
    var sizeSource: ClosureSizeSource<CellViewModel> {
        return provider.sizeSource as! ClosureSizeSource<CellViewModel>
    }
    
    var modifiers: [HeroModifier] {
        return sut.collectionView.hero.modifiers!
    }
    
    var dummyCellVM: CellViewModel {
        return GridViewModel.CellViewModel(asset: DSImage.image1,
                                           name: "a",
                                           style: DSCellStyle.default)
    }
    
    var dummyDetailVC: DetailViewController {
        let vm = DetailViewModel(title: "", description: "", asset: DSImage.image1)
        let vc = DetailViewController(viewModel: vm)
        return vc
    }
    
    override func tearDown() {
        spy = nil
        sut = nil
    }

    func testProviderMustBeSeted() {
        XCTAssertNotNil(sut.collectionView.provider)
    }
    
    
    func testSearchBarMustBeSeted() {
        XCTAssertNotNil(sut.navigationItem.searchController)
        XCTAssertFalse(sut.navigationItem.hidesSearchBarWhenScrolling)
        let search = sut.navigationItem.searchController
        XCTAssertFalse(search!.obscuresBackgroundDuringPresentation)
        XCTAssertEqual(search?.searchResultsUpdater as? GridViewController, sut)
        let searchBar = search?.searchBar
        XCTAssertEqual(searchBar?.placeholder, sut.viewModel.placeholderSearchBar)
        XCTAssertEqual(searchBar?.scopeButtonTitles, sut.viewModel.filterOptionsSearchBar)
    }
    
    func testRightButtonMustBeSeted() {
        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem)
    }
    
    func testTitleMustBeSeted() {
        XCTAssertEqual(sut.title, "a")
    }
    
    func testWhenRightButtonTappedMustGoToList() {
        let bt = sut.navigationItem.rightBarButtonItem
        UIApplication.shared.sendAction(bt!.action!,
                                        to: bt!.target, from: self, for: nil)

        
        XCTAssertTrue(spy.grid_switchToListSpy!)
    }
    
    func testWhenCellTappedMustGoToDetail() {
        let dt = DataSourceMock(data: dummyCellVM)
        let bp = BasicProviderData.TapContext(view: .init(),
                                              index: 0,
                                              dataSource: dt)
        (sut?.collectionView.provider as? BasicProviderData)?.tapHandler?(bp)
        XCTAssertEqual(spy?.detail?.title, dummyCellVM.name)
    }
    
    func testWhenAnimateToOthersViewControllers() {
        sut.heroWillStartAnimatingTo(viewController: UIViewController())
        XCTAssertEqual(sut.collectionView.hero.modifiers?.count, 1)
        XCTAssert(sut.collectionView.hero.modifiers?[0] === HeroModifier.cascade)
    }
    
    func testWhenAnimateToDetailViewControllers() {
        let vm = DetailViewModel(title: "", description: "", asset: DSImage.image1)
        let vc = DetailViewController(viewModel: vm)
        sut.heroWillStartAnimatingTo(viewController: vc)
        XCTAssertEqual(sut.collectionView.hero.modifiers?.count, 3)
        XCTAssert(sut.collectionView.hero.modifiers?[0] === sut.scale)
        XCTAssert(sut.collectionView.hero.modifiers?[1] === HeroModifier.ignoreSubviewModifiers)
        XCTAssert(sut.collectionView.hero.modifiers?[2] === HeroModifier.fade)
    }
    
    func testWhenAnimateFromOthersViewControllers() {
        sut.heroWillStartAnimatingFrom(viewController: UIViewController())
        XCTAssertEqual(sut.collectionView.hero.modifiers?.count, 2)
        XCTAssert(sut.collectionView.hero.modifiers?[0] === HeroModifier.cascade)
        XCTAssert(sut.collectionView.hero.modifiers?[1] === sut.delay)
    }
    
    func testWhenAnimateFromGridViewControllers() {
        let vm = DetailViewModel(title: "", description: "", asset: DSImage.image1)
        let vc = DetailViewController(viewModel: vm)
        sut.heroWillStartAnimatingFrom(viewController: vc)
        XCTAssertEqual(sut.collectionView.hero.modifiers?.count, 1)
        XCTAssert(sut.collectionView.hero.modifiers?[0] === HeroModifier.cascade)
    }
    
    class DataSourceMock: DataSource<CellViewModel> {
        
        let data: CellViewModel
        
        init(data: CellViewModel) {
            self.data = data
        }
        override func data(at: Int) -> CellViewModel {
            return data
        }
    }
    
    class RouterSpy: GridRouter {
        
        var grid_switchToListSpy: Bool?
        var detail: DetailViewModel?
        
        func grid_goTo(_ vm: DetailViewModel) {
            detail = vm
        }
        
        func grid_switchToList() {
            grid_switchToListSpy = true
        }
    }
}
