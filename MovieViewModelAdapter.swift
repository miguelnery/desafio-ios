import Foundation
import honeyCache

protocol MovieViewModelAdapterType {
    func adapt(movie: [Movie], _ completion: @escaping (Result<[MovieViewModel], Error>) -> Void)
}

class MovieViewModelAdapter {
    typealias GenreID = Int
    private let decodableFetcher: DecodableAPIFethcerType
    private let genreCache = Cache<GenreID, Genre>()


    init(decodableFetcher: DecodableAPIFethcerType = DecodableAPIFethcer()) {
        self.decodableFetcher = decodableFetcher
    }
}

extension MovieViewModelAdapter: MovieViewModelAdapterType {
    func adapt(movie: [Movie], _ completion: @escaping (Result<[MovieViewModel], Error>) -> Void) {

    }


}
