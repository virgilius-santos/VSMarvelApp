
import CollectionKit
import RxCocoa
import RxSwift
import UIKit

final class CharactersCollectionViewProvider<CharacterView: UIView> where CharacterView: CharacterViewStyleable {
    let dataSource: ArrayDataSource<CharacterViewModel>

    let viewSource: ClosureViewSource<CharacterViewModel, CharacterView>

    let currentIndex: Observable<Int>

    let sizeSource: (Int, CharacterViewModel, CGSize) -> CGSize

    let provider: BasicProvider<CharacterViewModel, CharacterView>

    init(
        sizeSource: @escaping ((CGSize) -> CGSize),
        tapHandler: @escaping ((CharacterViewModel) -> Void)
    ) {
        let currentIndex = BehaviorRelay<Int>(value: 0)
        self.currentIndex = currentIndex.asObservable()

        viewSource = ClosureViewSource<CharacterViewModel, CharacterView>(
            viewUpdater: { (view: CharacterView, data: CharacterViewModel, index: Int) in
                currentIndex.accept(index)
                view.setup(data)
            }
        )

        dataSource = ArrayDataSource<CharacterViewModel>(
            data: [],
            identifierMapper: { (_: Int, data: CharacterViewModel) in data.name }
        )

        self.sizeSource = { (_: Int, _: CharacterViewModel, size: CGSize) -> CGSize in
            sizeSource(size)
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
