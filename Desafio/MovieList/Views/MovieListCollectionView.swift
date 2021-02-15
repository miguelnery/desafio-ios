import UIKit

class MovieListCollectionView: UICollectionView {
    init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: frame, collectionViewLayout: layout)
        backgroundColor = .cyan
        delegate = self

    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieListCollectionView: UICollectionViewDelegateFlowLayout {
    /*
     |5 _ 42.5 _ 5 _ 42.5 _ 5| = 100
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = bounds.width * 0.425
        let cellHeight = bounds.height * 0.3
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // using bounds.width (instead of height) so the vertical and horizontal spacing are the same
        return bounds.width * 0.05
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0,
                            left: bounds.width * 0.05,
                            bottom: 0,
                            right: bounds.width * 0.05)
    }
}

