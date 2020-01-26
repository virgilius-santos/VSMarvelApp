
import UIKit
import CollectionKit
import RxCocoa
import RxSwift

final class CharactersViewProvider<CharacterView: UIView> where CharacterView: CharacterViewProtocol {
    
    let dataSource: ArrayDataSource<CharacterViewModel>
    
    let viewSource: ClosureViewSource<CharacterViewModel, CharacterView>
    
    let currentIndex: Observable<Int>
    
    let sizeSource: ((Int, CharacterViewModel, CGSize) -> CGSize)
    
    let provider: BasicProvider<CharacterViewModel, CharacterView>
    
    init(
        sizeSource: @escaping(() -> CGSize),
        tapHandler: @escaping((CharacterViewModel) -> ())
    ) {
        
        let currentIndex = BehaviorRelay<Int>(value: 0)
        self.currentIndex = currentIndex.asObservable()
        
        viewSource = ClosureViewSource<CharacterViewModel, CharacterView>(
            viewUpdater: { (view: CharacterView, data: CharacterViewModel, index: Int) in
                currentIndex.accept(index)
                view.setup(data)
        })
        
        dataSource = ArrayDataSource<CharacterViewModel>(
            data: [],
            identifierMapper: { (index: Int, data: CharacterViewModel) in return data.name }
        )
        
        self.sizeSource = { (index: Int, data: CharacterViewModel, collectionSize: CGSize) -> CGSize in
            return sizeSource()
        }
        
        provider = BasicProvider(
            dataSource: dataSource,
            viewSource: viewSource,
            sizeSource: self.sizeSource,
            animator: WobbleAnimator()
        )
        
        let inset = UIEdgeInsets(top: DSSpacing.xxSmall.value,
                                 left: DSSpacing.xxSmall.value,
                                 bottom: DSSpacing.xxSmall.value,
                                 right: DSSpacing.xxSmall.value)
        
        provider.layout = FlowLayout(spacing: DSSpacing.xxSmall.value,
                                         justifyContent: JustifyContent.spaceAround)
            .inset(by: inset)
        
        provider.tapHandler = { context in
            tapHandler(context.data)
        }
    }
}
