import UIKit

struct Movie: Codable, Equatable {
    let title: String
    let posterPath: String
}

struct MovieApiResults: Codable {
    let results: [Movie]
}
