import UIKit
import SnapKit


class MovieListViewController: UIViewController {
    private let movieListView = MovieListCollectionView(frame: .zero)
    lazy var dataSource: MovieListCollectionDataSource = {
        return MovieListCollectionDataSource(collection: movieListView)
    }()

    override func loadView() {
        view = movieListView
        _ = dataSource
    }
}

class MovieListCollectionDataSource: NSObject, UICollectionViewDataSource {
    private let reuseIdentifier = "hue"

    init(collection: UICollectionView) {
        super.init()
        collection.register(MovieListCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collection.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MovieListCollectionCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}

class MovieListCollectionCell: UICollectionViewCell {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "cat"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieListCollectionCell: ViewCode {
    func addViews() {
        addSubview(imageView)
    }

    func addConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

class MovieListCollectionView: UICollectionView {
    init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: frame, collectionViewLayout: layout)
        backgroundColor = .cyan
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
