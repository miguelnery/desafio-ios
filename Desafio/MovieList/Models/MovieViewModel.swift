import Foundation

struct MovieViewModel: Equatable {
    let title: String
    let posterURL: URL
    let genres: [Genre]

    init(movie: Movie, genres: [Genre] = []) {
        self.title = movie.title
        self.posterURL = TMDBAPI.image(path: movie.posterPath).url
        self.genres = genres
    }
}
