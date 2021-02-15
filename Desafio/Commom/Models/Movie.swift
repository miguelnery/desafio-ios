import UIKit

struct Movie: Codable {
    let title: String
    let posterPath: String
}

struct MovieApiResults: Codable {
    let results: [Movie]
}
