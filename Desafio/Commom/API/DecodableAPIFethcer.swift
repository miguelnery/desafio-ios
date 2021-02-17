import Foundation

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
