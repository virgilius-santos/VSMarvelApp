
import UIKit
import CollectionKit
import RxCocoa
import RxSwift

final class LoadingViewProvider {
    
    let dataSource: ArrayDataSource<DSLoadingState>
    
    let viewSource: ClosureViewSource<DSLoadingState, DSLoadingView>
    
    let tap: Observable<Void>
    
    let sizeSource: ((Int, DSLoadingState, CGSize) -> CGSize)
    
    let provider: BasicProvider<DSLoadingState, DSLoadingView>
    
    let disposeBag: DisposeBag
    
    init(
        sizeSource: @escaping(() -> CGSize)
    ) {
        
        let disposeBag = DisposeBag()
        self.disposeBag = disposeBag
        
        let tap = PublishRelay<Void>()
        self.tap = tap.asObservable()
        
        viewSource = ClosureViewSource<DSLoadingState, DSLoadingView>(
            viewUpdater: { (view: DSLoadingView, data: DSLoadingState, index: Int) in
                view.setup(data)
                view.errorButton.rx.tap.bind(to: tap).disposed(by: disposeBag)
        })
        
        dataSource = ArrayDataSource<DSLoadingState>(
            data: [],
            identifierMapper: { (index: Int, data: DSLoadingState) in return "\(data)" }
        )
        
        self.sizeSource = { (index: Int, data: DSLoadingState, collectionSize: CGSize) -> CGSize in
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
    }
}
