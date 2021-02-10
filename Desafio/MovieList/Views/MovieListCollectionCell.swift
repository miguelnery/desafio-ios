import UIKit

class MovieListCollectionCell: UICollectionViewCell {
    var imageView: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieListCollectionCell: ReusableCollectionViewCell {
    typealias Model = Movie
    static var reuseIdentifier = "MovieListCollectionCell"

    func setup(with model: Movie) {
        DispatchQueue.main.async {
            self.imageView.image = model.image
        }
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

