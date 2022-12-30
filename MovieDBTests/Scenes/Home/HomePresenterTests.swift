import XCTest
@testable import MovieDB

fileprivate final class HomeViewControllerSpy: HomeViewControllerDisplaying {
    private(set) var startLoadingCallsCount: Int = 0
    var shouldHidden = false
    
    func startLoading(_ shouldHidden: Bool) {
        startLoadingCallsCount += 1
        self.shouldHidden = shouldHidden
    }
    
    private(set) var stopLoadingCallsCount: Int = 0

    func stopLoading(_ shouldHidden: Bool) {
        stopLoadingCallsCount += 1
        self.shouldHidden = shouldHidden
    }
}

final class HomePresenterTests: XCTestCase {
    private func makeSut() -> (HomePresenter, HomeViewControllerSpy) {
        let homeViewControllerSpy = HomeViewControllerSpy()
        let sut = HomePresenter()
        sut.viewController = homeViewControllerSpy
        return (sut, homeViewControllerSpy)
    }
    
    func testStopLoading_WhenCalled_ShouldCallStopLoading() {
        let (sut, homeViewControllerSpy) = makeSut()
        
        sut.stopLoading(true)
        
        XCTAssertEqual(homeViewControllerSpy.stopLoadingCallsCount, 1)
        XCTAssertTrue(homeViewControllerSpy.shouldHidden)
    }
    
    func testStarLoading_WhenCalled_ShouldCallStarLoading() {
        let (sut, homeViewControllerSpy) = makeSut()
        
        sut.startLoading(false)
        
        XCTAssertEqual(homeViewControllerSpy.startLoadingCallsCount, 1)
        XCTAssertFalse(homeViewControllerSpy.shouldHidden)
    }
}
