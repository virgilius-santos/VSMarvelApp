
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

    func apply(style: CharacterViewStyle) {
        apply(shadow: style.shadow)
        apply(style: style, in: dsLabel)
        layer.cornerRadius = style.cornerRadius.value
    }

    func apply(shadow: DSShadow) {
        layer.shadowColor = shadow.shadowColor.uiColor.cgColor
        layer.shadowOpacity = Float(shadow.shadowOpacity.value)
        layer.shadowOffset = .zero
        layer.shadowRadius = shadow.shadowRadius.value
    }

    func apply(style: CharacterViewStyle, in _: UILabel) {
        dsLabel.textAlignment = NSTextAlignment.center
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
        dsLabel.text = vm.name
    }
}
