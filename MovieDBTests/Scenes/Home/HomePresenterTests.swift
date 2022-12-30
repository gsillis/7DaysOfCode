import XCTest
@testable import MovieDB

fileprivate final class HomeViewControllerSpy: HomeViewControllerDisplaying {
    private(set) var startLoadingCallsCount: Int = 0
    
    func startLoading() {
        startLoadingCallsCount += 1
    }
    
    private(set) var stopLoadingCallsCount: Int = 0
    
    func stopLoading() {
        stopLoadingCallsCount += 1
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
        
        sut.stopLoading()
        
        XCTAssertEqual(homeViewControllerSpy.stopLoadingCallsCount, 1)
    }
    
    func testStarLoading_WhenCalled_ShouldCallStarLoading() {
        let (sut, homeViewControllerSpy) = makeSut()
        
        sut.startLoading()
        
        XCTAssertEqual(homeViewControllerSpy.startLoadingCallsCount, 1)
    }
}
