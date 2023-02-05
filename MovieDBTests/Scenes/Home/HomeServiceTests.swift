import Foundation
@testable import MovieDB
import XCTest

fileprivate final class ApiRequestServiceMock: ApiRequestServing {
    private(set) var fetchMoviesCallsCount: Int = 0
    private(set) var endpoint: MovieDB.Endpoint?
    var result: Result<TopRatedModel, NetworkError> = .success(TopRatedModel.fixture())
    
    func fetchMovies<T>(endpoint: MovieDB.Endpoint, with model: T.Type) async -> Result<T, NetworkError> where T : Decodable {
        fetchMoviesCallsCount += 1
        self.endpoint = endpoint
        return result as! Result<T, NetworkError>
    }
}

final class HomeServiceTests: XCTestCase {
    private func makeSut() -> (ApiRequestServiceMock, HomeService) {
        let apiRequestServiceMock = ApiRequestServiceMock()
        let sut = HomeService(service: apiRequestServiceMock)
        return (apiRequestServiceMock, sut)
    }
    
    func testTopRated_WhenCalled_ShouldCallFetchMovies_WithCorretEndpointAndModel() async {
        let (apiRequestServiceMock, sut) = makeSut()
            
        let expectedEndpoint = MoviesEndpoint.topRated
        
        _ = await sut.getTopRated()
                
        XCTAssertEqual(apiRequestServiceMock.fetchMoviesCallsCount, 1)
        XCTAssertEqual(apiRequestServiceMock.endpoint?.path, expectedEndpoint.path)
    }
}
