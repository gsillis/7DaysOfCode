import XCTest
@testable import MovieDB

fileprivate final class HomePresenterSpy: HomePresenting {
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
    
    private(set) var selectedMovieCallsCount = 0
    private(set) var selectedMovie: MovieModel?
    
    func selectedMovie(_ movie: MovieDB.MovieModel) {
        selectedMovieCallsCount += 1
        selectedMovie = movie
    }
}

fileprivate final class HomeServiceSpy: HomeServicing {
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
        
        await sut.getTopRated()
        
        let count =  doubles.homeServiceSpy.getTopRatedCallsCount
        XCTAssertEqual(count, 1)
    }
    
    func testGetTopRated_WhenCalled_ShouldCallStopLoading() async {
        let (sut, doubles) = makeSut()
        
        await sut.getTopRated()
        
        DispatchQueue.main.async {
            XCTAssertEqual(doubles.presenterSpy.stopLoadingCallsCount, 1)
            XCTAssertTrue(doubles.presenterSpy.shouldHidden)
        }
    }
    
    func testGetTopRated_WhenRequestSucceeds_ShouldAppendDataToMoviesArray() async {
        let (sut, _) = makeSut()
        
        await sut.getTopRated()

        XCTAssertNotNil(sut.numberOfRows)
    }
    
    func testSelectMovieAtIndexPath_WhenCalledWithAnIndexPath_ShouldReturnAMovieModel() async {
        let (sut, doubles) = makeSut()
        
        let expectedMovie = MovieModel.fixture()
        
        await sut.getTopRated()
        
        let indexPath = IndexPath(row: 0, section: 0)

        sut.selectMovie(at: indexPath)
        

        XCTAssertEqual(doubles.presenterSpy.selectedMovieCallsCount, 1)
        XCTAssertEqual(doubles.presenterSpy.selectedMovie, expectedMovie)
    }
}
