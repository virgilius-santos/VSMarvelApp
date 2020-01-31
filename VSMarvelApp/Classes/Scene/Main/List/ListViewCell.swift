
import UIKit

final class ListViewCell: DSDynamicView, CharacterViewStyleable {
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
            $0.top.bottom.leading.equalTo(self)
            $0.height.equalTo(self.dsImageView.snp.width)
        }

        addSubview(dsLabel)
        dsLabel.snp.makeConstraints {
            $0.top.equalTo(self).offset(DSSpacing.medium.value)
            $0.trailing.equalTo(self).offset(-DSSpacing.medium.value)
            $0.leading.equalTo(self.dsImageView.snp.trailing).offset(DSSpacing.medium.value)
            $0.bottom.lessThanOrEqualTo(self).offset(-DSSpacing.medium.value)
        }
    }
}
