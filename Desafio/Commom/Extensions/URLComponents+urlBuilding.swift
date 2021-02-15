import Foundation


extension URLComponents {
    func with(path: String) -> URLComponents {
        var new = self
        new.path = path
        return new
    }

    func with(queryItems: [URLQueryItem]) -> URLComponents {
        var new = self
        new.queryItems = queryItems
        return new
    }

    func appending(queryItems: [URLQueryItem]) -> URLComponents {
        guard self.queryItems != nil else { return self.with(queryItems: queryItems) }
        var new = self
        new.queryItems?.append(contentsOf: queryItems)
        return new
    }
}
