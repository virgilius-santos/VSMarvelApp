
import XCTest
@testable import VSMarvelApp
@testable import CollectionKit
@testable import Hero

class GridViewControllerTests: XCTestCase {

    typealias ViewController = GridViewController
    typealias ViewModel = ViewController.ViewModel
    typealias CellView = ViewController.CellView
    typealias CellViewModel = ViewController.CellViewModel
    typealias BasicProviderData = BasicProvider<CellViewModel, CellView>
    
    var nav: UINavigationController!
    var spy: RouterSpy!
    var sut: ViewController!
    
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
    
    var dummyVM: ViewModel {
        return GridViewModel(title: "a", router: spy)
    }
    
    var dummyCellVM: CellViewModel {
        return GridViewModel.CellViewModel(asset: DSImage.image1,
                                           name: "b",
                                           style: DSCellStyle.default)
    }
    
    var dummyDetailVC: DetailViewController {
        let vm = DetailViewModel(title: "c", description: "d", asset: DSImage.image1)
        let vc = DetailViewController(viewModel: vm)
        return vc
    }
    
    override func setUp() {
        spy = .init()
        sut = .init(viewModel: GridViewModel(title: "a", router: spy))
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
        XCTAssertEqual(view.dsLabel.text, dummyCellVM.name)
        XCTAssertEqual(view.dsImageView.image, dummyCellVM.asset.image)
    }
    
    func test_viewDidLoad_sizeSource_returnSize() {
        let size = sizeSource.size(at: 0, data: dummyCellVM, collectionSize: CGSize.zero)
        XCTAssertEqual(size.width, (sut.view.frame.width / 2) - 2*DSSpacing.xxSmall.value)
        XCTAssertEqual(size.height, size.width)
    }
    
    func test_viewDidLoad_viewModel_mustBeRequestData() {
        
    }
    
    func test_viewDidLoad_provider_mustBeSeted() {
        XCTAssertNotNil(sut.collectionView.provider)
    }
    
    func test_viewDidLoad_searchBar_mustBeSeted() {
        XCTAssertNotNil(sut.navigationItem.searchController)
        XCTAssertFalse(sut.navigationItem.hidesSearchBarWhenScrolling)
        let search = sut.navigationItem.searchController
        XCTAssertFalse(search!.obscuresBackgroundDuringPresentation)
        XCTAssertEqual(search?.searchResultsUpdater as? ViewController, sut)
        let searchBar = search?.searchBar
        XCTAssertEqual(searchBar?.placeholder, sut.viewModel.placeholderSearchBar)
        XCTAssertEqual(searchBar?.scopeButtonTitles, sut.viewModel.filterOptionsSearchBar)
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
        
        
        XCTAssertTrue(spy.grid_switchToListSpy!)
    }
    
    func test_cell_tap_goToDetail() {
        
        dataSource.data = [dummyCellVM]
        
        let bp = BasicProviderData.TapContext(view: .init(),
                                              index: 0,
                                              dataSource: dataSource)
        provider.tapHandler?(bp)
        XCTAssertEqual(spy?.detail?.title, dummyCellVM.name)
    }
    
    func test_heroWillStartAnimatingTo_noToDetailViewController() {
        sut.heroWillStartAnimatingTo(viewController: UIViewController())
        XCTAssertEqual(modifiers.count, 1)
        XCTAssert(modifiers[0] === HeroModifier.cascade)
    }
    
    func test_heroWillStartAnimatingTo_toDetailViewController() {
        sut.heroWillStartAnimatingTo(viewController: dummyDetailVC)
        XCTAssertEqual(modifiers.count, 3)
        XCTAssert(modifiers[0] === sut.scale)
        XCTAssert(modifiers[1] === HeroModifier.ignoreSubviewModifiers)
        XCTAssert(modifiers[2] === HeroModifier.fade)
    }
    
    func test_heroWillStartAnimatingFrom_noToDetailViewController() {
        sut.heroWillStartAnimatingFrom(viewController: UIViewController())
        XCTAssertEqual(modifiers.count, 2)
        XCTAssert(modifiers[0] === HeroModifier.cascade)
        XCTAssert(modifiers[1] === sut.delay)
    }
    
    func test_heroWillStartAnimatingFrom_toDetailViewController() {
        sut.heroWillStartAnimatingFrom(viewController: dummyDetailVC)
        XCTAssertEqual(modifiers.count, 1)
        XCTAssert(modifiers[0] === HeroModifier.cascade)
    }
    
    func dataMock(index: Int) -> CellViewModel? {
        return dataSource.data(at: index)
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
