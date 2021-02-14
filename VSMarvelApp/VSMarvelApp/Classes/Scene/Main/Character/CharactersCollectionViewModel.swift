
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

final class CharactersCollectionViewModel: CharactersCollectionViewModelProtocol {
    struct ViewModelType: Equatable {
        static let list = ViewModelType(iconToSwitch: DSIcon.gridIcon)
        static let grid = ViewModelType(iconToSwitch: DSIcon.listIcon)

        let iconToSwitch: DSAsset

        static func == (lhs: ViewModelType, rhs: ViewModelType) -> Bool {
            lhs.iconToSwitch.name == rhs.iconToSwitch.name
                && lhs.iconToSwitch.image == rhs.iconToSwitch.image
        }
    }

    var rightButtonIcon: DSAsset { viewModelType.iconToSwitch }

    var repository: CharactersRepositoryProtocol { CharactersRepository() }

    var title: String { "Characters" }

    var placeholderSearchBar: String { "Type something here..." }

    // TODO: Pending ["Title", "Genre", "Rating", "Actor"]
    var filterOptionsSearchBar: [String] { [String]() }

    var viewModelType: ViewModelType

    var switchToList: ((_ vm: CharactersCollectionViewModel) -> Void)?
    var switchToGrid: ((_ vm: CharactersCollectionViewModel) -> Void)?
    var goToDetail: ((_ vm: CharacterViewModel) -> Void)?

    var switchAction: ((_ vm: CharactersCollectionViewModel) -> Void)?

    let pageController = CharactersPageController()

    init(
        type: ViewModelType,
        switchAction: ((_ vm: CharactersCollectionViewModel) -> Void)? = nil
    ) {
        viewModelType = type
        self.switchAction = switchAction
        pageController.provider = loadCharacters
    }

    func switchView() {
        switchAction?(self)
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
                disposableNextFilter
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
            .map { $0.map { character in
                CharacterViewModel(
                    character: character,
                    label: character.name,
                    style: .grid
                )
            }
            }
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
            .do(onSuccess: { _ in loading.onNext(LoadingState.normal) },
                onError: { _ in loading.onNext(LoadingState.error) },
                onSubscribed: { loading.onNext(LoadingState.loading) })
            .catchAndReturn([])
            .asObservable()
    }
}
