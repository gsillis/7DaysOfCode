import UIKit

protocol HomePresenting {
    func startLoading(_ shouldHidden: Bool)
    func stopLoading(_ shouldHidden: Bool)
    func selectedMovie(_ movie: MovieModel)
}

final class HomePresenter {
    weak var viewController: HomeViewControllerDisplaying?
    private let coordinator: HomeCoordinating
    
    init(coordinator: HomeCoordinating) {
        self.coordinator = coordinator
    }
}

extension HomePresenter: HomePresenting {
    func selectedMovie(_ movie: MovieModel) {
        coordinator.showDetails(with: movie)
    }
    
    func startLoading(_ shouldHidden: Bool) {
        viewController?.startLoading(shouldHidden)
    }
    
    func stopLoading(_ shouldHidden: Bool) {
        viewController?.stopLoading(shouldHidden)
    }
}
