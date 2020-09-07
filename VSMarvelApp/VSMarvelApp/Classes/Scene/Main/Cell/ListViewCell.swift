
import UIKit

final class ListViewCell: DSDynamicView {
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

extension ListViewCell: CharacterViewStyleable {
    static func cellSize(from size: CGSize) -> CGSize {
        let width: CGFloat = size.width - 2 * DSSpacing.xxSmall.value
        return CGSize(width: width, height: width / 3)
    }

    func apply(style: CharacterViewStyle) {
        apply(style: style, in: dsLabel)
    }

    func apply(style: CharacterViewStyle, in _: UILabel) {
        dsLabel.numberOfLines = 0
        dsLabel.tintColor = style.titleColor.uiColor
        dsLabel.backgroundColor = style.titleBackgroundColor
            .uiColor
            .withAlphaComponent(style.titleBackgroundAlpha.value)
    }

    func setup(_ vm: CharacterViewModel) {
        apply(style: vm.style)
        dsImageView.image = vm.asset.image
        dsImageView.cancelRequest()
        dsImageView.setImage(with: vm.path,
                             placeholder: vm.asset.image)
        dsImageView.heroID = vm.path
        dsLabel.text = "\(vm.name)\n\n\(vm.bio)"
    }
}
