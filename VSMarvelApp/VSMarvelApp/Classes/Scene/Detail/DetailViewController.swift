
import UIKit
import VCore

class DetailViewController: UIViewController {
    let detailView = DetailView(frame: UIScreen.main.bounds)
    let viewModel: DetailViewModel

    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = detailView
        detailView.setupLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        Data: do {
            title = viewModel.title
            detailView.setup(viewModel: viewModel)
        }
    }
}
