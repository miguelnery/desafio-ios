import UIKit
import SnapKit


class MovieListViewController: UIViewController {
    private let movieListView = MovieListCollectionView(frame: .zero)
    private let dataSource = DefaultCollectionViewDataSource<MovieListCollectionCell, MovieViewModel>()
    private let presenter: MovieListPresenterType

    init(presenter: MovieListPresenterType = MovieListPresenter()) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = movieListView
    }

    override func viewDidLoad() {
        dataSource.attach(collection: movieListView)
        presenter.getPopularMovies { [dataSource] result in
            if case .success(let viewModels) = result {
                dataSource.items = viewModels
            } else { print ("🔥lascou") }
        }
    }
}
