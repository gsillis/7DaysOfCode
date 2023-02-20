@testable import MovieDB
import XCTest

final class HomeCoordinatorTests: XCTestCase {
    private func makeSut() -> (HomeCoordinator, MockNavigationController) {
        let sut = HomeCoordinator()
        let mockViewController = UIViewController()
        sut.viewController = mockViewController
            
        let navigationControllerSpy = MockNavigationController(rootViewController: mockViewController)
            
        return (sut, navigationControllerSpy)
    }
    
    func testShowDetails_WhenCalledFromPresenter_ShouldPushDetailViewController_WithCorrectMovie() {
        let (sut, navigationControllerSpy) = makeSut()
        
        let expectedMovie = MovieModel.fixture()
        
        sut.showDetails(with: expectedMovie)
        
        XCTAssertEqual(navigationControllerSpy.pushViewControllerCallsCount, 2)
        XCTAssertTrue(navigationControllerSpy.pushedViewController is MovieDetailViewController)
    }
}
