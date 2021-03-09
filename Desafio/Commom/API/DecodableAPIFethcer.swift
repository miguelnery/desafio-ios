import Foundation
import Combine

protocol DecodableAPIFethcerType {
    func fetch<T: Decodable>(from url: URL, _ completion: @escaping (Result<T, Error>) -> Void)
}

class DecodableAPIFethcer {
    private let dataService: DataFetcherService
    private let decoder: JSONDecoder

    init(dataService: DataFetcherService = URLSessionDataFetcherService(),
         decoder: JSONDecoder = JSONDecoder()) {
        self.dataService = dataService
        self.decoder = decoder

    }
}

extension DecodableAPIFethcer: DecodableAPIFethcerType {
    func fetch<T: Decodable>(from url: URL, _ completion: @escaping (Result<T, Error>) -> Void) {
        dataService.fetch(from: url) { result in
            if case .success(let data) = result,
                let model = try? self.decoder.decode(T.self, from: data) {
                completion(.success(model))
            } else if case .failure(let error) = result { completion(.failure(error)) }
        }
    }
}

class DecodableLoader {
    private let urlSession = URLSession.shared
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    func fetch<T: Decodable>(from url: URL,
                             type: T.Type,
                             decoder: JSONDecoder = .init()) -> AnyPublisher<T, Error> {
        urlSession
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: type, decoder: self.decoder)
            .eraseToAnyPublisher()
    }
}
