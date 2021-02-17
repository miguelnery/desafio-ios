import XCTest
@testable import Desafio

class DecodableAPIFethcerTests: XCTestCase {
    let dataServiceMock = DataFetcherServiceMock()
    lazy var sut: DecodableAPIFethcer = {
        return DecodableAPIFethcer(dataService: dataServiceMock)
    }()
    let validModel = Movie(title: "validTitle", posterPath: "validPath")
    let validURL = URL(fileURLWithPath: "hue")

    func test_onSuccessSendsDecodedModel() {
        dataServiceMock.succeed(with: validModel)
        sut.fetch(from: validURL) { (result: Result<Movie, Error>) in
            if case .success(let model) = result {
                XCTAssert(model == self.validModel)
            } else { XCTFail() }
        }
    }

    func test_onFailureSendsError() {
        dataServiceMock.fail(with: .hue)
        sut.fetch(from: validURL) { (result: Result<Movie, Error>) in
            if case .failure(let error) = result {
                let assError = error as! Ass
                XCTAssert(assError == Ass.hue)
            } else { XCTFail() }
        }
    }
}
