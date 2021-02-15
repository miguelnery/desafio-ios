import Foundation

struct MovieViewModel {
    let title: String
    let posterURL: URL

    init(movie: Movie) {
        self.title = movie.title
        self.posterURL = TMDBAPI.image(path: movie.posterPath).url
    }
}
