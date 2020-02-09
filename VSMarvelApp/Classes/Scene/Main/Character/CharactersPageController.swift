
import Foundation
import RxCocoa
import RxSwift

final class CharactersPageController {
    let disposeBag = DisposeBag()
    let cellsViewModel = BehaviorSubject<[CharacterViewModel]>(value: [])
    let currentPage = BehaviorSubject<Int>(value: 0)
    let currentIndex = PublishSubject<Int>()
    let currentFilter = BehaviorSubject<String?>(value: nil)
    let loading = BehaviorSubject<LoadingState>(value: LoadingState.loading)
    let resetData = PublishSubject<Void>()

    var provider: ((
        _ loading: BehaviorSubject<LoadingState>,
        _ number: Int,
        _ name: String?
    ) -> Observable<CharactersViewModelData>)? {
        didSet { loadData() }
    }

    init() {
        configureIndex()
        configureFilter()
    }

    func configureFilter() {
        let sharedFilter = currentFilter
            .share(replay: 1, scope: .whileConnected)
            .distinctUntilChanged()
            .debug("sharedFilter")

        sharedFilter
            .map { _ in }
            .bind(to: resetData)
            .disposed(by: disposeBag)

        sharedFilter
            .map { _ in [CharacterViewModel]() }
            .bind(to: cellsViewModel)
            .disposed(by: disposeBag)

        sharedFilter
            .map { _ in 0 }
            .bind(to: currentPage)
            .disposed(by: disposeBag)
    }

    func configureIndex() {
        currentIndex
            .withLatestFrom(currentPage, resultSelector: { ($0, $1) })
            .scan(0, accumulator: { oldPage, args in
                let (index, newPage) = args
                if index > oldPage, index % 20 > 15 {
                    return newPage + 20
                }
                return oldPage
            })
            .filter { $0 > 0 }
            .distinctUntilChanged()
            .bind(to: currentPage)
            .disposed(by: disposeBag)
    }

    func loadData() {
        guard let provider = provider else {
            return
        }
        Observable
            .combineLatest(currentPage, currentFilter)
            .flatMapLatest { [loading, provider] index, filter in
                provider(loading, index, filter)
            }
            .withLatestFrom(cellsViewModel, resultSelector: { $1 + $0 })
            .bind(to: cellsViewModel)
            .disposed(by: disposeBag)
    }
}
