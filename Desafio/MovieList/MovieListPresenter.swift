protocol MovieListPresenterType {
    func getPopularMovies(_ completion: @escaping (Result<[MovieViewModel], Error>) -> Void)
}

class MovieListPresenter {
    private let fetcher: DecodableAPIFethcerType

    init(fetcher: DecodableAPIFethcerType = DecodableAPIFethcer()) {
        self.fetcher = fetcher
    }
}

extension MovieListPresenter: MovieListPresenterType {
    func getPopularMovies(_ completion: @escaping (Result<[MovieViewModel], Error>) -> Void) {
        fetcher.fetch(from: TMDBAPI.popular.url) { (result: Result<MovieApiResults, Error>) in
            if case .success(let movieResults) = result {
                let viewModels = movieResults.results.map(MovieViewModel.init)
                completion(.success(viewModels))
            } else if case .failure(let error) = result {
                print("😡 fodeu")
            }
        }
    }
}

