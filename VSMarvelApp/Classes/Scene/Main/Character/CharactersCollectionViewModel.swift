
import RxSwift
import UIKit

protocol CharactersRouter {
    func switchToList(_ vm: CharactersCollectionViewModel)
    func switchToGrid(_ vm: CharactersCollectionViewModel)
    func goToDetail(_ vm: CharacterViewModel)
}

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

    let router: CharactersRouter

    init(type: ViewModelType, router: CharactersRouter) {
        viewModelType = type
        self.router = router
    }

    func switchView() {
        switch viewModelType {
        case .grid:
            router.switchToList(self)
        case .list:
            router.switchToGrid(self)
        }
    }

    func goTo(_ vm: CharacterViewModel) {
        router.goToDetail(vm)
    }

    func bind(input: CharactersInput) -> CharactersOutput {
        let loading = BehaviorSubject<LoadingState>(value: LoadingState.loading)
        let loadNextPage = PublishSubject<Void>()
        let reloadNextPage = PublishSubject<Void>()

        let searchText = input.text
            .startWith((text: nil, filter: -1))
            .map { $0.text }
            .distinctUntilChanged()
            .share(replay: 1, scope: .whileConnected)

        let cellsViewModel = searchText
            .flatMapLatest { searchText in

                loadNextPage
                    .asObservable()
                    .startWith(())
                    .scan(-1) { (pageNumber, _) -> Int in
                        pageNumber + 1
                    }
                    .map { pageNumber in
                        (searchText, pageNumber)
                    }
            }
            .flatMapLatest { searchText, pageNumber in

                reloadNextPage
                    .asObservable()
                    .startWith(())
                    .map { (searchText, pageNumber) }
            }
            .flatMapLatest { [loadCharacters] (searchText, pageNumber) -> Observable<[CharacterViewModel]> in
                loadCharacters(loading, pageNumber, searchText)
            }

        let disposableNextPage = searchText
            .flatMapLatest { _ in

                input.currentIndex
                    .startWith(0)
                    .scan(0, accumulator: { ($0 < $1 && $1 % 19 == 0) ? $1 : $0 })
                    .distinctUntilChanged()
            }
            .subscribe(onNext: { _ in loadNextPage.onNext(()) })

        let resetData = searchText
            .map { _ in }

        let reloadDisposable = input.reload
            .subscribe(onNext: { _ in reloadNextPage.onNext(()) })

        let disposables = Disposables
            .create([disposableNextPage, reloadDisposable])

        return CharactersOutput(
            cellViewModel: cellsViewModel,
            loading: loading.asObservable(),
            resetData: resetData,
            disposable: disposables
        )
    }

    func loadCharacters(loading: BehaviorSubject<LoadingState>,
                        number: Int,
                        name: String? = nil) -> Observable<[CharacterViewModel]> {
        repository.getCharacters(id: nil, number: number, name: name)
            .map { characters in
                characters.map { character in CharacterViewModel(character: character) }
            }
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .do(onSuccess: { _ in
                loading.onNext(LoadingState.normal)
            },
                onError: { _ in loading.onNext(LoadingState.error) },
                onSubscribed: {
                loading.onNext(LoadingState.loading)
            })
            .catchErrorJustReturn([])
            .asObservable()
    }
}
