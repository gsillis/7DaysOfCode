import XCTest
@testable import MovieDB

fileprivate final class HomePresenterSpy: HomePresenting {
    private(set) var startLoadingCallsCount: Int = 0
    
    func startLoading() {
        startLoadingCallsCount += 1
    }
    
    private(set) var stopLoadingCallsCount: Int = 0

    func stopLoading() {
        stopLoadingCallsCount += 1
    }
}

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
    
    func testViewDidLoad_WhenCalled_ShoulCallStartLoading() {
        let (sut, doubles) = makeSut()
        
        sut.viewDidLoad()
        
        XCTAssertEqual(doubles.presenterSpy.startLoadingCallsCount, 1)
    }
    
    func testHandleResult_WhenCalledFromViewController_ShouldCallGetTopRated() async {
        let (sut, doubles) = makeSut()
        
        await sut.handleResult()
        
        let count = await doubles.homeServiceSpy.getTopRatedCallsCount
        XCTAssertEqual(count, 1)
    }
    
    func testHandleResult_WhenGetTopRatedSucceeds_ShouldCallStopLoading() async {
        let (sut, doubles) = makeSut()
        
        await sut.handleResult()
        XCTAssertEqual(doubles.presenterSpy.stopLoadingCallsCount, 1)
    }
}
