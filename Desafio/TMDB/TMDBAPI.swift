import Foundation

enum TMDBAPI {
    case popular
    case image(path: String)

    var url: URL {
        switch self {
        case .popular:
            return TMDBAPI
                .makePopularComponents()
                .url!

        case .image(let path):
            return TMDBAPI
                .makeImageComponents(imagePath: path)
                .url!
        }
    }
}

extension TMDBAPI {
    private static let popularPath = "/3/movie/popular"
    private static let getImagePath = "/t/p/w500"
    private static let defaultLanguage = "pt-BR"
    private static let apiKeyQueryItem = URLQueryItem(name: "api_key", value: "eb8f32bbe0d7f957729c0f26080650dc")

    private static func makeMovieComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        return components
    }

    private static func makePopularComponents() -> URLComponents {
        return makeMovieComponents()
            .with(path: popularPath)
            .with(queryItems: [
                makeLanguageQueryItem(),
                apiKeyQueryItem
            ])
    }

    private static func makeImageComponents(imagePath: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "image.tmdb.org"
        
        return components
            .with(path: getImagePath + imagePath)
    }

    private static func makeLanguageQueryItem(language: String = defaultLanguage) -> URLQueryItem {
        return URLQueryItem(name: "language", value: language)
    }
}

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
}
