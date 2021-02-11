import UIKit

class MovieListCollectionCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()

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
            self.titleLabel.text = model.title
        }
    }
}

extension MovieListCollectionCell: ViewCode {
    func addViews() {
        addSubview(imageView)
        addSubview(titleLabel)
    }

    func addConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().multipliedBy(0.7)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
