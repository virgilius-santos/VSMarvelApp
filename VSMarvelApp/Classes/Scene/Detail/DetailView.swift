
import SnapKit
import UIKit
import VCore

final class DetailView: UIView {
    let scroll = UIScrollView()
    let contentView = UIView()
    let imageView = UIImageView()
    let descriptionLabel = UILabel()

    func setupLayout() {
        Scroll: do {
            addSubview(scroll)
            scroll.snp.makeConstraints {
                $0.edges.equalTo(self.safeAreaLayoutGuide)
            }
        }

        Content: do {
            scroll.addSubview(contentView)
            contentView.snp.makeConstraints {
                $0.edges.equalTo(self.scroll)
                $0.width.equalTo(self.scroll)
                $0.height.equalTo(self).priority(.medium)
            }
        }

        Image: do {
            contentView.addSubview(imageView)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.snp.makeConstraints {
                $0.top.leading.trailing.equalTo(self.contentView)
                $0.height.equalTo(self.imageView.snp.width)
            }
        }

        Label: do {
            descriptionLabel.numberOfLines = 0
            descriptionLabel.adjustsFontForContentSizeCategory = true
            descriptionLabel.font = UIFontMetrics(forTextStyle: UIFont.TextStyle.body)
                .scaledFont(for: descriptionLabel.font)
            contentView.addSubview(descriptionLabel)

            descriptionLabel.snp.makeConstraints {
                $0.top.equalTo(imageView.snp.bottom).offset(DSSpacing.medium.value)
                $0.leading.trailing.equalTo(self.contentView)
                $0.bottom.lessThanOrEqualTo(self.contentView)
            }
        }
    }

    func setup(viewModel: DetailViewModel) {
        descriptionLabel.text = viewModel.description
        imageView.setImage(with: viewModel.path, placeholder: DSImage.placeholder.image)
        imageView.heroID = viewModel.path
    }
}
