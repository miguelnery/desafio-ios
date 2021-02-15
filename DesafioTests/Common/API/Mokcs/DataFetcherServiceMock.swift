import Foundation
@testable import Desafio

enum Ass: Error {
    case hue
}

class DataFetcherServiceMock: DataFetcherService {
    private var shouldSucceed = false
    private var data: Data?
    private var error: Ass?

    func succeed<T: Encodable>(with model: T) {
        guard let data = try? JSONEncoder().encode(model) else {
            fatalError("Failed to encode model")
        }
        shouldSucceed = true
        self.data = data
    }

    func fail(with error: Ass) {
        shouldSucceed = false
        self.error = error
    }

    func fetch(from url: URL, _ completion: @escaping (Result<Data, Error>) -> Void) {
        if shouldSucceed, let data = self.data {
            completion(.success(data))
        } else if !shouldSucceed, let error = error {
            completion(.failure(error))
        } else { fatalError("No success condition defined or value provided for mock. Call succeed(with:) or fail(with:) before calling fetch(from:completion:)") }
    }
}
