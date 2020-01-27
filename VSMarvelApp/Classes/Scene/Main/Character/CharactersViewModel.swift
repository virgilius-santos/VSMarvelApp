
import UIKit
import RxSwift


protocol CharactersViewModel {
    var title: String { get }
    var rightButtonIcon: DSAsset  { get }
    var placeholderSearchBar: String  { get }
    var filterOptionsSearchBar: [String]  { get }
    
    var repository: CharactersRepositoryProtocol { get }
    
    func goTo(_ vm: CharacterViewModel)
    func switchView()
    func cellSize(from rect: CGRect) -> CGSize
}

extension CharactersViewModel {
    
    var repository: CharactersRepositoryProtocol { return CharactersRepository() }
    
    func bind(input: CharactersInput) -> CharactersOutput {
        
        let loading = BehaviorSubject<DSLoadingState>(value: DSLoadingState.loading)
        
        let loadNextPage = PublishSubject<Void>()
        let reloadNextPage = PublishSubject<Void>()
        
        let searchText = input.text
            .startWith((text: nil, filter: -1))
            .map { $0.text }
            .distinctUntilChanged()
            .share(replay: 1, scope: .whileConnected)
        
        let cellsViewModel = searchText
            .flatMapLatest { searchText in
                
                return loadNextPage
                    .asObservable()
                    .startWith(())
                    .scan(-1) { (pageNumber, _) -> Int in
                        pageNumber + 1
                }
                .map { pageNumber in
                    (searchText, pageNumber)
                }
        }
        .flatMapLatest { (searchText, pageNumber) in
            
            return reloadNextPage
                .asObservable()
                .startWith(())
                .map { (searchText, pageNumber) }
        }
        .flatMapLatest { [loadCharacters] (searchText, pageNumber) -> Observable<[CharacterViewModel]> in
             loadCharacters(loading, pageNumber, searchText)
        }
        
        let disposableNextPage = searchText
            .flatMapLatest { searchText in
                
                return input.currentIndex
                    .startWith(0)
                    .scan(0, accumulator: { ($0 < $1 && $1%19==0) ? $1 : $0 })
                    .distinctUntilChanged()
        }
        .subscribe(onNext: { _ in loadNextPage.onNext(()) })

        let resetData = searchText
            .map { _ in }
        
        let reloadDisposable = input.reload
            .subscribe(onNext: { _ in reloadNextPage.onNext(()) })
        
        let disposables = Disposables
            .create(disposableNextPage, reloadDisposable)

        return CharactersOutput(
            cellViewModel: cellsViewModel,
            loading: loading.asObservable(),
            resetData: resetData,
            disposable: disposables
        )
    }
    
    func loadCharacters(loading: BehaviorSubject<DSLoadingState>,
                        number: Int,
                        name: String? = nil) -> Observable<[CharacterViewModel]> {
        
        return repository.getCharacters(id: nil, number: number, name: name)
            .map { characters in
                characters.map { character in CharacterViewModel(character: character) }
        }
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
        .observeOn(MainScheduler.instance)
        .do(onSuccess: { _ in
            loading.onNext(DSLoadingState.normal) },
            onError: { _ in loading.onNext(DSLoadingState.error) },
            onSubscribed: {
                loading.onNext(DSLoadingState.loading) })
            .catchErrorJustReturn([])
            .asObservable()
    }
}

struct CharactersInput {
    let text: Observable<(text: String?, filter: Int)>
    let currentIndex: Observable<Int>
    let reload: Observable<Void>
}

struct CharactersOutput {
    let cellViewModel: Observable<[CharacterViewModel]>
    let loading: Observable<DSLoadingState>
    let resetData: Observable<Void>
    let disposable: Disposable
}
