
import CollectionKit
import RxCocoa
import RxSwift
import UIKit

final class LoadingViewProvider {
    let dataSource: ArrayDataSource<LoadingState>

    let viewSource: ClosureViewSource<LoadingState, LoadingCell>

    let tap: Observable<Void>

    let sizeSource: (Int, LoadingState, CGSize) -> CGSize

    let provider: BasicProvider<LoadingState, LoadingCell>

    let disposeBag: DisposeBag

    init(
        sizeSource: @escaping (() -> CGSize)
    ) {
        let disposeBag = DisposeBag()
        self.disposeBag = disposeBag

        let tap = PublishRelay<Void>()
        self.tap = tap.asObservable()

        viewSource = ClosureViewSource<LoadingState, LoadingCell>(
            viewUpdater: { (view: LoadingCell, data: LoadingState, _: Int) in
                view.setup(data)
                view.errorButton.rx.tap.bind(to: tap).disposed(by: disposeBag)
            }
        )

        dataSource = ArrayDataSource<LoadingState>(
            data: [],
            identifierMapper: { (_: Int, data: LoadingState) in "\(data)" }
        )

        self.sizeSource = { (_: Int, _: LoadingState, _: CGSize) -> CGSize in
            sizeSource()
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
