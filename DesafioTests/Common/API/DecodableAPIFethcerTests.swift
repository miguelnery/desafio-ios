import XCTest
@testable import Desafio

struct Cu: Codable, Equatable {
    let diameter: String

    init(diameter: String) {
        self.diameter = diameter
    }
}

class DecodableAPIFethcerTests: XCTestCase {
    let dataServiceMock = DataFetcherServiceMock()
    lazy var sut: DecodableAPIFethcer<Cu> = {
        return DecodableAPIFethcer(dataService: dataServiceMock)
    }()
    let validModel = Cu(diameter: "hue")
    let validURL = URL(fileURLWithPath: "hue")

    func test_onSuccessSendsDecodedModel() {
        dataServiceMock.succeed(with: validModel)
        sut.fetch(from: validURL) { result in
            if case .success(let model) = result {
                XCTAssert(model == self.validModel)
            } else { XCTFail() }
        }
    }

    func test_onFailureSendsError() {
        dataServiceMock.fail(with: .hue)
        sut.fetch(from: validURL) { result in
            if case .failure(let error) = result {
                let assError = error as! Ass
                XCTAssert(assError == Ass.hue)
            } else { XCTFail() }
        }
    }
}
