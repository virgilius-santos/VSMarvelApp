
import UIKit
import VCore

final class GridViewCell: DSDynamicView {
    typealias ViewModelCell = CharacterViewModel

    let dsLabel = UILabel()
    let dsImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        common()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func common() {
        addCellSubViews()
    }

    func addCellSubViews() {
        addSubview(dsImageView)
        dsImageView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }

        addSubview(dsLabel)
        dsLabel.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(self)
        }
    }
}

extension GridViewCell: CharacterViewStyleable {
    static func cellSize(from size: CGSize) -> CGSize {
        let width: CGFloat = (size.width / 2) - 2 * DSSpacing.xxSmall.value
        return CGSize(width: width, height: width)
    }
}
