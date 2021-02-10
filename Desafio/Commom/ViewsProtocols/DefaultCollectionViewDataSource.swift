import UIKit

class DefaultCollectionViewDataSource<Cell: ReusableCollectionViewCell, Model>: NSObject,UICollectionViewDataSource where Model == Cell.Model {

    var items: [Model] = []

    func attach(collection: UICollectionView) {
        collection.register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        collection.dataSource = self
    }

    // DATA SOURCE
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            return UICollectionViewCell()
        }
        cell.setup(with: items[indexPath.row])
        return cell
    }
}

protocol ReusableCollectionViewCell: UICollectionViewCell {
    associatedtype Model

    static var reuseIdentifier: String { get }
    func setup(with model: Model)
}
