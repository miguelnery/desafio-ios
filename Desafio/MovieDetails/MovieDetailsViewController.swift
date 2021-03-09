import UIKit


class MovieDetailsViewController: UIViewController {
    private let detailsView = MovieDetailsView()
    private let movieViewModel: MovieViewModel

    init(movieViewModel: MovieViewModel) {
        self.movieViewModel = movieViewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = detailsView
    }

}

class MovieDetailsView: UIView {

    init() {
        super.init(frame: .zero)
        backgroundColor = .red
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
