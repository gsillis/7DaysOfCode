import Foundation

protocol HomeInteracting {
    func handleResult() async
    func viewDidLoad()
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
    func viewDidLoad() {
        presenter.startLoading(false)
    }
    
    func handleResult() async {
        let result = await service.getTopRated()
        DispatchQueue.main.async {
            self.presenter.stopLoading(true)
        }
        switch result {
        case .success(let data):
            print(data)
        case .failure(let error):
            print(error)
        }
    }
}
