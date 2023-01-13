import Foundation

protocol HomeServicing {
    func getTopRated() async -> Result<TopRatedModel, NetworkError>
}

actor HomeService {
    private let service: ApiRequestServing
    
    init(service: ApiRequestServing = ApiRequestService()) {
        self.service = service
    }
}

extension HomeService: HomeServicing {
    func getTopRated() async -> Result<TopRatedModel, NetworkError> {
        return await service.fetchMovies(endpoint: MoviesEndpoint.topRated, with: TopRatedModel.self)
    }
}
