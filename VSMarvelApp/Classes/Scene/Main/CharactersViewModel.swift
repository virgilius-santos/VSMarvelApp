
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
    
    var orderBy: MarvelAPI.QueryKeys {
        MarvelAPI.QueryKeys.orderBy(type: MarvelAPI.OrderType.name(ascendent: true))
    }
    
    func bind(input: CharactersInput) -> CharactersOutput {
        
        let loading = PublishSubject<DSLoadingState>()
        
        let load = self.loadCharacters(loading: loading)
        
        input.currentIndex
            .debug("currentIndex")
            .subscribe()
        
        input.text
            .debug("text")
            .subscribe()
        
        input.reload
            .debug("reload")
            .subscribe()
        
        
        return CharactersOutput(
            cellViewModel: load,
            loading: loading.asObservable()
        )
    }
    
    func loadCharacters(loading: PublishSubject<DSLoadingState>) -> Observable<[CharacterViewModel]> {
        
        return repository.getCharacters(queries: [])
            .map { characters in
                characters.map { character in CharacterViewModel(character: character) }
        }
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
        .observeOn(MainScheduler.instance)
        .do(onSuccess: { _ in loading.onNext(DSLoadingState.normal) },
            onError: { _ in loading.onNext(DSLoadingState.error) },
            onSubscribe: { loading.onNext(DSLoadingState.loading) })
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
}
