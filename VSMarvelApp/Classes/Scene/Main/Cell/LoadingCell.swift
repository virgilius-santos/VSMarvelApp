
import SnapKit
import UIKit

enum LoadingState {
    case loading
    case error
    case normal
}

final class LoadingCell: UIView {
    let errorLabel: UILabel = {
        $0.isHidden = true
        $0.numberOfLines = 0
        $0.textAlignment = NSTextAlignment.center
        $0.adjustsFontForContentSizeCategory = true
        $0.font = UIFontMetrics(forTextStyle: UIFont.TextStyle.title3).scaledFont(for: $0.font)
        $0.text = "Erro baixando dados"
        return $0
    }(UILabel())

    let errorButton: UIButton = {
        $0.isHidden = true
        if let label = $0.titleLabel {
            label.adjustsFontForContentSizeCategory = true
            label.font = UIFontMetrics(forTextStyle: UIFont.TextStyle.title3)
                .scaledFont(for: label.font)
        }
        $0.setTitle("Tentar novamente", for: UIControl.State.normal)
        $0.setTitleColor(DSColor.textDarker.uiColor,
                         for: UIControl.State.highlighted)
        return $0
    }(UIButton())

    override init(frame: CGRect) {
        super.init(frame: frame)

        common()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(_ state: LoadingState) {
        switch state {
        case .loading:
            view(isLock: true)
            view(isHidden: true)
        case .error:
            view(isLock: false)
            view(isHidden: false)
        case .normal:
            view(isLock: false)
            view(isHidden: true)
        }
    }

    private func view(isHidden: Bool) {
        errorButton.isHidden = isHidden
        errorLabel.isHidden = isHidden
    }

    private func view(isLock: Bool) {
        if isLock { lock() }
        else { unlock() }
    }

    private func common() {
        addSubview(errorLabel)
        addSubview(errorButton)
        errorLabel.snp.makeConstraints {
            $0.top.greaterThanOrEqualToSuperview()
            $0.leading.trailing
                .equalTo(self)
                .inset(UIEdgeInsets(top: 0,
                                    left: DSSpacing.medium.value,
                                    bottom: 0,
                                    right: DSSpacing.medium.value))
        }
        errorButton.snp.makeConstraints {
            $0.top.equalTo(self.errorLabel.snp.bottom).offset(DSSpacing.small.value)
            $0.leading.trailing.equalTo(self.errorLabel)
            $0.bottom.lessThanOrEqualToSuperview()
        }
    }
}
