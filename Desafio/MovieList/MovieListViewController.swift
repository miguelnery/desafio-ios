import UIKit
import SnapKit


class MovieListViewController: UIViewController {
    private let movieListView = MovieListCollectionView(frame: .zero)
    private let dataSource = DefaultCollectionViewDataSource<MovieListCollectionCell, Movie>()

    override func loadView() {
        view = movieListView
    }

    override func viewDidLoad() {
        dataSource.attach(collection: movieListView)
        dataSource.items = [Movie(),
                            Movie(),
                            Movie()]
        movieListView.reloadData()
    }
}
