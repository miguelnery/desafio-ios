import UIKit


struct Movie {
    let image: UIImage
    let title: String

    init(image: UIImage = #imageLiteral(resourceName: "cat"), title: String = "bunda") {
        self.image = image
        self.title = title
    }
}

