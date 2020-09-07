
import UIKit
import VCore

class DetailViewController: UIViewController {
    let detailView = DetailView()
    let viewModel: DetailViewModel

    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        logger.info("fuii", String(describing: Self.self))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        Layout: do {
            view.backgroundColor = DSColor.secondary.uiColor
            view.addSubview(detailView)
            detailView.snp.makeConstraints {
                $0.edges.equalTo(self.view)
            }
            detailView.setupLayout()
        }

        Data: do {
            title = viewModel.title
            detailView.setup(viewModel: viewModel)
        }
    }
}
