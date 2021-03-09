import Foundation
import hoNetwork
import Combine


protocol MovieStoreType {
    func loadPopularMovies() -> AnyPublisher<[Movie], NetworkError>
}

class MovieStore {
    typealias Result = Movie.MovieApiResults
    private let fetcher: DecodableFectherType

    init(fetcher: DecodableFectherType = DecodableFecther()) { self.fetcher = fetcher }
}

extension MovieStore: MovieStoreType {
    func loadPopularMovies() -> AnyPublisher<[Movie], NetworkError> {
        fetcher
            .fetchDecodable(fromEndpoint: TMDBMovieEndpoint.popular(),
                            decoder: Movie.decoder)
            .map { (result: Result) in result.results }
            .eraseToAnyPublisher()
    }
}

protocol GenreStoreType {
    func loadGenres() -> AnyPublisher<[Genre], NetworkError>
}

class GenreStore {
    typealias Result = Genre.GenreApiResults
    private let fetcher: DecodableFectherType

    init(fetcher: DecodableFectherType = DecodableFecther()) { self.fetcher = fetcher }
}

extension GenreStore: GenreStoreType {
    func loadGenres() -> AnyPublisher<[Genre], NetworkError> {
        fetcher.fetchDecodable(fromEndpoint: TMDBMovieEndpoint.genres(),
                               decoder: JSONDecoder())
    }
}

protocol MovieViewModelStoreType {
    func loadViewModels() -> AnyPublisher<[MovieViewModel], NetworkError>
}

class MovieViewModelStore {
    private let movieStore: MovieStoreType
    private let genreStore: GenreStoreType
    private let adapter = MovieViewModelAdapter2()

    init(movieStore: MovieStoreType = MovieStore(),
         genreStore: GenreStoreType = GenreStore()) {
        self.movieStore = movieStore
        self.genreStore = genreStore
    }
}

extension MovieViewModelStore: MovieViewModelStoreType {
    func loadViewModels() -> AnyPublisher<[MovieViewModel], NetworkError> {
        movieStore.loadPopularMovies()
            .flatMap { movies in self.genreStore.loadGenres()
                .flatMap { genres in self.adapter.adapt(movies: movies, genres: genres)}
        }
        .eraseToAnyPublisher()
    }
}

class MovieViewModelAdapter2 {
    func adapt(movies: [Movie], genres: [Genre]) -> AnyPublisher<[MovieViewModel], NetworkError> {
        movies.publisher
            .setFailureType(to: NetworkError.self)
            .map { adapt(movie: $0, genres: genres) }
            .collect()
            .eraseToAnyPublisher()
    }

    private func adapt(movie: Movie, genres: [Genre]) -> MovieViewModel {
        MovieViewModel(movie: movie,
                       genres: genres.filter { movie.genreIds.contains($0.id) })
    }
}
