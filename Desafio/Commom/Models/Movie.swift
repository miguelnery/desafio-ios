import UIKit

struct Movie: Codable, Equatable {
    let title: String
    let posterPath: String
    let overview: String
    let releaseDate: String
    let genreIds: [Int]
}

extension Movie {
    struct MovieApiResults: Codable {
        let results: [Movie]
    }

    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}

struct Genre: Codable, Equatable {
    let id: Int
    let name: String
}

extension Genre {
    struct GenreApiResults: Codable {
        let genres: [Genre]
    }
}
