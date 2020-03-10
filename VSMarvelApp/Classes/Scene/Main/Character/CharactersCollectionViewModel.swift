
import RxSwift
import UIKit

typealias CharactersViewModelData = [CharacterViewModel]

protocol CharactersCollectionViewModelProtocol {
    var title: String { get }
    var rightButtonIcon: DSAsset { get }
    var placeholderSearchBar: String { get }
    var filterOptionsSearchBar: [String] { get }

    func bind(input: CharactersInput) -> CharactersOutput

    func goTo(_ vm: CharacterViewModel)
    func switchView()
}

struct CharactersInput {
    let text: Observable<(text: String?, filter: Int)>
    let currentIndex: Observable<Int>
    let reload: Observable<Void>
}

struct CharactersOutput {
    let cellViewModel: Observable<[CharacterViewModel]>
    let loading: Observable<LoadingState>
    let resetData: Observable<Void>
    let disposable: Disposable
}

class CharactersCollectionViewModel: CharactersCollectionViewModelProtocol {
    enum ViewModelType {
        case list, grid

        var icon: DSAsset {
            switch self {
            case .grid:
                return DSIcon.listIcon
            case .list:
                return DSIcon.gridIcon
            }
        }
    }

    var rightButtonIcon: DSAsset { viewModelType.icon }

    var repository: CharactersRepositoryProtocol { CharactersRepository() }

    var title: String { "Characters" }

    var placeholderSearchBar: String { "Type something here..." }

    var filterOptionsSearchBar: [String] { [String]() } // ["Title", "Genre", "Rating", "Actor"]

    var viewModelType: ViewModelType

    var switchToList: ((_ vm: CharactersCollectionViewModel) -> Void)?
    var switchToGrid: ((_ vm: CharactersCollectionViewModel) -> Void)?
    var goToDetail: ((_ vm: CharacterViewModel) -> Void)?

    let pageController = CharactersPageController()

    init(type: ViewModelType) {
        viewModelType = type
        pageController.provider = loadCharacters
    }

    func switchView() {
        switch viewModelType {
        case .grid:
            switchToList?(self)
        case .list:
            switchToGrid?(self)
        }
    }

    func goTo(_ vm: CharacterViewModel) {
        goToDetail?(vm)
    }

    func bind(input: CharactersInput) -> CharactersOutput {
        let disposableNextIndex = input.currentIndex
            .bind(to: pageController.currentIndex)

        let disposableNextFilter = input.text
            .map { $0.text }
            .bind(to: pageController.currentFilter)

        let disposables = Disposables
            .create([
                disposableNextIndex,
                disposableNextFilter,
            ])

        return CharactersOutput(
            cellViewModel: pageController.cellsViewModel,
            loading: pageController.loading,
            resetData: pageController.resetData,
            disposable: disposables
        )
    }

    func loadCharacters(
        loading: BehaviorSubject<LoadingState>,
        number: Int,
        name: String? = nil
    ) -> Observable<CharactersViewModelData> {
        repository
            .getCharacters(number: number, name: name)
            .map { $0.map { character in CharacterViewModel(character: character) } }
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .do(onSuccess: { _ in loading.onNext(LoadingState.normal) },
                onError: { _ in loading.onNext(LoadingState.error) },
                onSubscribed: { loading.onNext(LoadingState.loading) })
            .catchErrorJustReturn([])
            .asObservable()
    }
}
