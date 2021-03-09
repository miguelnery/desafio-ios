import Foundation
import Combine
import honeyCache
import hoNetwork

struct TMDBEndpoint: Endpoint {
    var path: String
    var queryItems: [URLQueryItem]
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"  
    }


}

class GenreLoader2 {
    private let fetcher: DecodableFectherType

    init(fetcher: DecodableFectherType) { self.fetcher = fetcher }


}


class GenreLoader {
    private let decodableLoader = DecodableLoader()
    private var cache = [Genre]()
    var subs: Set<AnyCancellable> = []
    var honey = Cache<String, [Genre]>()
    
    deinit {
        print("deinit genreLoader⛔️⛔️⛔️⛔️⛔️⛔️⛔️⛔️⛔️⛔️⛔️⛔️⛔️")
    }
    
    func getGenres() -> AnyPublisher<[Genre], Error> {
        return Future<[Genre], Error>() { promise in
            if let cache = self.honey["genres"] {
                promise(.success(cache))
            }
//            if !self.cache.isEmpty {
//                promise(.success(self.cache))
//            }
            else {
                let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=eb8f32bbe0d7f957729c0f26080650dc&language=pt-BR")!
                self.decodableLoader
                    .fetch(from: url, type: GenreApiResults.self)
                    .map(\.genres)
                    .handleEvents(receiveOutput: { genres in
                        self.honey["genres"] = genres
                        promise(.success(genres))
                    })
                    .sink(receiveCompletion: {_ in}, receiveValue: {_ in})
//                    .sink(receiveCompletion: { completion in
//                        if case .failure(let error) = completion {
//                            promise(.failure(error))
//                        }
//                    },
//                          receiveValue: { genres in
//                            promise(.success(genres))
//                            self.cache = genres
//                    })
                    .store(in: &self.subs)

            }
        }
        .eraseToAnyPublisher()
    }
    
}

class HueLoader {
    let loader = GenreLoader()
    
    func makeViewModels(from movies: [Movie]) -> AnyPublisher<[MovieViewModel], Error> {
        loader
            .getGenres()
            .flatMap { genres in
                movies
                    .publisher
                    .setFailureType(to: Error.self)
                    .flatMap { movie in
                        self.makeViewModel(from: movie, genres: genres)}
            }
            .collect()
            .eraseToAnyPublisher()
        //        movies.publisher
        //            .setFailureType(to: Error.self)
        //            .flatMap(makeViewModel(from:))
        //            .collect()
        //            .eraseToAnyPublisher()
    }
    
    private func makeViewModel(from movie: Movie, genres: [Genre]) -> AnyPublisher<MovieViewModel, Error> {
        loader
            .getGenres()
            // turn Publisher<[Genre], Error> into Publisher<Genre, Error> for simplicity
            .flatMap { $0.publisher.setFailureType(to: Error.self) }
            .filter { genre in movie.genreIds.contains(genre.id) }
            // turn back into Publisher<[Genre], Error>
            .collect()
            .map { genres in MovieViewModel(movie: movie, genres: genres) }
            .eraseToAnyPublisher()
    }
}

class MovieLoader {
    private let url = TMDBAPI.popular.url
    let loader = DecodableLoader()
    
    func loadPopular() -> AnyPublisher<[Movie], Error> {
        loader
            .fetch(from: url, type: MovieApiResults.self)
            .map(\.results)
            .eraseToAnyPublisher()
    }
}

//class Huezasso {
//    let cache = [Genre]()
//
//    init() {
//
//    }
//
//    func shit(movies: AnyPublisher<Movie, Never>) -> AnyPublisher<MovieViewModel, Never> {
//        guard cache.isEmpty else {
//            return movies.map { movie in
//                let genres = cache.filter { genre in movie.genreIds.contains(genre.id) }
//                return MovieViewModel(movie: movie, genres: genres)
//            }
//            .eraseToAnyPublisher()
//        }
//
//
//    }
//}
//
//
//
//class Huezao {
//    let fetcher = DecodableAPIFethcer()
//    var cache = [Genre]()
//
//    init() {
//        let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=eb8f32bbe0d7f957729c0f26080650dc&language=pt-BR")!
//        let dq = DispatchQueue(label: "hue", qos: .userInteractive)
//        let group = DispatchGroup()
//        group.enter()
//        dq.async {
//            self.fetcher.fetch(from: url) { (result: Result<GenreApiResults, Error>) in
//                if case .success(let results) = result {
//                    self.cache = results.genres
//                } else { print("🔥🔥🔥🔥🔥") }
//            }
//            group.leave()
//        }
//        group.notify(queue: .main) {
//            print(self.cache)
//        }
//    }
//
//    private func getGenres(for genreIds: [Int], from genres: [Genre]) -> [Genre] {
//        return genreIds.reduce([Genre]()) { result, id in
//            return genres.filter { $0.id == id } + result
//        }
//    }
//
//    func makeViewModel(from movie: Movie, _ completion: @escaping(MovieViewModel) -> Void) {
//        guard cache.isEmpty else {
//            let viewModel = MovieViewModel(movie: movie, genres: getGenres(for: movie.genreIds, from: cache))
//            completion(viewModel)
//            return
//        }
//        let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=eb8f32bbe0d7f957729c0f26080650dc&language=pt-BR")!
//        self.fetcher.fetch(from: url) { (result: Result<GenreApiResults, Error>) in
//            if case .success(let results) = result {
//                self.cache = results.genres
//                let viewModel = MovieViewModel(movie: movie, genres: self.getGenres(for: movie.genreIds, from: self.cache))
//                completion(viewModel)
//            } else { print("🔥🔥🔥🔥🔥") }
//        }
//    }
//
//    func makeViewModels(from movies: [Movie], _ completion: @escaping (Result<[MovieViewModel], Error>) -> Void) {
//    }
//
//}
