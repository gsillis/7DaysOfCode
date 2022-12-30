import XCTest
@testable import MovieDB

fileprivate final class HomePresenterSpy: HomePresenting {}

fileprivate actor HomeServiceSpy: HomeServicing {
    private(set) var getTopRatedCallsCount: Int = 0
    var result: Result<TopRatedModel, NetworkError> = .success(TopRatedModel.fixture())
    
    func getTopRated() async -> Result<TopRatedModel, NetworkError> {
        getTopRatedCallsCount += 1
        return result
    }
}

final class HomeInteractorTests: XCTestCase {
    private typealias Doubles = (presenterSpy: HomePresenterSpy, homeServiceSpy: HomeServiceSpy)
    
    private func makeSut() -> (HomeInteractor, Doubles) {
        let presenterSpy = HomePresenterSpy()
        let serviceSpy = HomeServiceSpy()
        let sut = HomeInteractor(presenter: presenterSpy, service: serviceSpy)
        let doubles = (presenterSpy, serviceSpy)
        return (sut, doubles)
    }
    
    func testHandleResult_WhenCalledFromViewController_ShouldCallGetTopRated() async {
        let (sut, doubles) = makeSut()
        await sut.handleResult()
        let count = await doubles.homeServiceSpy.getTopRatedCallsCount
        XCTAssertEqual(count, 1)
    }
}
