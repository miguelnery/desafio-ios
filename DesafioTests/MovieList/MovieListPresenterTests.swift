import XCTest
@testable import Desafio

class MovieListPresenterTests: XCTestCase {
    let decodableFetcherMock = DecodableAPIFethcerTypeMock<MovieApiResults>()
    lazy var sut = {
        MovieListPresenter(fetcher: decodableFetcherMock)
    }()
    let validMovies = [
        Movie(title: "validTitle1", posterPath: "validPath1"),
        Movie(title: "validTitle2", posterPath: "validPath2"),
        Movie(title: "validTitle3", posterPath: "validPath3")
    ]
    lazy var validMovieApiResults: MovieApiResults = {MovieApiResults(results: validMovies)}()

    lazy var resultingViewModels: [MovieViewModel] = { validMovies.map(MovieViewModel.init) }()

    func test_onSuccessProvideMovieViewModels() {
        decodableFetcherMock.succeed(with: validMovieApiResults)
        sut.getPopularMovies { result in
            switch result {
            case .success(let viewModels):
                XCTAssert(viewModels == self.resultingViewModels)
            case .failure(let error):
                XCTFail()
            }
        }
    }
}
