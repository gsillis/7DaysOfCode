import Foundation

protocol HomeInteracting {
    func handleResult()
}

final class HomeInteractor {
    private let presenter: HomePresenting
    private let service: HomeServicing
    
    init(presenter: HomePresenting, service: HomeServicing) {
        self.presenter = presenter
        self.service = service
    }
}

extension HomeInteractor: HomeInteracting {
    func handleResult() {
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
