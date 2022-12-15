import Foundation

protocol HomeServing {
    func getTopRated() async -> Result<TopRatedModel, NetworkError>
}

final class HomeService {
    private let service: ApiRequestServing
    
    init(service: ApiRequestServing = ApiRequestService()) {
        self.service = service
    }
}

extension HomeService: HomeServing {
    func getTopRated() async -> Result<TopRatedModel, NetworkError> {
        return await service.fetchMovies(endpoint: MoviesEndpoint.topRated, with: TopRatedModel.self)
    }
}
