import Foundation

protocol HomeInteracting {
    func handlResult()
}

final class HomeInteractor {
    private let presenter: HomePresenting
    private let service: HomeServing
    
    init(presenter: HomePresenting, service: HomeServing) {
        self.presenter = presenter
        self.service = service
    }
}

extension HomeInteractor: HomeInteracting {
    func handlResult() {
        Task(priority: .background) {
            let result = await service.getTopRated()
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
