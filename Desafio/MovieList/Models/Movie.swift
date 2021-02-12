import UIKit


struct Movie: Codable {
    let poster_path: String
    let title: String
}

struct MovieApiResults: Codable {
    let results: [Movie]
}
