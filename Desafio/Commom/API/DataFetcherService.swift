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
