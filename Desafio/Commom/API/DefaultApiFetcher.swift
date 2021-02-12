import Foundation

protocol DataFetcherService {
    func fetch(from url: URL, _ completion: @escaping (Result<Data, Error>) -> Void)
}

class URLSessionDataFetcherService {
    private let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
}

extension URLSessionDataFetcherService: DataFetcherService {
    func fetch(from url: URL, _ completion: @escaping (Result<Data, Error>) -> Void) {
        urlSession.dataTask(with: url) { (data, _, error) in
            if let data = data { completion(.success(data)) }
            else if let error = error { completion(.failure(error)) }
        }
    }
}

class DecodableAPIFethcer<T: Decodable> {
    private let dataService: DataFetcherService
    private let decoder: JSONDecoder

    init(dataService: DataFetcherService = URLSessionDataFetcherService(),
         decoder: JSONDecoder = JSONDecoder()) {
        self.dataService = dataService
        self.decoder = decoder

    }

    func fetch(from url: URL, _ completion: @escaping (Result<T, Error>) -> Void) {
        dataService.fetch(from: url) { result in
            if case .success(let data) = result,
                let model = try? self.decoder.decode(T.self, from: data) {
                completion(.success(model))
            } else if case .failure(let error) = result { completion(.failure(error)) }
        }
    }
}
