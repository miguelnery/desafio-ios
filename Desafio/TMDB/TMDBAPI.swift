import Foundation
import hoNetwork

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
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
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

struct TMDBMovieEndpoint: Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}

extension TMDBMovieEndpoint {
    private static let apiKey = "eb8f32bbe0d7f957729c0f26080650dc"

    static func popular(language: String = "pt-BR") -> TMDBMovieEndpoint {
        TMDBMovieEndpoint(path: "/3/movie/popular",
                          queryItems: [
                            URLQueryItem(name: "api_key", value: apiKey),
                            URLQueryItem(name: "language", value: language)
        ])
    }

    static func genres(language: String = "pt-BR") -> TMDBMovieEndpoint {
        TMDBMovieEndpoint(path: "/3/genre/movie/list",
                          queryItems: [
                            URLQueryItem(name: "api_key", value: apiKey),
                            URLQueryItem(name: "language", value: language)
        ])
    }
}

struct TMDBImageEndPoint: Endpoint {
    var path: String
    var queryItems: [URLQueryItem]
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "image.tmdb.org"
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}

extension TMDBImageEndPoint {
    func image(path: String, language: String = "pt-BR") -> TMDBImageEndPoint {
        TMDBImageEndPoint(path: "/t/p/w500" + path,
                          queryItems: [])
    }
}
