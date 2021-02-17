import Foundation
@testable import Desafio

class DecodableAPIFethcerTypeMock<Model: Decodable>: DecodableAPIFethcerType {

    private var shouldSucceed = false
    private var model: Model?
    private var error: Ass?

    func succeed(with model: Model) {
        shouldSucceed = true
        self.model = model
    }

    func fail(with error: Ass) {
        shouldSucceed = false
        self.error = error
    }

    func fetch<T: Decodable>(from url: URL, _ completion: @escaping (Result<T, Error>) -> Void) {
        if shouldSucceed, let model = self.model {
            guard Model.self == T.self else { fatalError("Provided Model type must be the same as expected on fetch's generic parameter T") }
            completion(.success(model as! T))
        } else if !shouldSucceed, let error = error {
            completion(.failure(error))
        } else { fatalError("No success condition defined or value provided for mock. Call succeed(with:) or fail(with:) before calling fetch(from:completion:)") }
    }
}
